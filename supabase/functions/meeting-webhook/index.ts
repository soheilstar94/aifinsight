import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.57.4';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  // Only allow POST requests for webhook data
  if (req.method !== 'POST') {
    return new Response('Method not allowed', { 
      status: 405, 
      headers: corsHeaders 
    });
  }

  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    );

    const meetingData = await req.json();
    console.log('Received meeting data:', meetingData);

    // Handle real-time transcript segments
    if (meetingData.speakerName && meetingData.transcript) {
      // Real-time transcript segment - create or update meeting
      const meetingTitle = `Meeting with ${meetingData.speakerName} - ${new Date(meetingData.timestamp).toLocaleDateString()}`;
      const transcriptSegment = {
        id: crypto.randomUUID(),
        speaker: meetingData.speakerName,
        timestamp: meetingData.timestamp,
        text: meetingData.transcript,
        words: meetingData.words || [],
        confidence: meetingData.confidence || null,
        duration: meetingData.duration || null,
        metadata: {
          originalData: meetingData // Store all original data for reference
        }
      };

      // Check if there's an existing meeting from today with the same speaker
      const today = new Date().toDateString();
      const { data: existingMeetings } = await supabase
        .from('meetings')
        .select('*')
        .ilike('title', `%${meetingData.speakerName}%`)
        .gte('date', new Date(today).toISOString())
        .order('created_at', { ascending: false })
        .limit(1);

      if (existingMeetings && existingMeetings.length > 0) {
        // Update existing meeting with new transcript segment
        const existingMeeting = existingMeetings[0];
        const updatedTranscript = [...(existingMeeting.transcript || []), transcriptSegment];
        
        const { data, error } = await supabase
          .from('meetings')
          .update({ 
            transcript: updatedTranscript,
            updated_at: new Date().toISOString()
          })
          .eq('id', existingMeeting.id)
          .select()
          .single();

        if (error) {
          console.error('Database update error:', error);
          throw new Error(`Database error: ${error.message}`);
        }

        console.log('Updated existing meeting:', data.id, 'with new transcript segment');
        return new Response(
          JSON.stringify({ 
            success: true, 
            meeting: data,
            action: 'updated',
            message: 'Transcript segment added to existing meeting'
          }),
          { 
            status: 200,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          }
        );
      } else {
        // Create new meeting for real-time segment
        const dbMeeting = {
          title: meetingTitle,
          date: meetingData.timestamp ? new Date(meetingData.timestamp).toISOString() : new Date().toISOString(),
          duration: null,
          participants: [{ name: meetingData.speakerName, role: 'speaker' }],
          tags: [],
          key_insights: [],
          status: 'processing',
          transcript_url: null,
          summary: null,
          stock_tickers: [],
          industries: [],
          transcript: [transcriptSegment],
          overview: null
        };

        // Insert new meeting into database
        const { data, error } = await supabase
          .from('meetings')
          .insert(dbMeeting)
          .select()
          .single();

        if (error) {
          console.error('Database error:', error);
          throw new Error(`Database error: ${error.message}`);
        }

        console.log('Successfully created new meeting:', data.id);
        return new Response(
          JSON.stringify({ 
            success: true, 
            meeting: data,
            action: 'created',
            message: 'New meeting created from transcript segment'
          }),
          { 
            status: 201,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          }
        );
      }
    }

    // Legacy format - validate required fields
    if (!meetingData.title) {
      throw new Error('Meeting title is required for complete meeting data');
    }

    const dbMeeting = {
      title: meetingData.title,
      date: meetingData.date ? new Date(meetingData.date).toISOString() : new Date().toISOString(),
      duration: meetingData.duration || null,
      participants: Array.isArray(meetingData.participants) ? meetingData.participants : [],
      tags: Array.isArray(meetingData.tags) ? meetingData.tags : [],
      key_insights: Array.isArray(meetingData.keyInsights) ? meetingData.keyInsights : [],
      status: meetingData.status || 'processed',
      transcript_url: meetingData.transcriptUrl || null,
      summary: meetingData.summary || null,
      stock_tickers: Array.isArray(meetingData.stockTickers) ? meetingData.stockTickers : [],
      industries: Array.isArray(meetingData.industries) ? meetingData.industries : [],
      transcript: Array.isArray(meetingData.transcript) ? meetingData.transcript : [],
      overview: meetingData.overview || null
    };

    // Insert meeting into database
    const { data, error } = await supabase
      .from('meetings')
      .insert(dbMeeting)
      .select()
      .single();

    if (error) {
      console.error('Database error:', error);
      throw new Error(`Database error: ${error.message}`);
    }

    console.log('Successfully created meeting:', data.id);

    return new Response(
      JSON.stringify({ 
        success: true, 
        meeting: data,
        message: 'Meeting transcript received and stored successfully'
      }),
      { 
        status: 201,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    );

  } catch (error) {
    console.error('Error processing meeting webhook:', error);
    
    return new Response(
      JSON.stringify({ 
        success: false,
        error: error.message || 'Internal server error'
      }),
      { 
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    );
  }
});