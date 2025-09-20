import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { Meeting } from '@/types/Meeting';

export const useMeetings = () => {
  const [meetings, setMeetings] = useState<Meeting[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchMeetings = async () => {
    try {
      setLoading(true);
      setError(null);

      const { data, error: fetchError } = await supabase
        .from('meetings')
        .select('*')
        .order('date', { ascending: false });

      if (fetchError) {
        throw fetchError;
      }

      // Transform database data to Meeting type
      const transformedMeetings: Meeting[] = (data || []).map(meeting => ({
        id: meeting.id,
        title: meeting.title,
        date: meeting.date,
        duration: meeting.duration || 0,
        participants: Array.isArray(meeting.participants) ? meeting.participants as any[] : [],
        tags: Array.isArray(meeting.tags) ? meeting.tags as any[] : [],
        keyInsights: Array.isArray(meeting.key_insights) ? meeting.key_insights as string[] : [],
        status: (meeting.status as Meeting['status']) || 'processed',
        transcriptUrl: meeting.transcript_url || undefined,
        summary: meeting.summary || undefined,
        stockTickers: Array.isArray(meeting.stock_tickers) ? meeting.stock_tickers as string[] : [],
        industries: Array.isArray(meeting.industries) ? meeting.industries as string[] : [],
        transcript: Array.isArray(meeting.transcript) ? meeting.transcript as any[] : [],
        overview: meeting.overview ? meeting.overview as any : undefined
      }));

      setMeetings(transformedMeetings);
    } catch (err) {
      console.error('Error fetching meetings:', err);
      setError(err instanceof Error ? err.message : 'Failed to fetch meetings');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchMeetings();

    // Set up real-time subscription
    const channel = supabase
      .channel('meetings-changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'meetings'
        },
        () => {
          fetchMeetings();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, []);

  return { meetings, loading, error, refetch: fetchMeetings };
};