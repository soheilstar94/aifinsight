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

    // Validate required fields
    if (!meetingData.title) {
      throw new Error('Meeting title is required');
    }

    // Transform the data to match our database schema
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