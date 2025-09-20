-- Create meetings table to store meeting data
CREATE TABLE public.meetings (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  duration INTEGER, -- duration in minutes
  participants JSONB DEFAULT '[]'::jsonb,
  tags JSONB DEFAULT '[]'::jsonb,
  key_insights JSONB DEFAULT '[]'::jsonb,
  status TEXT DEFAULT 'processed' CHECK (status IN ('processed', 'processing', 'failed')),
  transcript_url TEXT,
  summary TEXT,
  stock_tickers JSONB DEFAULT '[]'::jsonb,
  industries JSONB DEFAULT '[]'::jsonb,
  transcript JSONB DEFAULT '[]'::jsonb,
  overview JSONB,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.meetings ENABLE ROW LEVEL SECURITY;

-- Create policy to allow public access for webhook endpoint
CREATE POLICY "Allow public read access to meetings" 
ON public.meetings 
FOR SELECT 
USING (true);

CREATE POLICY "Allow public insert for meetings via webhook" 
ON public.meetings 
FOR INSERT 
WITH CHECK (true);

-- Create function to update timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- Create trigger for automatic timestamp updates
CREATE TRIGGER update_meetings_updated_at
BEFORE UPDATE ON public.meetings
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();