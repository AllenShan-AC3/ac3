--
-- PostgreSQL database dump
--

-- Dumped from database version 11.13
-- Dumped by pg_dump version 11.17 (Ubuntu 11.17-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_user_id_fkey;
ALTER TABLE ONLY public.provider_nodes DROP CONSTRAINT provider_nodes_provider_id_fkey;
ALTER TABLE ONLY public.provider_files DROP CONSTRAINT provider_files_provider_id_fkey;
ALTER TABLE ONLY public.provider_bank_accounts DROP CONSTRAINT provider_bank_accounts_provider_id_fkey;
ALTER TABLE ONLY public.provider_accreditations DROP CONSTRAINT provider_accreditations_reviewer_id_fkey;
ALTER TABLE ONLY public.provider_accreditations DROP CONSTRAINT provider_accreditations_provider_id_fkey;
ALTER TABLE ONLY public.membership_coverages DROP CONSTRAINT membership_coverages_coverage_id_fkey;
ALTER TABLE ONLY public.document_tags DROP CONSTRAINT document_tags_tag_id_fkey;
DROP TRIGGER trigger_record_deletes_on_tbl_tags ON public.tags;
DROP TRIGGER trigger_record_deletes_on_tbl_providers ON public.providers;
DROP TRIGGER trigger_record_deletes_on_tbl_provider_nodes ON public.provider_nodes;
DROP TRIGGER trigger_record_deletes_on_tbl_provider_files ON public.provider_files;
DROP TRIGGER trigger_record_deletes_on_tbl_provider_bank_accounts ON public.provider_bank_accounts;
DROP TRIGGER trigger_record_deletes_on_tbl_provider_accreditations ON public.provider_accreditations;
DROP TRIGGER trigger_record_deletes_on_tbl_document_tags ON public.document_tags;
DROP TRIGGER trigger_record_deletes_on_tbl_coverages ON public.coverages;
DROP INDEX public.users_email_index;
DROP INDEX public.tags_name_index;
DROP INDEX public.sessions_user_id_index;
DROP INDEX public.services_sku_index;
DROP INDEX public.provider_nodes_wkt_index;
DROP INDEX public.provider_files_provider_id_index;
DROP INDEX public.provider_files_file_provider_id_index;
DROP INDEX public.provider_bank_accounts_provider_id_index;
DROP INDEX public.provider_bank_accounts_bsb_account_number_index;
DROP INDEX public.provider_accreditations_reviewer_id_index;
DROP INDEX public.provider_accreditations_provider_id_index;
DROP INDEX public.membership_coverages_coverage_id_index;
DROP INDEX public.existing_document_tag_combination;
DROP INDEX public.document_tags_tag_id_index;
DROP INDEX public.api_tokens_token_index;
DROP INDEX public.api_tokens_brand_slug_index;
DROP INDEX public.api_tokens_brand_index;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_pkey;
ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
ALTER TABLE ONLY public.services DROP CONSTRAINT services_pkey;
ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
ALTER TABLE ONLY public.providers DROP CONSTRAINT providers_pkey;
ALTER TABLE ONLY public.provider_nodes DROP CONSTRAINT provider_nodes_pkey;
ALTER TABLE ONLY public.provider_files DROP CONSTRAINT provider_files_pkey;
ALTER TABLE ONLY public.provider_bank_accounts DROP CONSTRAINT provider_bank_accounts_pkey;
ALTER TABLE ONLY public.provider_accreditations DROP CONSTRAINT provider_accreditations_pkey;
ALTER TABLE ONLY public.membership_coverages DROP CONSTRAINT membership_coverages_pkey;
ALTER TABLE ONLY public.guardian_tokens DROP CONSTRAINT guardian_tokens_pkey;
ALTER TABLE ONLY public.faq DROP CONSTRAINT faq_pkey;
ALTER TABLE ONLY public.email_brands DROP CONSTRAINT email_brands_pkey;
ALTER TABLE ONLY public.document_tags DROP CONSTRAINT document_tags_pkey;
ALTER TABLE ONLY public.coverages DROP CONSTRAINT coverages_pkey;
ALTER TABLE ONLY public.caspio_access_token DROP CONSTRAINT caspio_access_token_pkey;
ALTER TABLE ONLY public.api_tokens DROP CONSTRAINT api_tokens_pkey;
SET default_tablespace = '';

--
-- Name: api_tokens api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_tokens_pkey PRIMARY KEY (id);


--
-- Name: caspio_access_token caspio_access_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.caspio_access_token
    ADD CONSTRAINT caspio_access_token_pkey PRIMARY KEY (id);


--
-- Name: coverages coverages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coverages
    ADD CONSTRAINT coverages_pkey PRIMARY KEY (id);


--
-- Name: document_tags document_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_tags
    ADD CONSTRAINT document_tags_pkey PRIMARY KEY (id);


--
-- Name: email_brands email_brands_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_brands
    ADD CONSTRAINT email_brands_pkey PRIMARY KEY (id);


--
-- Name: faq faq_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq
    ADD CONSTRAINT faq_pkey PRIMARY KEY (id);


--
-- Name: guardian_tokens guardian_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guardian_tokens
    ADD CONSTRAINT guardian_tokens_pkey PRIMARY KEY (jti, aud);


--
-- Name: membership_coverages membership_coverages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.membership_coverages
    ADD CONSTRAINT membership_coverages_pkey PRIMARY KEY (id);


--
-- Name: provider_accreditations provider_accreditations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_accreditations
    ADD CONSTRAINT provider_accreditations_pkey PRIMARY KEY (id);


--
-- Name: provider_bank_accounts provider_bank_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_bank_accounts
    ADD CONSTRAINT provider_bank_accounts_pkey PRIMARY KEY (id);


--
-- Name: provider_files provider_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_files
    ADD CONSTRAINT provider_files_pkey PRIMARY KEY (id);


--
-- Name: provider_nodes provider_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_nodes
    ADD CONSTRAINT provider_nodes_pkey PRIMARY KEY (id);


--
-- Name: providers providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: api_tokens_brand_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX api_tokens_brand_index ON public.api_tokens USING btree (brand);


--
-- Name: api_tokens_brand_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX api_tokens_brand_slug_index ON public.api_tokens USING btree (brand_slug);


--
-- Name: api_tokens_token_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX api_tokens_token_index ON public.api_tokens USING btree (token);


--
-- Name: document_tags_tag_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX document_tags_tag_id_index ON public.document_tags USING btree (tag_id);


--
-- Name: existing_document_tag_combination; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX existing_document_tag_combination ON public.document_tags USING btree (document_id, tag_id);


--
-- Name: membership_coverages_coverage_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX membership_coverages_coverage_id_index ON public.membership_coverages USING btree (coverage_id);


--
-- Name: provider_accreditations_provider_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX provider_accreditations_provider_id_index ON public.provider_accreditations USING btree (provider_id);


--
-- Name: provider_accreditations_reviewer_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX provider_accreditations_reviewer_id_index ON public.provider_accreditations USING btree (reviewer_id);


--
-- Name: provider_bank_accounts_bsb_account_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX provider_bank_accounts_bsb_account_number_index ON public.provider_bank_accounts USING btree (bsb, account_number);


--
-- Name: provider_bank_accounts_provider_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX provider_bank_accounts_provider_id_index ON public.provider_bank_accounts USING btree (provider_id);


--
-- Name: provider_files_file_provider_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX provider_files_file_provider_id_index ON public.provider_files USING btree (file, provider_id);


--
-- Name: provider_files_provider_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX provider_files_provider_id_index ON public.provider_files USING btree (provider_id);


--
-- Name: provider_nodes_wkt_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX provider_nodes_wkt_index ON public.provider_nodes USING btree (wkt);


--
-- Name: services_sku_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX services_sku_index ON public.services USING btree (sku);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: tags_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tags_name_index ON public.tags USING btree (name);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: coverages trigger_record_deletes_on_tbl_coverages; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_coverages AFTER DELETE ON public.coverages FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: document_tags trigger_record_deletes_on_tbl_document_tags; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_document_tags AFTER DELETE ON public.document_tags FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: provider_accreditations trigger_record_deletes_on_tbl_provider_accreditations; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_provider_accreditations AFTER DELETE ON public.provider_accreditations FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: provider_bank_accounts trigger_record_deletes_on_tbl_provider_bank_accounts; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_provider_bank_accounts AFTER DELETE ON public.provider_bank_accounts FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: provider_files trigger_record_deletes_on_tbl_provider_files; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_provider_files AFTER DELETE ON public.provider_files FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: provider_nodes trigger_record_deletes_on_tbl_provider_nodes; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_provider_nodes AFTER DELETE ON public.provider_nodes FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: providers trigger_record_deletes_on_tbl_providers; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_providers AFTER DELETE ON public.providers FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: tags trigger_record_deletes_on_tbl_tags; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_record_deletes_on_tbl_tags AFTER DELETE ON public.tags FOR EACH ROW EXECUTE PROCEDURE public.func_record_deletes();


--
-- Name: document_tags document_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_tags
    ADD CONSTRAINT document_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: membership_coverages membership_coverages_coverage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.membership_coverages
    ADD CONSTRAINT membership_coverages_coverage_id_fkey FOREIGN KEY (coverage_id) REFERENCES public.coverages(id) ON DELETE CASCADE;


--
-- Name: provider_accreditations provider_accreditations_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_accreditations
    ADD CONSTRAINT provider_accreditations_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.providers(id) ON DELETE CASCADE;


--
-- Name: provider_accreditations provider_accreditations_reviewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_accreditations
    ADD CONSTRAINT provider_accreditations_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.users(id);


--
-- Name: provider_bank_accounts provider_bank_accounts_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_bank_accounts
    ADD CONSTRAINT provider_bank_accounts_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.providers(id) ON DELETE CASCADE;


--
-- Name: provider_files provider_files_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_files
    ADD CONSTRAINT provider_files_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.providers(id) ON DELETE CASCADE;


--
-- Name: provider_nodes provider_nodes_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_nodes
    ADD CONSTRAINT provider_nodes_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

