ALTER TABLE public.reviews ADD COLUMN photos text[] NOT NULL DEFAULT '{}';
CREATE POLICY "Anyone views review photos" ON storage.objects FOR SELECT TO anon, authenticated USING (bucket_id = 'reviews');
CREATE POLICY "Users upload own review photos" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = 'reviews' AND (storage.foldername(name))[1] = auth.uid()::text);
CREATE POLICY "Users delete own review photos" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = 'reviews' AND (storage.foldername(name))[1] = auth.uid()::text);