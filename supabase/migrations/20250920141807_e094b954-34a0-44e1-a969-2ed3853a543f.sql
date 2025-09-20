-- Add sample meetings with realistic data
INSERT INTO public.meetings (title, date, duration, participants, tags, key_insights, status, summary, stock_tickers, industries, transcript, overview) VALUES
(
  'Q4 Financial Review - Apple Inc.',
  '2024-12-15 10:00:00+00'::timestamptz,
  3600,
  '[
    {"name": "Tim Cook", "role": "CEO", "company": "Apple Inc."},
    {"name": "Luca Maestri", "role": "CFO", "company": "Apple Inc."},
    {"name": "Sarah Johnson", "role": "Analyst", "company": "Goldman Sachs"}
  ]'::jsonb,
  '[
    {"name": "Q4", "category": "topic"},
    {"name": "AAPL", "category": "stock"},
    {"name": "Technology", "category": "industry"}
  ]'::jsonb,
  '[
    "iPhone revenue exceeded expectations by 8%",
    "Services segment showed 15% YoY growth",
    "Strong performance in emerging markets",
    "Guidance for Q1 2025 raised"
  ]'::jsonb,
  'processed',
  'Apple reported strong Q4 results with iPhone revenue beating estimates. The company showed resilient performance across all product categories with particular strength in services and emerging markets. Management provided optimistic guidance for the upcoming quarter.',
  '["AAPL"]'::jsonb,
  '["Technology", "Consumer Electronics"]'::jsonb,
  '[
    {
      "id": "t1",
      "speaker": "Tim Cook",
      "timestamp": "2024-12-15T10:05:00Z",
      "text": "Good morning everyone. Thank you for joining us today for our Q4 earnings call. I am pleased to report that we have delivered exceptional results this quarter, with iPhone revenue exceeding our expectations by 8%. Our services business continues to show tremendous momentum with 15% year-over-year growth."
    },
    {
      "id": "t2", 
      "speaker": "Luca Maestri",
      "timestamp": "2024-12-15T10:07:30Z",
      "text": "Thank you Tim. From a financial perspective, our gross margin expanded to 46.2%, driven by favorable product mix and operational efficiencies. We generated $29.2 billion in operating cash flow this quarter, demonstrating the strength of our business model."
    },
    {
      "id": "t3",
      "speaker": "Sarah Johnson", 
      "timestamp": "2024-12-15T10:15:00Z",
      "text": "Tim, can you provide more color on the performance in China and other emerging markets? There have been concerns about competitive pressures in those regions."
    },
    {
      "id": "t4",
      "speaker": "Tim Cook",
      "timestamp": "2024-12-15T10:15:45Z", 
      "text": "Great question Sarah. We are seeing strong momentum in emerging markets, particularly in India where we grew over 30% year-over-year. In China, while there are competitive dynamics, our premium positioning and ecosystem continue to resonate with consumers."
    }
  ]'::jsonb,
  '{
    "summary": "Apple Q4 earnings call discussing strong financial performance and market outlook",
    "keyTopics": ["Q4 Results", "iPhone Performance", "Services Growth", "Emerging Markets", "Q1 Guidance"],
    "actionItems": ["Follow up on India expansion strategy", "Monitor China market trends", "Prepare Q1 guidance details"],
    "conclusions": ["Strong Q4 performance across all segments", "Services momentum continues", "Optimistic outlook for Q1 2025"]
  }'::jsonb
),
(
  'Tesla Cybertruck Production Update',
  '2024-12-10 14:30:00+00'::timestamptz,
  2400,
  '[
    {"name": "Elon Musk", "role": "CEO", "company": "Tesla"},
    {"name": "Drew Baglino", "role": "SVP Powertrain", "company": "Tesla"},
    {"name": "Michael Chen", "role": "Auto Analyst", "company": "Morgan Stanley"}
  ]'::jsonb,
  '[
    {"name": "Cybertruck", "category": "topic"},
    {"name": "TSLA", "category": "stock"},
    {"name": "Automotive", "category": "industry"},
    {"name": "Production", "category": "topic"}
  ]'::jsonb,
  '[
    "Cybertruck production ramping to 250,000 units annually by end of 2025",
    "New 4680 battery cells showing 15% energy density improvement",
    "Demand exceeds supply with over 2 million reservations",
    "Full self-driving capability rolling out to Cybertruck fleet"
  ]'::jsonb,
  'processed',
  'Tesla provided updates on Cybertruck production scaling, battery technology improvements, and autonomous driving capabilities. Strong demand continues with reservation backlog exceeding 2 million units.',
  '["TSLA"]'::jsonb,
  '["Automotive", "Electric Vehicles", "Technology"]'::jsonb,
  '[]'::jsonb,
  '{
    "summary": "Tesla Cybertruck production and technology update meeting",
    "keyTopics": ["Production Scaling", "Battery Technology", "Autonomous Driving", "Market Demand"],
    "actionItems": ["Monitor production ramp progress", "Track battery performance metrics", "Evaluate FSD rollout timeline"],
    "conclusions": ["Production on track for 250K annual capacity", "Strong consumer demand validated", "Technology differentiation maintained"]
  }'::jsonb
),
(
  'Microsoft Azure AI Strategy Session',
  '2024-12-08 09:00:00+00'::timestamptz,
  5400,
  '[
    {"name": "Satya Nadella", "role": "CEO", "company": "Microsoft"},
    {"name": "Scott Guthrie", "role": "EVP Cloud + AI", "company": "Microsoft"},
    {"name": "Amy Hood", "role": "CFO", "company": "Microsoft"},
    {"name": "Brad Smith", "role": "President", "company": "Microsoft"}
  ]'::jsonb,
  '[
    {"name": "Azure", "category": "topic"},
    {"name": "AI", "category": "topic"},
    {"name": "MSFT", "category": "stock"},
    {"name": "Cloud Computing", "category": "industry"}
  ]'::jsonb,
  '[
    "Azure revenue growth accelerating to 35% YoY driven by AI workloads",
    "Copilot adoption reaching 1 million paid seats",
    "Partnership with OpenAI generating $2B in annual revenue",
    "New sovereign AI clouds launching in 5 countries"
  ]'::jsonb,
  'processed',
  'Microsoft outlined aggressive AI strategy with Azure as the primary platform. Strong Copilot adoption and OpenAI partnership driving significant revenue growth in cloud services.',
  '["MSFT", "GOOGL", "AMZN"]'::jsonb,
  '["Cloud Computing", "Artificial Intelligence", "Software"]'::jsonb,
  '[]'::jsonb,
  '{
    "summary": "Microsoft AI strategy and Azure growth discussion",
    "keyTopics": ["Azure Growth", "Copilot Adoption", "OpenAI Partnership", "Sovereign AI"],
    "actionItems": ["Accelerate Copilot enterprise rollout", "Expand sovereign cloud presence", "Monitor competitive positioning"],
    "conclusions": ["AI driving substantial cloud growth", "Market leadership position strengthening", "Enterprise adoption exceeding expectations"]
  }'::jsonb
),
(
  'Goldman Sachs Market Outlook 2025',
  '2024-12-05 11:00:00+00'::timestamptz,
  4200,
  '[
    {"name": "David Solomon", "role": "CEO", "company": "Goldman Sachs"},
    {"name": "Denis Coleman", "role": "CFO", "company": "Goldman Sachs"},
    {"name": "Jan Hatzius", "role": "Chief Economist", "company": "Goldman Sachs"},
    {"name": "Peter Oppenheimer", "role": "Chief Global Equity Strategist", "company": "Goldman Sachs"}
  ]'::jsonb,
  '[
    {"name": "Market Outlook", "category": "topic"},
    {"name": "2025 Forecast", "category": "topic"},
    {"name": "GS", "category": "stock"},
    {"name": "Financial Services", "category": "industry"}
  ]'::jsonb,
  '[
    "S&P 500 target of 6,300 for end of 2025 (+12% from current levels)",
    "Fed expected to cut rates 3 more times in 2025",
    "Technology and healthcare sectors favored for outperformance",
    "Emerging markets positioned for 20% returns amid dollar weakness"
  ]'::jsonb,
  'processed',
  'Goldman Sachs presented bullish 2025 market outlook citing favorable monetary policy, corporate earnings growth, and selective sector opportunities. Recommended overweight positions in technology and emerging markets.',
  '["GS", "SPY", "QQQ", "VWO"]'::jsonb,
  '["Financial Services", "Investment Banking", "Asset Management"]'::jsonb,
  '[]'::jsonb,
  '{
    "summary": "Goldman Sachs 2025 market outlook and investment strategy",
    "keyTopics": ["Market Targets", "Fed Policy", "Sector Allocation", "Geographic Strategy"],
    "actionItems": ["Update client portfolios with 2025 allocations", "Prepare sector rotation strategies", "Monitor Fed communications"],
    "conclusions": ["Constructive market outlook for 2025", "Technology leadership expected to continue", "Emerging markets offer compelling value"]
  }'::jsonb
),
(
  'NVIDIA AI Chip Architecture Briefing',
  '2024-12-03 16:00:00+00'::timestamptz,
  3900,
  '[
    {"name": "Jensen Huang", "role": "CEO", "company": "NVIDIA"},
    {"name": "Colette Kress", "role": "CFO", "company": "NVIDIA"},
    {"name": "Ian Buck", "role": "VP Accelerated Computing", "company": "NVIDIA"},
    {"name": "Tim Tully", "role": "Chief Architect", "company": "NVIDIA"}
  ]'::jsonb,
  '[
    {"name": "AI Chips", "category": "topic"},
    {"name": "Architecture", "category": "topic"},
    {"name": "NVDA", "category": "stock"},
    {"name": "Semiconductors", "category": "industry"}
  ]'::jsonb,
  '[
    "Next-generation Blackwell architecture delivering 5x performance improvement",
    "Data center revenue projected to exceed $100B annually by 2026",
    "New partnerships with cloud hyperscalers for custom silicon",
    "Automotive AI platform generating $1B quarterly run rate"
  ]'::jsonb,
  'processed',
  'NVIDIA unveiled next-generation AI chip architecture with significant performance improvements. Strong demand from data center customers driving revenue projections above $100B annually.',
  '["NVDA", "AMD", "INTC"]'::jsonb,
  '["Semiconductors", "Artificial Intelligence", "Data Centers"]'::jsonb,
  '[
    {
      "id": "t1",
      "speaker": "Jensen Huang",
      "timestamp": "2024-12-03T16:05:00Z",
      "text": "Today I am excited to share our breakthrough Blackwell architecture that represents the next evolutionary step in AI computing. We have achieved a 5x performance improvement over our previous generation while maintaining power efficiency."
    },
    {
      "id": "t2",
      "speaker": "Ian Buck", 
      "timestamp": "2024-12-03T16:12:00Z",
      "text": "The key innovation in Blackwell is our new tensor processing units that can handle massive transformer models with unprecedented efficiency. We are seeing 10x speedups in training large language models compared to traditional architectures."
    }
  ]'::jsonb,
  '{
    "summary": "NVIDIA Blackwell AI chip architecture technical briefing",
    "keyTopics": ["Blackwell Architecture", "Performance Metrics", "Data Center Growth", "Cloud Partnerships"],
    "actionItems": ["Finalize cloud partner agreements", "Prepare production timeline", "Update revenue forecasts"],
    "conclusions": ["Technology leadership maintained", "Strong market demand validated", "Revenue growth trajectory confirmed"]
  }'::jsonb
);