--
-- PostgreSQL database dump
--

\restrict hFHe0IgW0WT9kS8fcl3BpXkRhm466q2RXHx14PHkkeCPrPjKrFyUz0U5i4hFuxJ

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6 (Ubuntu 17.6-2.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


ALTER FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_update_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_level_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.prefixes_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: connections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connections (
    id integer NOT NULL,
    influencer_id integer NOT NULL,
    connected_influencer_id integer,
    entity_name character varying,
    entity_type character varying,
    connection_type character varying,
    strength integer,
    description text,
    created_at timestamp without time zone
);


ALTER TABLE public.connections OWNER TO postgres;

--
-- Name: connections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.connections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.connections_id_seq OWNER TO postgres;

--
-- Name: connections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.connections_id_seq OWNED BY public.connections.id;


--
-- Name: influencers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.influencers (
    id integer NOT NULL,
    name character varying NOT NULL,
    bio text,
    country character varying,
    verified boolean,
    trust_score integer,
    avatar_url character varying,
    avatar_data bytea,
    avatar_content_type character varying,
    trending_score integer,
    overall_sentiment character varying,
    last_analyzed timestamp without time zone,
    cache_expires timestamp without time zone,
    is_analyzing boolean,
    analysis_complete boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.influencers OWNER TO postgres;

--
-- Name: influencers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.influencers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.influencers_id_seq OWNER TO postgres;

--
-- Name: influencers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.influencers_id_seq OWNED BY public.influencers.id;


--
-- Name: news_articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_articles (
    id integer NOT NULL,
    influencer_id integer NOT NULL,
    title character varying NOT NULL,
    description text NOT NULL,
    article_type character varying,
    date timestamp without time zone,
    source character varying,
    url character varying,
    sentiment character varying,
    severity integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.news_articles OWNER TO postgres;

--
-- Name: news_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_articles_id_seq OWNER TO postgres;

--
-- Name: news_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_articles_id_seq OWNED BY public.news_articles.id;


--
-- Name: platforms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.platforms (
    id integer NOT NULL,
    influencer_id integer NOT NULL,
    platform_name character varying NOT NULL,
    username character varying,
    follower_count integer,
    verified boolean,
    url character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.platforms OWNER TO postgres;

--
-- Name: platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.platforms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platforms_id_seq OWNER TO postgres;

--
-- Name: platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.platforms_id_seq OWNED BY public.platforms.id;


--
-- Name: product_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_reviews (
    id integer NOT NULL,
    product_id integer NOT NULL,
    author character varying,
    comment text NOT NULL,
    platform character varying,
    sentiment character varying,
    url character varying,
    date timestamp without time zone,
    created_at timestamp without time zone
);


ALTER TABLE public.product_reviews OWNER TO postgres;

--
-- Name: product_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_reviews_id_seq OWNER TO postgres;

--
-- Name: product_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_reviews_id_seq OWNED BY public.product_reviews.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    influencer_id integer NOT NULL,
    name character varying NOT NULL,
    category character varying,
    quality_score integer,
    openfoodfacts_data text,
    sentiment_score double precision,
    review_count integer,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: reputation_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reputation_comments (
    id integer NOT NULL,
    influencer_id integer NOT NULL,
    author character varying,
    comment text NOT NULL,
    platform character varying,
    sentiment character varying,
    url character varying,
    date timestamp without time zone,
    created_at timestamp without time zone
);


ALTER TABLE public.reputation_comments OWNER TO postgres;

--
-- Name: reputation_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reputation_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reputation_comments_id_seq OWNER TO postgres;

--
-- Name: reputation_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reputation_comments_id_seq OWNED BY public.reputation_comments.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    influencer_id integer NOT NULL,
    user_name character varying NOT NULL,
    rating integer NOT NULL,
    comment text,
    product_name character varying,
    verified boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: timeline_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timeline_events (
    id integer NOT NULL,
    influencer_id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    event_type character varying,
    title character varying NOT NULL,
    description text,
    platform character varying,
    views integer,
    likes integer,
    url character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.timeline_events OWNER TO postgres;

--
-- Name: timeline_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timeline_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.timeline_events_id_seq OWNER TO postgres;

--
-- Name: timeline_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timeline_events_id_seq OWNED BY public.timeline_events.id;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: connections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connections ALTER COLUMN id SET DEFAULT nextval('public.connections_id_seq'::regclass);


--
-- Name: influencers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.influencers ALTER COLUMN id SET DEFAULT nextval('public.influencers_id_seq'::regclass);


--
-- Name: news_articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles ALTER COLUMN id SET DEFAULT nextval('public.news_articles_id_seq'::regclass);


--
-- Name: platforms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platforms ALTER COLUMN id SET DEFAULT nextval('public.platforms_id_seq'::regclass);


--
-- Name: product_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_reviews ALTER COLUMN id SET DEFAULT nextval('public.product_reviews_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: reputation_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reputation_comments ALTER COLUMN id SET DEFAULT nextval('public.reputation_comments_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: timeline_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeline_events ALTER COLUMN id SET DEFAULT nextval('public.timeline_events_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: connections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.connections (id, influencer_id, connected_influencer_id, entity_name, entity_type, connection_type, strength, description, created_at) FROM stdin;
1	5	\N	Night Media	management	managed_by	10	Talent management company representing the influencer	2025-11-15 22:18:50.431775
2	5	1	MrBeast	influencer	collaboration	8	Frequent collaborator on videos	2025-11-15 22:18:50.431779
3	5	\N	GFuel	brand	sponsorship	7	Long-term brand sponsorship deal	2025-11-15 22:18:50.431779
4	5	\N	Studio71	network	contracted_to	9	Network that the influencer is contracted to for content creation and distribution	2025-11-15 22:18:50.43178
5	5	\N	Benefit Cosmetics	brand	sponsorship	6	Brand that the influencer has a sponsorship deal with	2025-11-15 22:18:50.431781
6	5	8	Sulivan Gwed	influencer	collaboration	7	Influencer that Maghla frequently collaborates with on various projects	2025-11-15 22:18:50.475765
7	5	\N	Adidas	brand	partnership	8	Brand that the influencer has a partnership with for promoting their products	2025-11-15 22:18:50.475767
8	5	\N	Vivendi	other	owned_by	10	Parent company that owns the influencer's management company	2025-11-15 22:18:50.475768
113	16	\N	Night Media	management	managed_by	10	Night Media is the talent management company representing Chris Tyson.	2025-11-15 22:31:19.244124
114	16	1	MrBeast	influencer	collaboration	8	Chris Tyson frequently collaborates with MrBeast on various video projects.	2025-11-15 22:31:19.24413
115	16	\N	GFuel	brand	sponsorship	7	Chris Tyson has a long-term brand sponsorship deal with GFuel.	2025-11-15 22:31:19.244131
116	16	\N	Adidas	brand	sponsorship	6	Chris Tyson has a sponsorship deal with Adidas.	2025-11-15 22:31:19.244131
117	16	\N	YouTube	network	contracted_to	9	Chris Tyson is a YouTube influencer and has a contract with the platform.	2025-11-15 22:31:19.244132
118	16	\N	TikTok	network	contracted_to	7	Chris Tyson also has a significant presence on TikTok and is contracted to the platform.	2025-11-15 22:31:19.244133
15	6	\N	MyProtein	brand	sponsorship	9	Tibo InShape has a long-term sponsorship deal with MyProtein.	2025-11-15 22:20:00.609238
16	6	9	Justine Gallice	influencer	collaboration	8	Tibo InShape frequently collaborates with Justine Gallice on fitness-related content.	2025-11-15 22:20:00.609244
17	6	10	Nassim Sahili	influencer	collaboration	7	Tibo InShape has collaborated with Nassim Sahili on several fitness videos.	2025-11-15 22:20:00.609245
18	6	\N	Under Armour	brand	partnership	8	Tibo InShape has a partnership with Under Armour for promoting their fitness apparel.	2025-11-15 22:20:00.609247
19	6	\N	Talent Web	management	managed_by	10	Talent Web is the management company representing Tibo InShape.	2025-11-15 22:20:00.609248
20	6	\N	YouTube	network	contracted_to	10	Tibo InShape is contracted to YouTube where he publishes his fitness videos.	2025-11-15 22:20:00.609249
21	6	\N	Instagram	network	contracted_to	9	Tibo InShape is contracted to Instagram where he shares fitness tips and lifestyle photos.	2025-11-15 22:20:00.60925
22	6	\N	Twitter	network	contracted_to	7	Tibo InShape is contracted to Twitter where he shares updates and interacts with fans.	2025-11-15 22:20:00.609251
23	6	\N	TikTok	network	contracted_to	8	Tibo InShape is contracted to TikTok where he shares short fitness videos and challenges.	2025-11-15 22:20:00.609252
30	2	12	Norman Thavaud	influencer	collaboration	8	Frequent collaborator on videos	2025-11-15 22:23:29.795383
31	2	13	Squeezie	influencer	collaboration	8	Frequent collaborator on videos	2025-11-15 22:23:29.795387
32	2	\N	Studio Bagel	studio	contracted_to	9	Studio Bagel produces many of Cyprien's videos	2025-11-15 22:23:29.795388
33	2	\N	Mixicom	ad_agency	contracted_to	7	Mixicom is the ad agency representing Cyprien	2025-11-15 22:23:29.795388
34	2	14	Lolywood	influencer	collaboration	7	Cyprien has collaborated with Lolywood on several videos	2025-11-15 22:23:29.82099
35	2	\N	Bigard	brand	sponsorship	6	Cyprien has been sponsored by Bigard for some of his videos	2025-11-15 22:23:29.820992
36	2	\N	Canal+	network	partnership	7	Cyprien has a partnership with Canal+ for broadcasting some of his content	2025-11-15 22:23:29.820992
70	1	\N	Night Media	management	managed_by	10	Night Media is a talent management company that represents MrBeast.	2025-11-15 22:28:08.699884
71	1	15	Chandler Hallow	influencer	collaboration	9	Chandler Hallow is a frequent collaborator on MrBeast's videos.	2025-11-15 22:28:08.699888
72	1	\N	Honey	brand	sponsorship	8	Honey is a frequent sponsor of MrBeast's YouTube videos.	2025-11-15 22:28:08.69989
73	1	\N	Microsoft	brand	partnership	7	MrBeast has partnered with Microsoft for several video challenges.	2025-11-15 22:28:08.699891
74	1	\N	Quidd	brand	sponsorship	7	Quidd has sponsored several of MrBeast's videos.	2025-11-15 22:28:08.699891
75	1	\N	Qwik	brand	partnership	7	MrBeast has partnered with Qwik for a video challenge.	2025-11-15 22:28:08.699892
76	1	16	Chris Tyson	influencer	collaboration	9	Chris Tyson is a frequent collaborator on MrBeast's videos.	2025-11-15 22:28:08.699893
77	1	17	Karl Jacobs	influencer	collaboration	9	Karl Jacobs is a frequent collaborator on MrBeast's videos.	2025-11-15 22:28:08.699894
81	7	\N	Night Media	management	managed_by	10	Talent management company representing the influencer	2025-11-15 22:28:14.661032
82	7	1	MrBeast	influencer	collaboration	8	Frequent collaborator on videos	2025-11-15 22:28:14.661035
83	7	\N	GFuel	brand	sponsorship	7	Long-term brand sponsorship deal	2025-11-15 22:28:14.661036
102	3	25	Sebastien Rassiat	influencer	collaboration	9	Frequent collaborator on videos, co-creator of 'Joueur du Grenier'	2025-11-15 22:28:33.782366
103	3	22	Bob Lennon	influencer	collaboration	7	Occasional collaborator on videos	2025-11-15 22:28:33.78237
104	3	24	Hardisk	influencer	collaboration	6	Collaborator on videos	2025-11-15 22:28:33.782371
105	3	20	Benzaie	influencer	collaboration	6	Collaborator on videos	2025-11-15 22:28:33.782371
106	3	\N	Grenier Films	studio	owned_by	10	Production company owned by 'Joueur du Grenier'	2025-11-15 22:28:33.782372
107	3	\N	Micromania	brand	sponsorship	8	Long-term brand sponsorship deal	2025-11-15 22:28:33.782372
108	3	\N	Retro Gaming	brand	partnership	7	Partnership for promoting retro gaming	2025-11-15 22:28:33.782373
109	3	\N	YouTube	network	contracted_to	10	Platform where 'Joueur du Grenier' publishes content	2025-11-15 22:28:33.782373
110	3	\N	Twitter	network	contracted_to	8	Platform where 'Joueur du Grenier' publishes content	2025-11-15 22:28:33.782374
111	3	\N	Instagram	network	contracted_to	6	Platform where 'Joueur du Grenier' publishes content	2025-11-15 22:28:33.782374
112	3	\N	Facebook	network	contracted_to	7	Platform where 'Joueur du Grenier' publishes content	2025-11-15 22:28:33.782375
119	16	\N	Influencer Marketing Agency	ad_agency	contracted_to	8	Chris Tyson is contracted to the Influencer Marketing Agency for ad campaigns.	2025-11-15 22:31:19.244134
\.


--
-- Data for Name: influencers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.influencers (id, name, bio, country, verified, trust_score, avatar_url, avatar_data, avatar_content_type, trending_score, overall_sentiment, last_analyzed, cache_expires, is_analyzing, analysis_complete, created_at, updated_at) FROM stdin;
24	Hardisk	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:28.885835	\N	f	f	2025-11-15 22:28:28.88584	2025-11-15 22:28:28.885843
25	Sebastien Rassiat	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:33.687409	\N	f	f	2025-11-15 22:28:33.687414	2025-11-15 22:28:33.687416
2	cyprien	Cyprien Iov, better known as Cyprien, is a French comedian, actor, dubber, and blogger. His YouTube channel is one of the most subscribed in France.	France	f	95	\N	\N	\N	0	good	2025-11-15 22:01:49.086175	2025-11-16 22:01:49.086181	f	t	2025-11-15 22:01:49.086726	2025-11-15 22:03:01.863517
3	joueurdugrenier	Frédéric Molas, better known by his pseudonym 'Le Joueur du Grenier', is a French YouTuber known for his humorous video game reviews.	France	f	100	https://linktr.ee/og/image/joueurdugrenier.jpg	\\xffd8ffe000104a46494600010100000100010000ffe202284943435f50524f46494c450001010000021800000000043000006d6e74725247422058595a2000000000000000000000000061637370000000000000000000000000000000000000000000000000000000010000f6d6000100000000d32d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000964657363000000f0000000747258595a00000164000000146758595a00000178000000146258595a0000018c0000001472545243000001a00000002867545243000001a00000002862545243000001a00000002877747074000001c80000001463707274000001dc0000003c6d6c756300000000000000010000000c656e5553000000580000001c0073005200470042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000058595a200000000000006fa2000038f50000039058595a2000000000000062990000b785000018da58595a2000000000000024a000000f840000b6cf706172610000000000040000000266660000f2a700000d59000013d000000a5b000000000000000058595a20000000000000f6d6000100000000d32d6d6c756300000000000000010000000c656e5553000000200000001c0047006f006f0067006c006500200049006e0063002e00200032003000310036ffdb004300030202020202030202020303030304060404040404080606050609080a0a090809090a0c0f0c0a0b0e0b09090d110d0e0f101011100a0c12131210130f101010ffdb00430103030304030408040408100b090b1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010ffc0001108027604b003012200021101031101ffc4001e0001000105010101010000000000000000000704050608090302010affc4005e10000103030204030404060c080b0509000001020304051106070812213113415109142261153271811623384291b417335262737576a1b1b3b5c11837395372748292192434355763a2a5b2d1d236567795d4435483859394d3e1f0ffc4001c0101000105010100000000000000000000000301020405060708ffc4003a110100020103030302040404050403000000010203041112052131061341225114326171072381b14291a1d115334352f06282c1f1a2c2e1ffda000c03010002110311003f00d37001bb668000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fc739ad45739c8889dd554a196f14ed7787066477af9165ef5a46f69526d15f2af3c66aca6a7fdb666a2a79775fd0505449553c79f155a8be4de85aa489cc5ec62db591e2b08ed936f10b954ea4a78955b0c0f9153cd57950a17ea3af917e06c71a7c9b95fe72df33173d50f86a75ea47efdedf28a725a57db6d7d5d4cc8934ee775edd13fa09af6b2c94f70a96ba4a58a4ff4988a41b67e93357e66c3ecd56c50d435ae44cf43adf4ad6b7d544dfba5c1dedddbcdc33e95a4a2952b9b450b1cd44c2a4688a85cf883b9d9e8e477bddba9a7739172af89ae5fe742b787bb8453d3f84dc22f2f42c9c4759e496559d5155306e69119badf0cac9b447b9b34c75f6bdd316da891afd236e99155728ea48d7fa508ce6dc0db9a8997e91d054fc8abd520558553fdc542ff00ba76fe4a899dcbd954846e596b9706a7d49abcfa2d4ce3c75aedfac44a1cb1b4a5aa2a9d88d472b2952a6eb619e45c35de3a4b1a2fcd1cd55fe7432ba9e17752d7d136e9a2f51db2f7492273333985ea9e984e64cfdaa86b33f3226153ecc1216d9ef7eb9dab9db2596e0fa8a3ce64a499caac727d868745d5b065b70d7e288fd6bdb6fe9e1644cfc4ae5aa76d75d68b572ea4d335b4913571e3f273c3ff00ea372dfbb3931937136c78b2d07b8cf659350d225a6e3327222c98f0deabd308647adf878dbad571ad6b6c91514f2a7336a6dea90aae7cf953e055f9ab554df7fc1f16aabcf4596263ed3fef1fecbe2df768c0261d73c33eb2d37e255e9e736f746ccaf231bc950d4ff43b3bfd95cafa1115453d4524cfa6aa8248668d795f1c8d56b9abe8a8bd514d4ea7479f476e39ab31fdbfa4f85cf30018c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001ef43415973ab8e86df4d24f5133b9591b132aabfff00bcc444cced078781415b78a6a5cb23549644f245e89f6a9926e7692a9d0d6ca4a3acac6bae55ade795912fc30b7f739f35f55ede499eeb1a431aa218da9cb6c36f6f6ee86d97fed56545554d7395d33fa79353a227dc7c33e053da28711e54f37330ee86bed6999de50f79eeba50ce8f6f2b94a996de932658d29ac7433d7d6329a9e35739ca8888884ed64d99b949696d64f4ce457373d8d7ea73c61967e9b4d6cd1dd00d4dade99e8a504948f67976265d41b7d5544e72780e4c7c8c2ab2c3344f56be254fb8934fab8c8ae6d15a9dd8cdb58e4953ed26bdaa91c9591a22fa11ad3d99ed7f323149476b299ccb831153b1d9fa632edadaa3c18a62edf2e1c6b5ecab8d8aabd510cff7de91b516a74bcbd5108db87f63a3ba53a2a7a12fef04092d8deb8cf43a4d6dbdaeb34bc24cbdb2c39bdbc147cb34f844f335caf196c8e4f99b57bcf448d9e5546f7c9ab9a8a1e4a9737b7530bd63489cb5c91f30b33d7658514fbce5b83e55ab90bd10e0ad0c399d9e7caf63d258deac7b572d73570a8a6db70d3c51328920d0db8f59cd4dd23a5ad7afd4f44729a96aa8a7e754e8ab8fb0cbd06bb2f4fc9cf1cf6f98562ceb3d55929ae34ccb85b6a19534d32733248d728e45f3303d6fb1da635e52ba3bc5b912a11311d5c488c9a3fb1d8ea9f25ca7c8d3fd90e28758ed454c36eb84f25cec4e546c9048e557313d514dfedb9dc0d29b9f638aff00a66ad9231ed45922cfc51afa2a1e81a4ebb8b5f8bdb9da7ef12cbc5789ed2d1bdcee1df5bede2cb70829df76b3b32ef7aa762f3c4dff00ac6774ff0049329eaa9d88aceb0d4daa0a98f95ec4535cf7a3849b76aaf78d43a0120b65e572f92917e0a6ab5f97f9b7afafd555ee899571aad6f4baedee69bfcbfd9916c3131bd1a540afbed86f3a66eb5163d416d9e82be95fc93413b395cd5fef45ee8a9d153aa74280d0cc4c4ed2c700014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003d69a9e4aa95b0c49955fe64f52fc78ef96f14a46f33e20f0fba0a0a9b8d4b696959ccf72fdc89eaa4fdb5fa368ac90b656468fa891332cca9f13be49e89f2308d1b62860731ac665555399d8eaaa4e5a7ade91513dcd6f56c6abdbe4767a6e873a0c5eee5ef7fedff9f761e7bcda368f0d52dfcbf7d2faeea226bf31d32231a847b4cc573ba79972d7554eaed67747736796a1edcfd8a53dba9d7991550f33cf927267bde7ef2aedda2158ca57b9888d6aa9e94964a8a99918d62e5570649a5a89970ae6d2f2a2aa9326d8ed5bf506a6869fddff0016d722bba1acd46afdb9e31e5b4d2687de8e76f0ade1ef63e4adac8aed5f4caad45454ca1b934da068fe8f653369da888dc762e5a274351d82861a782146f2b513a219cc344d6b11a89d0b29a69bfd593ca6cba8ad3e9c7e21aefac766e1a96be48a9d17ee216bfeca4ee99c8da55fd06f6d55b2395aad5622fdc582b74a514b973a06e7ec21b68e6b6e549d92e2d6c4c6d7eed0ca9d99ada64577bbaa27d85668ed15556db8a2ac2a9d7d0dbfbce94a36b1c9e137f418ac3a4a8e3abf11216f7f43b0f4ccce2d4c5edf0af2a5a77ac330d8ab5c9156472398a984424fdd4c2d95ec5f42d5b5943153c888c6a7442af76e673281cc45eed3a4cf9e751d46b68fd1aec9df344345779a979e49553e66ab6a9a356d53d71e66dcee8524d5534888c554ca9afba8b4a554f2bd5b02af7f235feafea18f1e6a63b4fc3713d3ed9f172ac2217c58553c9ed4c193dd34dd652b95560727dc58aa69248fa39aa71f5d453277acb479f49970fe685b5ebd7a1f28e55eea7d4ac56b8f844f52589627eef46a2275252e1fb796ebb49ace9aa9277adaeaa46c7530e57970abdf045995f53f5155530bdfc94930e4b60c9192abab6da5d99b05e283515aa96f36c95b2d355c69231c8b94ea8564d02275443543817deba1bbda1fb637fad6b2be97e2a257bbebb3d10dbc962c65abe5d0efb4ba98cf8e2f1f2d960c9bc228de3d90d2bbc3645a4b9c6da4bb53b17dc6e51b116485dfb977eee355eed5fb530bd4e7d6e06deea8db3d473e99d5540b05445f1452b72b154479e9246efce6afe945ca2a22a2a1d4f7c7cabd8c3b73f6ab4b6ed699974f6a3a54e76f33e8eb189f8ea49553a3d8be9db2dece4efe4a906b7475d47d75ed6fee972638c91bc7972f01946e4edcea4dadd5555a535353724d0af3c333517c3a9855579658d7cdab8fb5151517aa298b9cf5ab359da7cb0a636ed2000a2800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f6a4a4a8aea98e9296259259570d6a19adb34cbe85a91ab155fddcec775ffc8cc76cb47a69ca4fa56ed468b5d58c4c35e9d618d7af2fc9cbd157ee4f52468b4e5beeb1f3c5135aff004443d67d2bd02bd3f046b3575fe65bc7fe98ff0079f9fd3b7dd2ce9ed7aeec2b49dbb965622b7ae498a9e18edba6ebae52af2b60a57bdcbe9842c364d1b345569f8b544452f3bcae5d3bb31a86a5bf0b9d46f8d153d550caebd971e2c16e33f12c3cb8b8cc44b9f51d436e979ba56f7496b25545f54e652f74b0a35ab84319d02c75451cb2bd32aae5764cc608f184c1f3e5adde665752bbb2edaca4927d471ab6257227c8df4d89d151d1c0b7596044925ea99420be1a36ae0afa365e6a62cac8a9cb94375b4bd921b6d247046c46b5a9d90d7569eee7f727c4371393d8d3fb71e657aa5a76b513085c6389309d0f8861c762ad8cc60da55aa99de5e2b022a76292a69d11abd0baf274292b1b862fd85d15dd4acecc26f50b5517a18dfbae5fd13ae4caaf09d57a168a4839e74ca64e87a463e13c99d8a768dd9fedadbdcc63ea1c9d8b56eacec955f1792219b690a76d259964c61553245fb875ab2d44bd7ccd869a672eb39fd98b8f7c99f7840daaacd15548e5f0d155554c2e5d110caaaae81173f224eaf449265ca67a9faca18dcccf29e57ebfeabcb5f34acf87a174dacd30c6e80f526de533d8ff00f8ba7e8219d5fa1db46af58e2edf23726f36a89ec77c0451ac34cc7331f98d3cfc8e2ba7f5ac98af1ca7b3659343875949ada1a7572a07d3cae62b17a296e7b15aa4b3ac749ac13bdcd8fcfd0c02b6d2e8f2a8dec7a36875b5d4d22625e79d57a55f4792636ecb12ae0fc472e7a1e92c7c8e543c72a8bd8dac4c4c34331312bad87505e34b5ea8f51d8aa5f4f5b4323658dcd5c2f45ec7577617766877836f68350c32b7dfa38db1d6c48bd5af44eff79c938de99ea4c7c3c6fcdc36535336b139a6b5552a36b29f3d31fba44f536fd375d1a6b70bcf64f866625d4c5623d3b753e1225452d1a0f5e695dc9d3f06a5d27708ea29a56a2bd8d5cba35f45432156a2f5c1d65724648de19f4c9ba39dead95d3fbcda4df65b92369ae54c8e96d97046e5d4d2e3b2f9ac6ec2239be7d153aa22a735355698bd68cd455fa5b50d1ba9ae36d99d04f1af6ca76722f9b5530a8be68a8be675bd646b3aaa9ae9c5d6c8c1b8da7ff0df4cd222ea5b2c4be2471b7e2aea54caab31e6f67556f9aa7337ae5b8d76b74b39639d63bc2b931f38e51e5a0c0034ac4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009b3868d8ebb6e7ddeab544b48ab65b039bccf727c33552f56469ebca9f13bfd945fac4376ea0aabad7d35b28a3e7a8aa95b0c4df5739709fd2756787db7686d17b7169d0b657b13dce2e6a991c888ea8a877592577cd5dd93c911a9d910cdd163cb5b46a6b4e51498fdb752d36ac728840b7adb3bd53c8e77baab9117d0f0b4e9eafa49d8d5a67a617af4373a7d3b68ab6f37851b914a0fd8fac6aff001129a3cfd87755f5b4fb7c72d3ba5c7d4ab58faa3ba09b55864740d91d0e171e847bc55504906c4ded51ab9e454fe636f5da32dad62b591a227c884b8b0d1712ec5ea66b139bc3a67c89f721cf6bbadc6b71da23ed2c6cba98cb6729b6ea8f92d28ae4eaa653454eb51718695bddf22263ef2d9a2e1486ce8aa9e4659b7746dbaebab751e33cd322e3ef3cd32cedbca6c31bda21d09d83d3c968d21411ba3c3bc36aaf4f9139dbe3446b7a182e86a26525aa9e06b513918d4fe633fa14c221169fc27d44fd4b846c44ec87b35a7cc69d0f544336ac39397a1495adf817a15c8de852d6372c5fb0921489eec2af0deaa515b22474e9d0b8de99dca3b6a72cad77cce93a77fcb65d67e94ab429e158911bfb9217d7322ad44bf6a934db7335939513f348675bd3b92b266aa79995d3a7f997534331eecee8c2a93f1b9f995f4edcc451dc5ab1cbd7d4aea5545890f08f5a63b4750bda5e83a69fe5c6cb75c63456bba1845f68d9235d96a7533eaf665aec9875d9111550e1e2d3166e7493dd0eeafd38c9daf546792f910edf2c2b0bded5663ee3652eb4cc99ae454233d516363d5cad61d3748ea37c3688994bd43438f578a62d0d72bd512d3cabd0b33dab9242d6767740ae7f26110c0e58d5aaa7a7e8b5119f1c5a1e43d53493a4cf34953a2e14a88d51c9caefb0f1c1e91e1150cd9ef0d744cc26be15f79ae7b39b894aca8ac91d60ba4890d542e72ab18abd11d8f2c64ea5c1554770a486e36f99b2d354b12589ed5ca2b55328716295ff001633f34f91d05e0bb7bbf092c2ddbebfd523ab285b8a673ddd5cc4f2fb90de747d64f2f62f3fb32b1dbb6ed8fb8bd599c38b0d4d53db9cb8beddb088a61b78aa485aab93bbd1523276d9b6d34c59a53c506d9b3476b376a6b441c968bfc8e9b95a9f0c155de467c91df593ed72274690b1bdbb9367b6ebad355da6ee2ad46cedcc322a6561993ab1e9f62f7f54554f3346ae341556aafa8b6d6c6b1d452cae8656fa39ab85fe839febfd2ada0cd196b1f45ffd27e63ff9ff00e98dacc1ed5f9478953800d030c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001206cfd14715f7f082a1a8ada3cb21cff9c72755fb9abff690d8cb3ee1545be66c94d3ab1c98eca6bd581cb6d829a819d158d457e3cdcbd57f9ccb23ac95b3b115ca99c1eefd0fa062d1f4ec787247d531bdbf79f3fe5e3fa323065888e2dabd39bf57683c282a24f11ab84269b26e0c7576e6d6d4a7223933d54d70db6d094557636ea6bc542470c49cd85f33d6e3b891d657fd1d6d93969615e56a22f739ed6f45d1751cd6c5a6a77afe69f84f7d1e2cbdf6d9b616ad4105ce247c4f45c98b6f6d95751ed86a5b535b959add2a227aae0c0b426a7961f0f12aaa74e992529ae94d73b454c126152681ec54fb50e0ba9f4bb68325ab1e1a8d4e9a70cf6717689afb6475940f5c3a9e67c78fb14907869b74b7cdd8a08dade648d55ca603b85cd6ed79a8a822e8c6dc27c27fb4a4fdc07e9e757eb5b95ea58f29491a6171ea703aa8e3596569677c90dfdd3d4cb0c6c62f922197d1a74431eb637088647489d887076aa4cd3bceeb8c5d50f66a763c989d0f76219b5624be913a14b569f02fd855a7429aad3f16a4b0a47961f796e7285b295795c5d6f098452d54c9979d0f4def8d9b8e3e94a7a625e7b5723bd08cb5fc0d4ad931e6a48da5117e8d55f4423dd78ee6ad7fda64e8fb6a2db21d376cf288ef502f3ae13ccf9a24911a88a9d8ba5ca26ba5c29e51c6d6e150f21f5dd22759310f40d0df7c51ba96b23cc4bd3c8c22f8de5738cfaad731aa22791845fa9a47ab95ad53cd32e3e32de68eddfbb09af9132a8aa629768d922bb2864d73a6a8639caad54313baaba3ce4cdd2f986ded31c51ceb9b3b26a19646b73845520fad623247b7b61706c95c204ad85f12a6728a8409abed325b6e93315aa88ae5543d13d3daadf7c5679d7ab34bbed9ab0c61dd17ec3f517cc3dbf12a9f39c29d7383544332b5739338db1d715fa1f57dbb5051cee8d6095bcd85eed55ea600d77c45753af322264ad2f38b2464afc24c7698975cec3ab20d57a628efb0bd15b550b64e9f34311d537448d8ff0088c67871b9b2e3b3f6f549799d4edf0d7af6c21f1ac2b1c88febd8f68e818eb9b8dbeecbc3a9f6a7662978d40ad7bb0e35eb792db1baf4cd454ed446d6a2473e3fceb53a2fded4ff00b2a4a37daf5457af311e6a999973b75451bd1155cde667c9c9d50ec7ae744c7d4fa5e4c358fae237afef1fefe3faab9b59ce38ca2d001f3f2c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000adb3d3ad4dc226e32d62f3bbec4ff00fbc144643a529d17c7a8727a31bfd2bfdc6fbd31a08ea3d5b0e0b476df79fdabdffd76dbfaa969da1925b98ef796bd7aae4c91d2a78ec54f2c169a681216b657263d0badb604afaf8206a67c491adfd2a7d0d358af79314ccca7bbb6a492ddb4d4b4d0cdc8b3351308a46fa6ea64599af57ae557b974de1a86d9682cf6189551190b5ce4f9e0c634ed42b96356afa1a3e99a5ad34b6c95ff001da65b4b4ed3b4361745572aa469cc4b36eaee5a75473f08ad54fe620bd1133d5f1a22af912acb50f8289111d87393a21e6dea9c98f4fbcde58f7a5b513c61cc2deba5f71dd7d410617e2ab7c9fa5ca6ddf015698a0d2571bbb989cf512ab33f245206e2b341d469ad749a82a19886eb9735d8f34363f8247c6cdbe9636f649554f18d5658c91368f1ba2c58e71649acfc36aedc89d14c8a91318315b754273275325a5a88911155c9923c13066895da3c1eccee5032ae35ece4fd2544750d55e8a66d769f0c5985594f55d5abf61e8d9517ccf29dc8ad5245b1e58a5e1aaa8eca166a554f131f3323bac7cc8e3186fe2e754cf99bde9593cd59f8637aa4cd29366deacc980eb98d7dfa4fb4cc346ce8e81599ea63fafe9b9657c88867e9be8d44a0c1f4ea116d5b11665cf914af546f994ba82e7ee0f7c8e77630cacdc6b7d3e52491131f33cb3d6fa5c91ab9bede5dee8239638d99b48e6aa755282a29a9df957a229804dbbd6a6aaa35e8bf7963bc6f253b6356c0a89f3c9c046932dfb716c62d14f9657a9d6df4f13b3ca8a4457ea881f2b918e4eaa59aff00b8d537191df8eca2fccc3aaefd5f3cb96f32a64cfd3f4bc95faadd93d7a8e3c71c6277965ac6b9ce554ec47fba76174b4a95f1469ccdfadd0cc6c775f151ac9dab9f9976bc5ae9ee96e92256a391cd53334d96da1d456d2c6d7e28d7e9ad56a948d547617b9e2ec21906a9b44968ba4d4ee6e111570581c87a4e2c91929168f979466c738af349f87cb572a5753aa2216ecaa29594ef5c60bed1bc2c8f2dace10f75a3b7cd53a0ae73f2b2a539e995cbf9de84dfac18aac7aa765ea73fb4d5eaa6c37fa1bb5248ac920998bd17cb3d4dfca8ad8efba6a82ef1615b574ed93a7d87a37a33aaccd3dabf9aff006459a6693168f1284b544eb1be44c91d5c6bb0f77c5e6483ae58b1cb263d54896e93ab65727ccf54cbd6630e3ec8e679ad558d46d4bf97b397993ef3c4fb99fcee45f3c1f0788756c75c7adc914f133bc7f5eed8e2b72a4480035c900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000331d2b0a2d3c31feed55cefbd7ff002c187194da6bd295b1a3570ad6227f31e89fc38c75fc765cf6ff000d76ff0039ff00f88b2db6865b78ab8d8f8e287186a614fdb55d9f4159056c785742f47a27ae14c765aef15eae55c9f51d4a74ea7afce5a4cecb31e5e13ba7eaed4fa2374e3a586fd2adbab606247e22765c7da5d29f68db434adb858ae71d7d3a755e4722aa7e8200a2991ce455c649b364f5454d25cd2dd34ee7413fc3caabd0d2eb70e5d2e29c9a3bf68efc67c3638f357246d3e520e94a77515442d7b70a8a88a645ac6f15d4d7fa2b7d3e5239397383e67a1f74b9b1e8cc35ce47215fa8e8d6aaf16eaa6b530984553c0bf8959736a34b4c98bcef1bb6fe9eb523596a65f1c6504f1e56e6bb6fecf706313c681f8cf9e14baf0495caed01372afd572e53e679719d570cb60b75aaab187af63e785f8a0d29a495f23b9619dea7019edc3146ed7cc4db3da534de35fdc2cd52e8990bb953cf05133792ad3a2c9852fabf435d6057784d91153cda62b79d31a723474d2a24489dfae0d35f167e5ca97f2d8e2be098daf4eebac7bd93c4a9cd2a7db92ff6adf3b7b95bef152d45f9b8d6fd6172b3c350ea2b13e4a89bf72c45522fbceacb85bdef64b1ccc737ede84f8b0750a7d759ecb32df43bf1987472c3b9766ba227875b1ae7f7c864c97aa49a3cb266ae7e67282dfbc7a9286af1475d3330bd111ca67768e2775d5b39524a87cac4f253654d5ea71c6d96ac5fc1e9f2cef8ace895757c6f6aa35c8a63524c8e9d553d4d63d13c58257ccca7bd33915d84e6c93a587585aaff000b2aa92a5ae47a67193a5e87aa8cf938ecbff0b6c359dd2de899be273557b9fbaf60e7a7572279147a1e547c996ae4bc6b046ad1af32f91d06dc35112d5f8cd12d69d674d24aaf6a6704417ed1f5b59ceea747657383603524506247c98446e7a9115ff706c968a95a56aa4d2aae1ac67555538df5c62bda697c51bcbb4d064db1cc4a22aadbed55e239ac833d7a752960d9ed6b709f9646ab5b9f525ab9ebe4b05b52f977b73a1a77756a2f752c56de242c95f58da4b7db5cf91eb86e57070b38ba9d6bdb12d9d4696f3b737ce9de1b67958d96e152ae72fe6a17e9f87ea3a66fc1d71f22f56cdf38686a1b05ded6f81aefcef4256b1dfad3a9a81b5b432b5ed7a7e839dd6e7d6639fe64cc332993da8e54af66b9dc76a196d45744d5cb7e45956d925235d13f3d3a1b2f7db4c1344fc3132445a9ecbe0c8e735983031ebaf69daf2d9e9b357376db66ac6f3d8db0cb1dc6366117a38891ec454ca1b2dbbb675a9d3b52f46a2ac69cdd8d6c6a651c8a9d94f53f4f6abf11a38dfe3b3cff00d49a58d3eb676f13dd4cad4e63d62f87ccf97a75e87e31706fdcf2a79f9551d9eca8a6feedd2ad56cf69da97755f726a67f49cfe735d2272b7bae110e826db44ea5d9ad394f22754a36aff0049bdf4d5ad8f55698f1b23d57e4451b8088d924c7cc852f8fe4957a932ee1cb9a895be99212bfbf32aa1dc6a7537b46c8f1c765b5b3aaccd6af9f42a4b5f372c8d767b2a2974395ea7bce48b4fd99d83c4c00035a9c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002a61a9722f72997b1f51ae17b9d9fa4f2db0464b57e663ff9419be1778aa5cbdd4a864ea9e65b227f9152d9513a64f46c5ac9b46f32817ba0ab7239132489a0ee6fa6bbd348d72a2a3d08aa96646bd3af999e68e995d5f063f7486d31e6f7b1cd653e2b776e64134371a0a59dca9956a2e4bcbe9126a786444e658d515148fe8ae32c165a5765511a888aa483a56b63ab898d7ae517d4f1ff005474ff00774d6fb6f2cac1a99d3ea62f0d6ce325f157d6596df127e31a8ae727997ed9bb1baf7a1d90448ad5a75ea8864dc506dc36aa9e935752339a4a74e556e3a153c2c52c95360ab654c688bcebd3078f6b3f991ecfcc361589a649cb3e2596e9ba9a6a6892dd5117248ce9954ee51eb2d1b35ee9deca6a97448e4f25240b96898deff7ba7672b93af429fdd25467812b3aa74ea69b6cf8e785e1b1c76c37faa88ef6bf69ecb617cb515d0b2aea64554e77a671fa4d7ce2318ed01ace7f78d3cb2dbeb1abe1c88cf8514dd4b6db529915c89d54a1d67a174f6bbb62db751dae1aa8ff00355cdcb9bf61d2e0cf31878da1abd4e9ab9324daae63695b4c97fd531369e9dcb0cd2655113eaa64d827edbd85c91d23a8555ca899544f3274b76c368bd22e592d16d6239555799cd4ca1eb5161b6d3bf2b1a7321a8d5eaa6d788ab73d2f435c7499bf7dd074bc3a45554feff6f99cc737e2e5248da5d255f6efc44b50ff00c5f4c6491ad71431d2b911a88dc15ba2e8219abd591353abbaf43bef4b68a2314ea6df643abbc52662be12aedddb65829d2597afcd4fbdc3b9c54d03a3e7c2a21915a606db6d4ae544446b7241dba7a9a474b37c6b84cf99bbd3639d4ea66ff10d2e931cea3376451ba9acdf4d4b2d3534987488a9d0c5b65b6eedb78b949a8f502f8cf8d7998d93a98dea8b9beeb76e57bb2d6b89536de9d3dd59146e56a391328870dea6ebb8306b7db8ef15773a8e997a68262bda6581716cfa2a7d39494f4ee6b59cf8c274f2353f4e5d9b6dd4545511bbf6b95ab8cf743a27aeb6334cee75a99417b96a23e5ead7c4e4454521fa9e056c16faa6d65b2fb54f746ee66a4aecff0071a4bfa8f4f6a4f2acb93c7d1ed368e3788fddf1aa96cd74b252d4a44c492489aaaa9eb83ef6b6f15964a95a58e672c2e5e899e85e6b367af54346ca57d4a48d893099c9436fd335765a86b9cdfaabe4701d4b5f8f55130f41e9fa4c54c3349b44ee9899705aaa745775ca1866aaa76bdaf760b8daee9f88463fbe0a5bdb9b3c6aa872bbcc59663c1ecdfb213d7741e35a2b29d5bf5a371a7eac732a6a237776c8e4fe7377356d2a3e09531ddaa9fcc698ea0a6f71be56c18c62572ff39e9fe8ccdcb15e93fa394f57d3eba64fd16a913e2c1f0a9853f5ce457f73f173e67753da1c57caae8795d53046bd55f2b1a9fef21d12b6d325bf405a69113091d235110e7c694b74b74d496da1899ccb254c7d13fd243a3379a55a3b25352a768a06b7f98ea3d318a6f7bcc7e883553f4c435cf5fb956a665cf4ea42f7a4574eec7a936ebd85ce965c279a91257db95d2b955876993a6ea324fd31d96e39ecc5dd02bbc8af6fd54cfa154fa054ecd529d515aaad5f2e873fd7343974b4a5b246dbeeccd3cf797e000e75920000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fc5eca7e31dd7a9fabd94f845c1d57a72fb53247eb08337c2a98f3d9245c60a46a9e88ee875d8b3cf840b8533d55c9833dd1dce9570b913b2a2989e97b53eeb5cc81a8b85eabf619acf72a2b24c94b4888ae67472a7a9d4f4ea5ad58b4fca4a4ed66cc699ad82e5a7fdd9d857c6dca198e89a856b9b1f3765c109ed35f595f1cadf172ee5ead245d2778f06ebe12bba23ce63ace826632638f85f9e36dad098b59da23d43a3aaa95ece6c46aa9f6e08d787e62596baaed551f0a39cbcb9261b6bd9596c7b13aa3e3fee302b0e939aaaed573db9de1d442f556a27e77c8f9e7ab69eda6d744c4796e70658cda59acfc2606468ad44c7428ab2d914aee6e5c296fb36ada68b16ed411ba86ad9f0e644c35df62990ffc5ea5124a69d92357aa72a9771a5e3bb12b6b5256a8edcade8887ebedefc2a264bc318889f54fbf0d153b17c638dbb2f8cf312c32e563aaa8456c6bdcc62af45d4ac9cf2f54eea4acea7fdea16dbac48c81cbd130863db4549b7296762ea19291c6a8c6e76ff70a17786bd90b9ed5d23d6a5257f7738b7ea9ac62b5b4d1b9155cbd4cab6e29db0ac48a985c9e91d332453a74d223657344fb5369f94a579cc5667a37f706af6e6bd5cb3a75cae4da3d42b8b33ffd0355f72d516499caa984c993d2e76c7799fb22e81df346ff0076bf5542aeb82aaf93949a36ae4830c6c8b85444220970fac7afef94cd34bd74d40e6491b97ee3e73f516a2d4d65af3f77afeab4df88d2fb71f66cdd0a31d1b70544d1272187691d4b0d640c648fc3d13cd4cb16ae37b708a61c6a29929bc3ceb3e97260c9c658cdfe2456bb0860d5940d7bd555a48f748d9322e0c56b28b0e554439ed552dca661b9d0e4e35624ea6f01571d0a2ae7fc0a85feba995338698d5c155b9430637e4dbd279b0fd411f8b13db8ee8a69bee5d22d1eabab6e31ccec9ba173673b550d4ddf2a1f76d4cb372e3c43bff46e5e39ed4fbc39af56e2df4d5b7da5197771f4b80a98ea7e775ea7a64bce612e70d5a7997bdcab6ba46239b03f9d7f41bd3abe9714ab8ec8cc7f31a5dc2454323dca82072fc4f4f873f79bd3a868fc5a4773a791e83e93ad6b862df33283346f786afeb0a647d448d54f3523faeb6b55cbf0a2933eb5b0bfc47c90b157ba91d3ad3573d4ac490aa63bae0f6fd05315b1c4ca4ae19f86211591d3c9846af730baf62475d511a766caf4fd0aa4dcda586851118d473d3b908d748b2d6d44abddf2bddfa554e0ff008956a461d3d691b77b7fa447fbb2b1538bc000792a600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a65556b8a929a44c3d4df741c9c725e9f78fedff00da1cde225eec5e87ac69cca88853b17a60ada26a2b90ed34b4f72f10c7483a3e34b5d92b2f6f6e3959cacfb4b0413495750e95eaaae7bb3d4c8efaa96bd0d454e8b85aa7aaafd859b4e454aeada7f7a9311f32737d8777a7ac6388aaec311329cf686c5269fb4cda8ae4bc9148c54622f9992e97bab67bb3a66bd30e7e53a98f6b3b84b53a66869f4fbb9e8e06273f27f7965d1b7591b52cf8baa2f530b269e7518ef92fe67b6dfa32351588aed0dd2d0b5ada8a1e572e7e12a74c44905faadede99764c136c6f68f89ac57fe699fd85c9f4a4cf45faca7cf9eacd14e1d5ef31e25768eff44d19854d0d05ce2f0eba8a3993d553aa7de63d5fb6f6c9b325aebaaa8a4ee987b9c9fa154c9e99551a8a55a7ae0d0f1ada3bc248b4d7c23d6694d7540bcb45aa5ce6a76e78d0f64a5dc587eb5d229513f78d4fee33a7b4f254f4ec5b38e23c2f8cbbf986112bf70989d1f0397ed4ff00c8c4354def58d2ff00c5eaea23472f746e090f556a8b769da574b512a78b8f85b9eaaa47d4f1545f667de2e2d5e493ac6d5f4359a8d45fde8c1867bfcfe8de68349cabefe5afd3f1faac168b75cabaa52a2b5caa89d7af992ae8e8123aa89a9e583198db1c4a88c6e3c8ca749c8d6d5c6e55f33d0ba6c4e3d26dbef2b75f3cab3b78481a9d552c8ff5e5fee35377526731b3e339ea6daea38bc7b2bb93afc3e5f61ab7b8f669aa9f335ad55ce50db748fe662c911e76962741b56b97bfddaf34f3abaa973fba33cb2468f89aa862973d395d6ca957be25e555ca2e0c834fd6f22246fe8a7cd9eaac56a6a6f5b7de5ed38a7dcc316867366ac968dede572a60906d37a74cc447bbc88d681cd99e9caa64f40f7418ea72f8af34687a8e1ade7bc7766d24de2a74f328a7891cd55c1e34957ce89d4ab73dae677327b5fcb45c671ced0c7ae14f96af430cbc532a3970848358d4764c56ef4a8bcca6bef5e376cf4b9369ee8feb627267a1acdc46507875d4d5089dd14dabb8d3a223ba1ad7c4c46d6c34aa9df2757e94bcc6bab11f2d7fa936be8acd7a57264fdca21e6eef93f3994f5cf8796c244d8bd46dd39b9369af7bf95be32317efe9fde74eea29e1b8504722615248d1c8bf6a1c8aa1aa7d055c15ac5c3a195afcfa617274f76cf58aea2db9b25e11fccb2d2b7997e6765e95cd3789c51e6277597ed30b16a75a5b2562ad753f346abe8477a96f76856be4b640d63953a92eea2828b5352cb47261b3222f22afa9aeba9e8eaacf5f352ced56f22ae33e67b5f468a678faf7e50d8c5b8e3de18d5f2ff252b669a24c39ad5767ee225ee671aa6e2df73999ca88ae4e5fd260e709fc49cf16d661c11fe1accff9cedffea8714cdb7900079b2500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f09d30e45f53dcf39dbccccfa19bd3b2fb3a9acfdfb7f9acc91bd65e6c5f22e9698dd2d4471a2655ef44fe72db1a67195336d0f6663ea9972ac5465353af3aaaf9aa763d3fa3e1b66cb131e218769e30b8ee64894b1db2d68ecac5035ee4f4554312a6a97a630ec1ebac2f0ebbdf27ab6b95599e46267f353b14148e5c7736b9f5b3f899e33da15a7d35dd2bedb6b8fa2a6fa36e6e5928e74e554775e52484d23ee750dbc5a1e92524df17c3e46b9d34ee63dbd704cdb53aea7a691b67b84ab2534aa8d4472f6365197f118e6f8ff0037cfeac98c9178da53cedf573e9e4627377263d3b539ad45e6ee43568a55a2aa8a687ac4fc2b55093ac755e15644e55e8a878f7aea95f6673fd94d2c6d978c25ba47f33113e45722fc25aedcf47c2c722e7285d19d5a79d63b6f5894f3da5f2e5f52d3a82ed059edb355ccf46a31aabdcba4abcbd7d084b7b35254b9adb3d2b979a4e8b8307aa6ba34582727cfc367d1f43f8fd4d71fc7cfecc6add3dc371358bea2a5ef5a0a676513c949367a76c51a43122358d4c2164db6b0b2c7a7d923da8934e9cce5f32ed7aa8e4a395cc7a2391ab8ea6074dc738717bd97f3dbbcba3ea3a98cfa88c387f257b47fba867446a651c8a5c2c756e8a56bb3d948cad3a86b3dfe686b66e66f374ea66f67ad6caf456a9e8dd0327e234dbc30b5f8271471b278a37b6bacdd7ae5840bb98b0d05448aacc222a9376969556cf95fdc90aeee451cb512f3af4ea6e3a3c70d4da93e1cee827dbd46c89595f6bbd2cb473c5954ce17061373752d05c96181dd97c8bdcf75b7d81b5132a22bdc8a8861b68827d437b4913387bb278f7f10f0e2aeaed148eef61e857b7b536bcfd31093748d3cb52d6cbcab8c198be9958dec55e97b0d3d15046c444cf2a64b9d551223570d3cc2da6988ddadd5eb6b9734ede164a49d637614b8a55a2b70aa5ba7856372e0f3e7727998d5bcd7b4b1af58b775c5d2a3d57a969b93115aa7aaceadf328eb2a515aa8ab916efdd4a47196297662222f4356389b9f0fa48954da9bb393a9a85c4e56a3af947468bd51aaaa9f79d3fa46936d7c7e90d67a872c468e6108b93a9fa8d40abf7043d73679c43f5fd637267c8dff00e16aa9d5bb1f6f7b9d9581fe17d9d0e7fb91dc8ec2791bcbc1bdcdb36ccd4522b933057b931fec9bff004bde71eb663f49459e76aeecab555e6a2d3509510b9515ab9e859751dbe9f7074f4975b735befb48c5595a9dd510a9dc073579d4c274eddee961926afa4933039aa9237c950f77e9bb64c55c98fb5a3ff3664e9f36d1b4f8425abf9e199b4efca3b9d729f674fef31c323d7f7a82f9a8e7a9a681b144cf811adf376555cbfa571f718e1e49eadd6c6bfabe6c95f113c63ff6c6d3febba7a44563b00039c5c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000054ca617cc0113b77191e97d28d9e996fb799122b7c7d532bd5ea9e487cdf755254a2d0db9be0d2b3a3513a653e6592a2eb5eb411db9d50f5a68d555accf44cf5fe9c96f47fccf53d375dc77d163c7a68da768e53fafcff00e7d98338e62d3367bbddceee6ce727bd3bf97ba9448f53e9b2e14829a8efbcaabc472f65c997e9499def31bdaec2b5514c1209b38330d2550d64edcfa9bee9fa9daead6766e46d8d532f7668a29951648910cf9637524b1aa792905ed6ea2fa3e58dad7e1aec74276f7c8eba959335532a8705ebfd34ce932f1f13dd91a2b44ea22652469ab8a4f4cc6abbaa2193c3222a119698aff06548957a120d3d4a3a34545f23c6fa5eabddc11bf98ecccd562f6ef3b2a2b5e8c89eecf64c9085fadccbdeacf799bac50b8976ed58d6d24899fcd21abd5d1292595215f89cab95355ea1d4e3ad6bcfc44eedff00a7f1df7b4d7ccaff0074d4b4b6e85b0c6f6a246dc21196aedc69163922826f2c773e6e0b5d72e646b9dd4c56e5a22e5519932ab93978eb3a9d764e38fb43afd2e834ba7ef927bac747abeabdff0099d27d67137681ba36b638d5cecaae08563d0d5914c8ae45ca2fa12e6dad8aba19a28d5171943ddbd1183253a75ad9a7bb4bd72f8a677a367b4c37163572f6469076edd4224d32e7d49c28dff4769c735fd1519fdc6b4eee5e115f2aa3bd4e83a5d26d9ed7721a0a45b3cd900eafabf1ae0ca747fc2aeebd4ca745c74b42ac91889ccb8ea43dab35248b7772468bf0b94b9e9dd7f252bdada872a350f1df5be0beaf5d7b63efb3d2343aca570fb569d9b6162be31cd631ca8654df0ea62ca2a2e4d7fd35ae68eae362b674cfda4aba5b51c7528913a445fbcf389b5b15b8e4862eaf4ffe3a2e771a1e455760b14cef0d70665528c9a2ca75e862576a758dcaa8616a29113caa87065e5da56e9a65f22df533f45ea7b4ae54ce4a0aa72a2298d1dd93bc42d371915eabd7a1a41bf3774b9ee0d646c76594df0260dd0bf56b68e82aaa5eb86c5139cabe9d0e7bea1ba3eefa8ae35ef72b9649dfd7ec553d07d13a6faef9a7e3b393f536a3e9ae3851e727db50f047264f46bfa9e8d2e3d52c67322a1b4dc18dde46592f765e6f812659513ee44357215454e86c9f0770b9b35e5fe4e6ff00e46c3a25e71ebab31faaccf1fcb4b1af9fd646afa11647aa60b2d25736b539e2489ee6b57cd71d13ef524ddc5456a3de9e86b76b4ad5755fbab5dfbe727dfd0f53ff008ecf4cd2cdabe76edfbfc2cd3473fa58dbdee91ee91eb973955cabeaaa7c80799cccda7796d00014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001f2f6f3b15bea502b95aaad77454f22e251d7458fc7b7ec71b3e9baa9c37f6e7c4ff0074596bbc6ef8493e67ea2a2f5452991fd4f46bce92b97763ae14aeea64da7e6564edebe662b4ab954328b0c4e74cdc7a9bad1649de164ca70d0956e59e2c3ba650d88b3d4c9f46b15173d10d79dbfa1739f1ae31d50d88b1c08db63b9d708d664c3f53f0cda4b56df65305a6b9627f564365af73a66aa2f9923d0576699b95f2211b0dee34aa7355fd9f8254b457327a76ab573d0f98f459fd8cd7a44fcbafd561e71167bea1b82b291ff12f65227ac6baaaa5ddd72a67bab2a1cda554cf7430eb3a324a9e693d4d3759cb3a9d4462996ffa563f6304de1596bb3471c2b535088d444cf52c17cd596ba195d4ed5472a74e8663596bb8dda258291dc8c54c64c4ab369e4f156a2a65e65ce54e8ba4f4aad6227c426c3974d92f36d55ffa2cd6ebbc570ab477222355498f414303aaa046b53ae08e68f49c1452a23153284b3b7b6bf0e68e455ce3b1ed9a18a69fa7c5627bb4dd6326398df17867fab24f76b1b918b8cb3fb8d4cdca7ba774ed55cf736b35d3b96caeebd9a6afea9a34ae9e462af755327a7ff2f4d93247ead7743ac5efdfeed6eafb0d34d7173a67b51557cd4fabc6827adb96aa8551ca899f854912edb5553719164a6995ae55ca164acd1facf4ec4f44474b0f9f9f43c27aaeb6d1a9b5b97cbd0274d86636844f6dbbdcac95a91bdce446ae151499b43ebe7f3c6e597af4f322cbfd14934ae75445e1499ebd0a7b0d5c94350d639ebd14d7eab4f8b5b8f9c796bf1db260bce3bf86ede9cd4715d68d8f6c88ab8f52a6e51a4ad55c10bed9ea558a48e19245e577aa932ad4326811ed54c2a64e4f2e39c569a598f969eddf78639574ead72968ab6e1ab9322ae9624ce5c862f73ad859cdf1a18b18fbed0922fbc77467bd379fa1340dd6a11dcaf96258d9d7cd4d134661ce779b955cbf6a9b35c4feb3864a1a7d3b4b2e5ce773c888be46b4a9eb3e95d2ce9f47cad1ded3bb86ebd9a32ea38c7c3e11a7d765ea3ae4fdf3caa9d34b4aaca55f536c3840b6f2d92eb5eadfad2ab117f41a950bf06c870a7ba16db254cda3ee8e48fdf1fcd0bd7b2bbd0cce9b92b8b55136532c72c73b25bdd19e1a3a1a8aaa87a363898ae72af9221aa35f56fafac9aadfde57ab913d13c93f41337123ace2a8bb37485b6547361c4d5ae6af4e65eac8fee4c397ed6fa29089bdea5aaf7ad18e3c47f75fa3c7c69ca7e4001ac6600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007e39a8e6ab5c9945e8a7e81e05a6a21741272f92f65f540c4555e885ca689b3315abdfc97d0fda1b64933d3a1d0f4fd47bf1c67cc3172d783d2d948e91c9d0cff4b5a1ef999f077528f4f69e7bdcd4467f3130e89d1aaf92373a33a8d3de31c6f2c69b32ddbeb2391635e4f4251bb54be8e812df4abf8d7a61553c8a3d356982818a8d4f89a99fb0a1a8bbc73de9d43062595132a89d7078aff14bd7b3a089e97d3fbe598ef3ff006c371d2749499fc4e7fcb0b348daab3c8d95cf5c3972a4a7a2f51365a66239de4441baba861d35a6dd593b151f9c21e9b63ae22b858e9eaf38e643c7fa365d44e0fc5649df79f2ea7166c5ada4d6a9af53d7b25a6544316b74ae6cbf0a7996cabd5514ea91b9fdcaab75d695ae4547213ea267365e6dc696bede2e0942c1519a74cb7c8a2d477258637222e0b3526aca7862463553b163d47a852a2372b5d8c9bdff00884fb35a639eed57e0e6734da61e4b7691f53d1fe6493b7b779bdea289cb945212b6d5acb55d5de64b7b7f875c20c7aa1ed3e9cb5f374a89cbe7661f51ac456612c6b86f8b637bbf79fdc6ae6a5abf75ac7657f38dacd5cd6374f48aeff37fdc69cee255f855732b57b2a9bde93b64d264a4fead6748bcd2dfd5905aae31ca8d5ca297f92182b69d6391a8a8a9e841f66d66da5a84826931d49574e5fe0ac89aa8f45e9ea7cddea3c56c3a9bfeeeeb6b576b423ddc3d094ef73a78e044ce5728842b7db2bad73788d4c2229b67a8d94b5546ee656aaaa1ae3ba5e151432ab7e66bfa3e7bf3f6fcc26cf923262e57f30f3d1ba85227b1125c39ab8ee4db6ed66896d6f3499544f534c6dfaae5b7d7261ff0e498b4eead6d75b55c9327d5f5361d4fa65a2d17dbb4b558b598f511b7cc242bcee2c6c91cd59b18f991cea9dd68e99922b66cb911709923bd65aa648eaa46c5279af99195deef5152f773c8ab9361d2fa05724c5f2355d43aa46189ad3ca9b5adfaa7505da6aea87ab95cbf0e57b18cae50aba87e5cbd4a553bdc58e3156295f10e3325e725a6d3f2fccaf4c1f4899ee7e222791e8d4e84a8c62e0ba69e5ac8aeb4f5b4722c6fa67a49ce9e45be1824a895b0c2d5739dd110cb6868d9434ed85bd5dddcef5525c38b9db7fb26c55e5fb2baaeaea6beaa6adac99d2cf3bdd24923972ae72ae5554f100d8b24000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002becd5f1d05631d52d5740e5449113ba27aa1400bf1e4b62b45e93de14b562d1b4b65f45692a7ae829eb6915b3433351f1c8dea8e4526ad3ba45f4d0b5238fe37a613a76350369f776e7b717148678dd5b6699d99e9957e28d7f771e7b3bd53b2fc970a9be3a1eef64d4fa7e9751d86e1156d255b3999246bdbd5aa9ddae45e8a8bd514d0faeff008836f4cf4e8be3a4cdefda27e227f7fec8b49d36da8cdb5a7e98505d2ddf40e9cac9dabf8c8e173dcff9e086387bb8cba8f506a1b9d6cab23a37f2b33e499260dd5ab929b475cdb1e51cf85cd4fd042dc26d2ba38ef72c9de47e3afda7ce7835993a874cd5f53cf3bded311bcfeecdea74b61e38ebe190f1196b8aab6f2e12a332f8539dbd3e6613b674333b6e28eed408aa9137f1889e44c1bbd42cadd1773a7c22e615523ce15eb69ebf49d758e7447f83339bcabe8757e8dc91aee996c53e62cc8e8f9ad8a932b6d56a88d5515afc39bdfa9f543ab2657fc32294dbb3a3e4d237f6cf0357dc6b172d5f26afa161b640f73d1cd5ca1bcbe8eb48da5d3e9f55379de1275a3504d3bd1ae7af52ef71aee685139bc8c1edbcd022499ec54cd7b473fc3738c5c38e232f66cf78b477655609564aa4cfa93aedad3f895d12fa6148174939b354b57286c6ed2d2a4b706f9a23727bff0045ace3e8f16fd1cd756b446fb33adc5a9f75b0b9bdb2cfee34af726b9ac9a672af9a9b7bbc952b0db7c34763e1347b752b95af9b0ef5373d36b18f437c9fbb5bd3636fa9155daf8f8eadce8df8545e9d4bfe98dd3abb4b9192cbf0a7cc8beed5aad99eaaeeea586aaf0f62f4729e35d4fa763d6e5b72fbb7d3d56714ed2d9fa9de282ae9d1a92f55efd48ef71b51535d6dee56c88ae54225a5d412630b22fe93cee17c9266f2ac8aa9f69a9d3741ae9b2c5aa8f3f59ae4c7355b6a6454915557ccb9daf55565ba258a3997955318c98f55552aaaf52896a573dce9a74d5cb588b4395fc55b15a66b2bddc6eb25648e7c8fcaaf52c5572732e727e3e655cf529def55fbcc9c78a31c6d0c5c99ad9677978499553cb954f67264f9e4f91344a17cb1aa8a7a3237c8f48e36ab9ce5c22279a9f70d3c93bdb1451ab9ceec8864b6db5c542de7761d32a7577a7c909b1639c93fa2fad26f25aed8ca08b99f874cf4f89de9f242b803615ac5636865444563680005ca8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000675b55bc7ac3692eab5960a949a867722d65ba755582a13b67f7afc767275ed9ca745c14189add0e9ba960b6975748bd2de627c7fe7da7cc7985d5bda93cab3b4b7a1fbaba577876febeb34dd52457086055aab6cca893c0b8c671f9eccf67274ea99c2f42d9c31d86e54b6daf96b2996359655c6531e6699db6e770b3d6c771b5d64b4b530ae592c4e56b93d7ee5eca9d94d9ad8ae29acf695669fdc4a64a46c8e446dd29e3cc79ffad8d3ab7fd26e53e489d4f16f537a0b57d27a766c3d16b39315a62dc7cdebb7c47fdd1ffe5fa4f96cbded3eb2b1eff6bc78fb4ffb361f58e9a92b2c7591bd7a3e17a7f31ab1c36df9da7b74aeba66a5dcac92472222fae4dcf96b2d97fb02575aab69eb68eaa2e686a2091248e46af9b5c9d150e7f6aea89741ef8cf708731afbd23ba744c64e77f86d9ef1933e96fda7edfac7965534f5c74fa7e5b9dba5a361d61a5a6a78e245a885ab242b8f3435a34f78f4b532dbab9aad9a072b1517e46dd692b832f961a5b8b1c8e6cd135729f6113eeeed64f1553b55e9da7cbbbcf1353bfccf4dd5639b579429a3cdece4e16612d7a242e44f431ca899def9dfccb9535c5b2c6b1488ac91bd1cd54c2a2966a85c55abb263f4ed3464cdc65bdb66fa7b24bd04ae7ccde9e86d7ecd513915f52e6f661aa7b6d2c6e91b9c2f5437276a1b17d0b24d1b7af260f72b53f0bd2e948fd1cdf55c9bc4b0bdf8bcc70c4b173a671db268eee75d525925447672aa6cd6fcdc2a9d72a8e67ae132699ee0dcdfe3c88aef353659f1fe0ba46ff3308f06d8b144a35bdd5a78af4cf998e54ceabe6545caad6499d85f352d923f2795dabbda65839f37393c754ce1ca7c3ea5cbd154f372e0f17aaf917d6ac4b649f87ecb2abba21e48ec9f8e453e7b12c42199ddea7c3f087cabd10f84e791e8c6355ce776444caa97ecb5fbdd7a95545413d6bf11261a9ddebd90aea0b03dd892b97953fcda2f5fbd4bdc71c70b1238988d6b7b221918f4d33dec9eb8a67bd9e147410513311a65cbf59ebdd4a900cd888ac6d0c88888ed0000a8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cbf40eecebddb59d5fa52fd3414f23b9a6a293f194d2af9f346bd33e5cc9877ccf1dc5d7736e0ea08752d45b22a3aac278ec85cab1b9deadcf544f92aafdaa62c0d4e7e89a0cf9ff001738e232f8e51da67f7fbff5dd918755930f6acf6fb379f85dd7d15f74ca59a699165a54c3533e44df3a248d54544545e8a8bd94e5d58b515f74c57b2e7a7aef576eaa676969e5563bec5c774f92f4273d19c666bcb2b594babad3457f81bd1666ff00c56a3ed556a2b17fdc4fb4c0cfd1b2563f973bff00a24bea6b92dcb6d9b05ae7682db7d74970b32b692b572aa89d1ae520fbbe92d5167ac7415b6f7bb9571cedeca48765e2eb6b6f68d65cd6e564957bfbcd3f891e7e4e895cb8f9aa217e975de8ad4cd496d1a96d55bcdd9b1d4b15ff0062b73945fb50c5d1e83263d4562f59865e3d5cd6bb6fbb17dbea2ab830e96256f5ec6e66ca2e74f4cb2f937fb8d71d3f0c2f9915188899f236636ae16374f4ead4c272ff0071ea7afdaba0ad3f661ebefce9bb5ef7fe58db5d53f355347f7226449a6545f3372b882a95fa46ad33d954d25dc09b9e49baf99b4eaf1c7a3577fb423b5e631c4231a97aba472e7ccf15fb4fb97eba9e6e3cb663796bed2f37af91e4ee854369ea255c470bddf621ed1d96b64fafcb1a7ef97aff00317d71dade2166d33e216f72a1e587c8e4646c739cbe4899532182c34eceb5123a55f44f850b84504303796189ac4f9260c9a69ad3f9bb2f8c333e58fd269fa99b0faa7784df44eae5ff00c8bdd25052d137104488be6e5eaabf79500caa62ad3c26ae3ad7c000245e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b8db351ea1b2b91d66bf5c68153b2d3553e254ff007550ccecfc44efa5862582d5bafa9a18d7bb16e0f7a2fdce5523b05795b6db7ec7966f76debdd2beb9cfbc6b0aaac73feb2cb144e55ffb26255f73aeb9b95d5d3acaaeeff0a27f4214a096fa9cf929eddef335fb4ccedfe4aef33d9e5ee94d9cf80c5fb50fb6c5133ea46d6fd8983e818f1588f10a6d0000b8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fd6b5cf7235ad5572ae11113aaa9246c2ec2eb8e2175c43a3746d32471468935cae53357ddedf4f9c2c8f54eeabd51ac4eae5f44457275a763b850d98e1f2d71d458ac54f5b7a8a3cd55fee4c6c954e5c7c4ad72f4859d3eab309d3aaaaf520cb9eb8bb7cacbde2ae4ee96e17b887d6717bc69fd9dd512c38454967a075346e45f36ba6e5477dcaa5e2e7c19714568a592b2af662fcf8e36ab9c94c91d4bf089e4c89ee72afc913274e75b71cdc30e84b8c969b8ee5d3dc2b22ca3e3b4d34b5ad6aa2aa2a2cb13563ce517a7364b05b7da2fc2ad7ced826d6772a1e672351f5366a9e54fb558c761087dfcb3de2ab3dcbfd9c90d41a5f52e92aefa2f5569db9d9ab7979fddee149253cbcbebc8f445c7dc5b0eeeb26d94e22748cb1325d31aeac12af248d458aa991bfbf5eeb1bd3a2f9393e473d38c5e0227da6a1aadceda06d4d7e92a74592e56d95eb2d45adbfe71ae5eb2c09e6abf133baab932e6c98f53179e36ed2bab9226769696928688e1877ff0071ec8dd49a376aef75f6b91331553a36c11cc98cf346b2ab7c46f5eedca11e5927b6535eadf537ba592a6dd15544fab8235c3a5851e8af622e530aadca774ee77c7446a5d25abb4b5b6fba1ae5435d64a8a762d1c946e6ac491a222235113eaaa27456f454c630573e69c5b6d0ae4bcd3c382daa349ea7d137a9f4eeafb057d9ae74cb89692ba9dd0cadf45e57226517c953a2f916a37b7daa5ab3415e75668dd3f64aba3abd4b6782b3e957d3c88e753c322c4b0c32e3f3b292391aab96a2e71f1a1a24498ed37ac5a57567946e00091500000000000000000000000000000000000000000cc74eecc6f0eafb4c37fd27b51ac6f56ba8572435b6eb15554c122b5cad723648d8ad5c3915170bd15150c38ec5fb3c7f24cd1ffc3dcff5f9c873649c55de16dedc6377293526ce6eee8db5497dd5fb57ac2c76d89cd6495972b1d55340c73970d4592462351557a2267aa9879d7df68f7e4af7dfe31b77eb0d390430e49cb5e5252dca370004cb800000000000000000000000000000000000025cb2f093c49ea0b0b3525ab673514941231648dd240d8647b53cdb13d524722f961bd7a63392d1c3a5f346e9adf2d137edc08e275828af104b58b2b79a38d117e091e9e6d63f91ebf26af7ec773686e36fb9d0c373b6d753d551d44692c5510c88f8e462a651cd727454c7998d9f34e2988884792f35f0fe7dae56cb959abe7b55e2df53435b4af58a7a6a989d14b13d3bb5cc7222b553d150a63683da31aaf436ade2325a9d0f5f455bee167a6a0bb54522a398faf8e59b9d15e9d1ee6c6e898aa8ab8562b7bb551357c9e96e558995f13bc6e000b95000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000241e1eb4ea6acdf6dbfd3ef89924557a92de9331fd9d0b6763a44ff0071ae2933b46e4f675bf846d8cb7ec2ecc5a6c52d2c71df6e7132e57d9d71cceaa7b51563577ee6345462797c2abdd54d32e2077cb74f8c8de1770f9b1354f66948667c0f921995915c523e92d5d4c8d4e94cd5e8d6a651df0ae1ce735adddee2cb5acfb7dc396bed4f4954fa6a98ed2fa4a79a3fad1cd52e6d3c6e4f45474a8b9f23597d945a36db168dd6db82e891d70aab9c5666bd53ab218a26caa89e9cce99b9ff0041be86ba93b45b34f963d7c4de55fa6bd949b5f0da6166b0dc9d535973e4fc7496d4a7a6839bd1ac92391d8f9abbafc8c37517b2b65a7d7d67a6d3bb8755368faf74ccaea89e958eaeb7b9b0bdf1ae115ac958e7b518aa9caad5727c2a9954da5e30f881aee1d368ddab6c743055deee75d1daed8da86aba18e67b1ef591e88a8aa8d646e5c67aaf2a76c901f03bc6cee4ef16e4d46d86ea496fae92b68e6acb6d753d3369e464917c4e85cd661ae6ab15ca8b8454e4ebcd9e9756f9a6b3789ec44df6e4c4b723849bcf059a1ae3bffb63bd77a75dec335237dd1d40c8a0ab64b531c4e8e6447aa3d98915795517b792e1536ff86cdf4b17127b4d4fabd9430c15797dbaf76e77c6c86a51a9cedebde37b5c8e6e7f35d85ea8a617ed0dfc92f58ff0f6cfd7e035c3d93576ac66a1dc4b178b22d24b454157c8ae5e56c8d7cadca27645547f55f3e54f4293139714dede60fcd4e52d6de3076629f6337daf7a4ad51f8765ae465ded0cce79296657623edd9923648d3e4c45ce54e94e97e06f872b4db2392d1a62f76f5ad8237542526a6b94292aab7f39193a22f75fd26b37b59add4d16a6db9bb3236a5454d05c69e47a2755647242e6a2fc91657fe953a2b67ff9a287fd5a2ffc28572e4b4e3acc497b4f18729bda0db05b59b0f7dd1945b61a7a5b54377a4ac96b1afad9ea3c4746f891ab995eec611ceed8ee383fe05ae3bef471ee16e0575559b4624aada68e9d112aae8ad5c3b9155152389151515f85555454444fac92c7b4ef4fd46acdd0da1d2d492b629ef2b536f8dee4ca35f2d453b11553cf0ae37e74be9cb4e8fd396cd2961a46535bad14915152c2c4c23228da8d6a7e842eb66b571576f32acde62b08d34c7089c34e93b7c76db7ecbe97ab64698f16e742caf95cbeae92a39dcbfa71e87bdfb850e1b351d04d6eafd92d2104733158e7d05ae2a295117cdb2408c7b57e68a8407c7e717bad764ee568db3daeab86df7cb851a5cebee4f81b33e9e0748e646c89af45673396391555517088984cae531be03f8d1dc4dcfd7f26d2eee5de9eed515f4b2d4da2e2b04704eb2c49cef81c91a35af458d1ee45e5472786ecaaa2fc317b79669ee6eb78db6e48c38bee0064da5b3d66e76d1d4d5dc74c52278b72b6542f89536e667acac7a759214ca6729ccc44caab932adc57d9f5b25b63be1aff0053d937434cfd35456eb3b2aa9a2f7da8a6f0e559dad57660918abd15530aaa875aeb28e96e3473d05753b27a6a98dd0cd148996c8c7261cd54f3454554340380bd10cdb6e2bf78f42431b994f64827a4a6473b997dddb5adf055557baac6ac5fbc92b9ad6c7689f30ba2f335984fdff07e7089ff00449ff7f5cfff00a938d67f4367f3c85fa4b5adbef2bb14ccefbba57c1c7081c3aeeaf0eda5f5d6bddbcfa52f9717d7a54d57d2d5d078891d64d1b3e08a66b130c6353a35338caf5ca96ee36f84ae1f7687612e1ad36ef407d137982e14704753f4ad6cf863e4c3d392699ccea9f2c93a7b3d7f249d15fc25cffb46a0b4fb493f25bbaff1adbffad22e76f7b6dfb6eb394f3db773d385ae17355f12dabe4a0a29dd6bd376b56beef77733992245fab0c49d9f2bb0b84ecd44572f923ba75a03825e1a76fed91d041b616bbece88df16b2fd136be699c8888ae5491158dce338635a9f23cf820dbeb5edf70d3a3a3a08189537fa265faba646223a696a911ed572a77e58d636267c988661c4049bcebb6f5943b0d454926acad9194f0d4d54d146ca28972af993c4f85cf444e56a617ab915515130532e5b64bf189da14bde6d3b43cabb862e1cee303a9aa363342b18f4c2ac161a681df73a3635c9f6a29a7fc50fb376cb6cb0d6ebae1fd2ae292df13a7a9d393cae9fc58da9955a691caafe744455e472bb9bc951708b28f0d3a738eed19afe28b7aeba9f50e91b835ecab7545d69e69e89f85564b172fc4a9cc88d56671872aa265133b785bcef8adda775394d27b4b8d3c0bed5682de3df24d1db8f61fa5ed1f43d5d57bb7bd4d4ff008d62c7caee785ec774e65e99c753a1ff00f07e7089ff00449ff7f5cfff00a9204d92d0f43b7bed2ed71a76d548ea7a17dbab2e14ecc2a351b531d3cea8cfdea3a573531d13971e47408bf3e4b7289acfc2ec969dfb3821bbb62b5697dd7d69a6ac54beed6db4ea1b8d0d1c1cee7f850455323236733955cec35a89955555c7555377f812e1536137976465d5fb93a0fe98bbb6f75546951f4a56d3fe258c895ade5866637a2b9dd719ebdcd2fdfcff001e9b8dfcadbbfeb929d28f661fe4d93ff296bbfaa80c8cf698c513129324cc57b317e2b7835e1b76d787dd63ae3456dc7d1d7bb55341252557d315f3786e754c4c55e49277317e17393aa2f731ef67cf0f7b2dba3b1959a937036f2d77cb9b350d552b6a6a91eaf489b0c0ad6747226115ce5fbd4d8ae39ff251dc1ff53a6fd720239f65e7e4e15ffca9adfea298c78bda70cceff28f79e0ccf70b815e1f754e91aeb0698dbdb469eb8d63a0632e74cc7acd4cc4998b2b99972a737868f44ca632a99e8657a4b846e1b7475960b2516ce697b83616f2ad4ddadb157d44abe6e749335cecaafa6113c9113a1266a7d4768d1fa72e9aaeff005494d6db3d1cd5d5732a679218d8af7ae3cfa22f4399bacfda99bc55da82a65d09a534ddaec8d9152961afa796a6a5cc45e8b23db235b954c2e1a984ed95ee5948cb9636895b58b5bc318dff00e1d9fadf8dcbcecc6d069ba0b3d35436866f0a9a0f0e928215a285f34ce6b130c622b957098cb9c889d5c86ed6d67003c3aedd5a6186f1a4a2d5f75e444a8afbd6656bdddd7920cf84c6fa7c2aec632e5ee625c06ea4aadedbe6e37127a9ad745497fbed4dbec0f8e91aef06265251c5e22c7ccaae6a48e731cad572e391a995c6576c6f978a0d3b65b86a0bacc90d15b2965aca9917b3228d8af7afdc88a5d9725e36a6fe15bda7f2a0fdc0e05b868d7b6a9281bb7547a7aa958e482bac69ee92c2e54e8ee56fe2df8f47b550cbb86bda3aed8cda3b6ed857dce2b8bad1575cb155c6ce449a196aa596372b7f35dcaf6a2a6570a8b8554ea73cb51fb4e37fab359cb78d350d8edf6064cef77b44f40d991f0e7e14965cf88afc775639a9955e874a366373ad9bcbb5fa7772ed30f810df291257c1cdcde04cd72b268b3d33cb231edce3ae325b9299295dafe0b45ab1dd0b7b47bf257beff18dbbf586981f0bbc18f0d7b8bb05a335aeb2db7fa42f576a17cd5953f4c57c5e2bd267b5179239dac6f46a27444ec679ed1efc95efbfc636efd61a65fc13fe4b1b79fc5aff00ebe52b169ae1ed3f26f314ecd50e3fb85dd8ad93d9cb36aadb1d0df435d2af5353dbe69fe93aca8e6a7752d548e672cd2bda99744c5ca267e1ef855ce986cfd86d5aa776f44e98bf52fbd5b2efa8edb415b073b99e2c12d4c6c919ccd547372d72a65151533d1514e91fb54bf27bd3dfcb3a4fd46b4e7670ff00fe3e76dbf95d67fd76232b05a6716f32971cccd7bbaadff07e7089ff00449ff7f5cfff00a939dbc72ed6683d9ddf49746edcd8be88b3b6d3495294def53547e35fcfccee799ef775c274ce0ecc9cf1df6d216fd73ed2fd0da76eb1f894afa7b7d64b1af67a534735472afc9562445f92a98fa7c96e53369f8478ed3bf7657c287b3d3455934bd06b8df6b236f7a86e0c6d54566a8739292dd1b9bf0b25622a78d2e172e47658d5e888aade65d989b866e1d6a29d6964d8bd068c54c659a7e958ff00f7dac477df924b39ff00ed00e2f37436db70a936a36b6f8b616d1d0c55d72af86363ea26965e656c28af6aa31ad6235caa9d555ddd113ad913933dfb4ad89b5e52cda3d9e5b1564dd59b57c1a7a1aed2f596c9e9e5d3d5ef7cd153562cb13a39e17abb991bc8d95aad72ae39930b8e89207f81a70bdff42fa7ff00dc93ff00510a7b3d38a9d71bd0fbfeddee6dda3ba5e6cf4ccb950d7b98c8e69e995e8c91b2358888bc8e7c587632a8fc2f6455dd229927252dc6d25a6d13b4cb93bc16ed46dd6e0f149acb45eb4d274576b25bedf7496968aa11cb1c4f8eba08d8a98545e8c73913af99bf7fe069c2f7fd0be9ff00f724ff00d46987b3eff2ccd7ff00c5779fed1a73a6c5fa8bda2fda576499896bb6d3f02fb05b7b4d53557ad0b69d4d75af9e49e592eb4edaaa7a76b9ee736186191158d631151bcd8e67632abd9135dfda55b3db6fa2f47e8aaddbbdb7b158ee371bc4b46ffa1ad91d33ea1ab165ac56c4d4e65e6c63a6725ef8a6f68b6a3db9dc4b96db6d058acd54eb0cdeeb71badc91f3b5f52dfdb228a363da89c8ef855ce55cb91c9ca98455b270dbbf9abf8cade9d25a7775ac16158f40beab5653cb434ef8d26918c643136463dcf4cb259992239153ab13a799752b92bfcdb785622d1f54b20e1a3d9b5a4e82c543abb880a69ae779aa63676e9f8ea1d1d35122e15ad99cc5474b27ee9a8e462655b87e326d3d370d1c3b52429045b17a09cd44c664d3d4923bfde73157f9c928d2ddf6d2ded09d63b9770b96d75d69f4ee94a39bc2b4d2d3dd296374b1b7a78d322e55ce7ae5dcaee888a898ca2aac5ced96ddedb2cde6f3de5286e57027c36ee35ba4a78b40d2698aee47360aeb03528dd1397cd626fe29fdbf398be7854c9cbee23f874d61c376b76e96d472b2ba82b98ea8b55d2262b23ac85170bf0aaaf23daaa88e66571945caa2a2af647682a7732ab6f2d0bbc16ba3a1d5b146b0dc5b473325866735ca8d95aace89cedc395be4aaa89d30415ed22d0f43aa3869b96a29291d257694afa4b8533d88aae6b6499b04a9d3f37966e65f2f8117c8930e6b56fc667785d4bcc4ed2c33827e1a762370f86dd2dabb5aed95a2ef78ad92e09515950d7ac92232b6663338722746b5a9f7126ebfe033878d5f6582cd64d0f43a69cb590cd515d6e47254ac0c5cbe262b955115fd1aaaa8b84555ef83f3d9e9f92568cfe16e7fda15066bc536f0dc762b647506e25968e0aaba52a434d411ce8ab1a4f348d8daf7227746a395d8e99e5c653392cb5afee4c567e54999e5b41a7784ee1b74cdb21b550eca691a98e1623125b8dae2ad99dd3bba49d1ef55fb548e77d3802d92dced3d52ed13a6a8345ea48a372d155dae148699efc7464d0370c56aaf9b511c9eabd9753b874e3eb7ea7de2d3b63dc6d52cd4761d437282d9554f2d053c4fa759de91b6589d1318a8ad739aaa8b9456a2a633854ea80bc64c36ef25b9527cb847a1740490efce9cdb0d7d677b57f0b28ac978a17bdcc556ad5b229a3e662a2a6515c9ccd54ef945eca759e97821e19e8ad935928f41dca0b75467c6a48b54dddb0c99efccc4aae55cfcd0d38e2934cd169ef68ae8bada262b16fd79d357399be5e27bd321554fb7c0455f9aa9d3c24d464b4c56627caec969ed30e3471cdb57a0b6777cdfa3b6e2c3f4459d2d1495494def53547e35eafe6773ccf7bbae13a6704e9c25fb3b6dfac34ed16e46fc36b62a3b8b127b769e825740f920727c32d4bdb87b399151cd6315ae44c2b97aab52af88fd016ddcff0068de8bd137989b2dbeb68edf355c4e6a39b34303279df1b917a2a39b12b57e4e53a2ed6b58d4631a8d6b530888984442b9335ab4ac44f7982d798ac44231b770bfc395ae9994b4db1ba1dec6223516a6c74f50fc7cdf2b5ce55f9aa98feb9e0b7867d796d7d055ed4d9ad122e563aab1c296f9a37615329e0e1aec67b3dae6fc88f78a2d3fc6feb2d6b1d16c456c160d27410311b3c372a782a2ba754e67bdeaecb9ac6f46a37a670e55ce5312f70e4bbed0edf32d7c41d1d126a5a09dd0b2b696a22952ba9f08ad91e91e1ad91155cd5c2222e117baa904f2ac72e5feab3bc46fbb96dc58f091a93867be5355475efbce93bbcae8edd7258f95ec91115de04e89d124e5455454e8e4455444c2a26cdfb3e787bd96dd1d8cacd49b81b796bbe5cd9a86aa95b53548f57a44d86056b3a391308ae72fdea6cf717fa1e875f70ddaf2d55948e9e5a1b44f77a44622abdb514ad5999cb8eb95e456e13ba3953cc897d979f93857ff002a6b7fa8a6279cb6be1dfe775f3799a333dc2e05787dd53a46bac1a636f6d1a7ae358e818cb9d331eb353312662cae665ca9cde1a3d13298caa67a195e92e11b86dd1d6582c945b39a5ee0d85bcab5376b6c55f512af9b9d24cd73b2abe9844f2444e8499a9f51da347e9cba6abbfd52535b6cf4735755cca99e486362bdeb8f3e88bd0e66eb3f6a66f1576a0a99742694d376bb236454a586be9e5a9a973117a2c8f6c8d6e5530b86a613b657b915232e58da256562d6f088b8e4d23a6343f135ab34e68fb0d159ad50474124345450a450c6afa285efe5637a372e72ae13a6554818ceb7b376ef7be5b8b70dcbd456ea2a1b8dce1a58ea21a3e64879e1a78e157351caaa88ef0f9b0aab8ce32bdcc14d8d2262b112c98ed1dc0017aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000125f0cf7e6e9ae2136eaef235ab1c7a928229155d846b2499b1b9d9f923d57ee2343ee09e7a59e3a9a699f0cd0bd248e48dcad731c8b94722a754545eb92931bc6c4f776bb8ced293eb3e183706cd4cd91d2c56c4b8b5b1a65cef749a3a95444f3ca42a9f79aebeca2d636d9b466b6dbf5951b5f49738af0d62fe7c32c4d89553d795d0a67fd36fa9b47c3beeed977fb66ecdace27412cf554bee779a5fac90d635a8d9e3722f92afc499eed7b57cce76ef26d6ee9f021be516e86d9433bb4ad44ef75b6adcd74b4eb0c8b97dbeabae7a7444cafc488d735799abcbafc71cab6c53e58f5ef13496f87189c3f57f117b44ed2562ae8296f76cae8eeb6c754395b0c92b18f63a37aa22aa239923b0b8e8e46af6c900f033c14ee6ed06e4d46e86ead3d0db5f45453d15b6821aa654caf9245e574ce746aac6b5188e444cab97c4ea8de5c2dc74e7b56769a7b540fd5db75ab68ae5c89e3c76d6d35541cfe7caf92589d8fb5a433c45fb48f546e1d143a7366ed95fa4adf1d443552dcaa2462d7cce8de8f6311ac55646ce66a2aa65dcc9d1709945ad299b8fb7b7656b5bedc5bc3c606da6a9ddce1e755686d174b1d55eaadb4b3d2d3be448fc7586a6299d1a39d84472b637226551338caa275228f67b70d1ad76334e6a4d4db916efa32f9a9258208adeb3325753d2c1cea8e7ab155a8e7ba455c23970d6b7b2aaa2593653da3126b3d275b55ab365f575c2bf4ed0ad5de6bb4cd3455148c898df8a6724b247e1670abc9cce5c22e1570b8c43753daa769a8b0cf41b37a0ee705d2a18ac6d7dfbc26b29b29f5db0c4f7f88ef4cb91117ba2f62d8a65e338e2148adf6e28e3da8bb8741a97792c9a1add2c532692b5afbd3d8fcab2aaa5c8f746a9e588d90affb6be87506cfff003450ff00ab45ff00850fe7f6f77abb6a4bc56ea0bed7cd5d71b8cefaaaaa999dccf9657b95ce72afaaaaa9fd0159ff00e68a1ff568bff0a176a2bc2b5a99238c44342fda3f7ea4d2bbd5b23aa2bd5c94d67ab92be656b72be1c5574cf76113bf46a9bfb0cd154431d44123648e56a3d8f6ae51cd54ca2a7dc7383dacdffb4fb73fea171feb21334e0778dfd2b5fa56d7b3dbbd7c8ad578b546ca2b4dd6b24e582b604e91c5248bd192b530d4572e1c889d79ba2d2d8e6d8ab68f826b334898609ed48da5d56bae2c9bc36fb6d455d865b4c769ad9a2895cda39e29647356454faad7b65444554c658a99caa21877b35768352ea4defa5dd492d959069fd294d54f6d6ba356c35155342f81b0b5ca987aa36491cbcbf5795b9c73222f559ae82aa04735d1cd0cadca2a2a39ae6aff0032a1fac8e1a789191b19146c4e88d446b510b6351318f86ca7b93c78becd03e12b5f51ea7e3df796a29119eed76a6b8253c88ecf3a52d64113553d51cdcb8ce38c9e38b496dbe9bb9edded6dfa9eedad2be27d2cb5546f4920b435d96b9ee7a7c2b3226795899e55eaec6111dcede1f377ebb62f76ec3b91490cb5105be67475d4b1bf956a69246ab25677c2af2af3373d399ad5f22fc386d34b4cfcab4a4cd665dd6382fba9b63a936c372af1b7777b3d64359455d241491be25e6a98564548648ff76d7a61515339ce3bf43b8bb7fb89a3774b4b516b2d097ea6badaaba347c72c2ef898b8eac91bdd8f4ecad7222a2f742f55896d858b71b825331b4ad57acf372a244d4eaabccbf553e6478b2ce199ecb6979a4a20e0df415f76d786cd15a4f5353494d738e967aca8a7918ac7c0b53512ce91b917aa39ad95a8a9ea8a609ed24fc96eebfc6b6ffeb4d86d15ae34b6e269f8f5568cbbc374b44f3d453c35902e6299d0cae89eac5fce6f3b1c88e4e8a8994ca2a29af3ed24fc96eebfc6b6ff00eb4a526672c4cfdcaf7bf7493c265fa835170d5b6f5d6ea864d1c1a768e81eac5cf2cb4ec48246afcd1f1b917ec2978aadc5de0da9db076b9d9dd2f6abfd65bead8b73a5aea59ea15b44ad723a58d90c8c72ab5fc99eaa88d572f91a23c05f1896cd999e5daadcbaa7c5a4ae952b5143715cb92d752ec2391e9fe65f845554fa8ecaaa2a39cadea35a2f368d416d82f162ba525c682a989241534b33658a562a651cd735551531e857252715f798ec5a38dbbb9e9b33c767175be9ade8f43689d01b78f9ea1d9a8ac96d771f76a28f0aab24cf654bb91bf0aa274eab844eaa6cef85c777ff007fd85fff006979ff00f949d60a5a6a6e6f76a78a2e75cbb9188dcafaae087f884e2a76bf87bb0d44f7ebbc15fa85f1afb858a9654754cf2617955e899f0a3ca757bb1d971ccb845a4db9db6a54df94f686aeed66add689ed27acb66ec4da693523ac8fb43df608e76514af4a28ea588c499ce7f37868a8b954ead544f2cf41ce145b37cf5bd16f8c1bf95552da8d44cbca5e264455647265df1c099cab6358d56344eaa8d5f91d9fda1de3d07bdfa3e9759683bd435904ad6a54d373a78f4536115d0ccceec7267cfa2a615328a8a49a9c735da7f45d92b31b4b8ffc5ceddea5dbbe20b5b536a0b7cd0c377bd565dadf50e8d523a9a6a899d2b5cc72f47612446bb1d9c8a8749bd9f5a0b50680e1b6d74da9adb516fadbc57d55d529aa18ac919148ad6c6ae6af54e66c68ec2f5c390d8ca9a7a399124ab8217a45f1a3a46a2f27cf2bd8b3690d75a535e4171abd217aa7ba535aee125b2a2a299e8f8bde23631cf6b5e9d1dcbe2222aa74ca2a7916df34e4a457652d79b46c89f8e7fc947707fd4e9bf5c808e7d979f93857ff002a6b7fa8a6246e39ff00251dc1ff0053a6fd720239f65e7e4e15ff00ca9adfea29847fc89fdc8fc89478d3ab9a8b85adc49a072b5ceb5b625545fcd7cd1b1c9fa1ca7140ed4f1bdf92aee17f17c3facc47158c8d27e49fdd261f0e9f7b296ed4936cfeafb13266ad5526a5f7b923cfc4d8e6a585ac72fc95607a7fb2a6dd6e46934d79b79a9f43ba7581350d9ab6d5e2a77678f0be3e6fbb9b2720f833e2399c3a6e9fd297bf1a4d2f7e89b417a644ce6744d47663a86b53ab963557744eaad7bf08ab83b19a7352e9fd5f65a5d45a5af34775b656c69253d5d24c92472357d153fa3ba106a2934c9c91e4898b6ee0bea1dbfd6ba5b57cfa0afba62e34da820a85a55b7ad3b966924e6c2231a8997a397eaab728e4c2a6514ece7091b6d7ada5e1e747688d4913a2bad3534b55590bb19825a89a49d625c2aa659e2a3570bddaa4a7719ed36d824bcdd66a4a58692357c95550e6b1b1313baabddf553ef2cfb7fb83a577434db357e8ab8a5c2cf3d4d4d34154d6aa3265825744f7333ddbcec7617cd30a9d14a65cf396bb6c5ef37840bed1efc95efbfc636efd61a5fb80abbb6f1c28685970d6be9a2aca47b5173858eb266a7dead46afde587da3df92bdf7f8c6ddfac34d6ff006707143a7342ad5ec86e05d996fa2bad62d658ebaa64e5823a87a2364a67397a468fe547355708ae5722ae5c99ac526d83b7c4ab11bd1b27ed10db8bf6e370e752cd376da8b856e9dbad35ed29a9d8af91f1b192c522a353abb9593b9d84eb86a9ce5e1076ef51ee1f10ba260b1504f2c166bd51de2e150d895d1d353d3cad99caf72746f3787c8dcf77390eda35cd7b51cd722b55328a8bd150c6b54eb6d0bb7496f5d4576a0b5cb7cb8d3db28615e56cb595734891c6c6313abd799c995c744caae11154a63cf34acd2214ade623664c73d37bf565bb457b4cf42dfaed2f854a94d4144f917b316a629e9dae5f4445951557c932742ce497b4bdcade272673555152c540a8a9e5f5c69a395e63f431c6f3b3ada737fda35c35ee5dff007369f76f42692b96a1b6dcedf0d257b2db4eea89e9aa21cb5aae8d997ab1cc5661c88a88ad767194ce7fc2a7b437445fb4cd0689df5bd36c7a8e8236d34779a86afba5c58d4f85f2bd1310cb84f895d86397aa2a2bb95365a6e263875829d6a9fbe9a0d58899c335052bdffee35eaefe62958be0befb1116a4f86adfb35f872d75b7959a8775b7074d55d8a6b9d132d36aa5ae8dd154ba1591b24d23e276158d5747123799115795cb8c61577bc8036a78c1d09bdfbdb57b5db6b14d70b55aec75374a9bccb1ba264d2b27a789b1c2c7223959899caae72265513098ea4fe59966d6b6f65b79999de5cc9f67dfe599afff008aef3fda34e74d8e647b3e95178cbd7ca8b945b5de7fb469ce9b97ea7f3aecbf99c10ddd9a4a9dd7d69512b95cf9750dc9ee55f355a99154d87f6645fa82cfc4abe86b6a191c97ad3b5b414a8e5c7892a490cfca9f3e481ebf729aebbabfe343587f1fdc3f587943a2758dfb6fb56da75b697ab5a6bad96ae3aca593ae39d8b9e57222a65aa996b93cd1553ccd85abce9c53cc6f5d9fd001cf3dfde3bb8a2d8ddcfbde86bb6dfe888e8e9aae55b555545b2bb15b45cd98a547a5535af5e456f372a611dcc9d306d0f0e3c566dbf10fa729a6b5dca9ad9a9d9127d2360a89912a2191308e7459c78b12aaf47b53b2a2391aeca1334f4b4b53cab534d14bc8b96f3b11dcabea99ec6b6b3ed5b6bc6ec68fa67bc35676977038efdd6d1145ae5960da1d3905c1cf5a7a3bcdbaef154ba36ae124563665e56bb0aadcaf54c2f654310e2e2e7c5b59387ad5d53b8f53b3f369e9e1a7a3ac659a9ae6dad5496a238dab12cd22b328e735579917a229b9d77bc5a2c16e9eef7dba525ba86998af9aa6aa66c5146d44caab9ce54444fb4e60f1efc62d93785b06d3ed7d6baa74c50557bcdcae48d735b71a866518c8d170ab0b155572a9f1bb9553a3515d262df25fb4765d4ded6ed0dbcf67a7e495a33f85b9ff00685416cf6917e4b578fe34b77f5c85cfd9e9f92568cfe16e7fda1505b3da45f92d5e3f8d2ddfd7214ffaff00d4ff00a9fd5cb6d9aff1bfa1bf94b6cfd6a33bd4705766bfc6fe86fe52db3f5a8cef5126b3cc2ecde61cdee31bfca0bb53fc269bfed490e909cdee31bfca0bb53fc269bfed490e909166fc94fd96dfc43413762fd41a73da83a06e372a86430c9414d448f7ae13c4a8a7a98234fbdf2b53ef37ece4d7b49ab2aeddc52b2e14153253d552d96dd343344e56be391ae915ae6aa75454544545372f84ce347456fae9ca2d3daaeeb4765d7b4b1b60aaa19e448d9707227edf4cabd1dcc88aab1fd66ae7a2b70e5bb2e399a56f1f656f599ac4a37e2d78c4e24b874dcda8b0dbb42e90a8d29591c5359ae75b6eac7aced5627891be4654319e235e8ff851117979571d4be6c2ef5f1c5bf9a527d6768d31b4fa7ed8d9921a592f36dbac4b5a9ca8e5922464eee68d3289cdd957289d94dc29e9e9ea99e154c11cacce795ed47267ec53f279e968699d51533454f4f0b72e7bdc8c631a9e6aabd1108fdcaf1da2bdd6f28db6d9abdbb572e3534fed66b0bdea4abd9092d54362ae9eb5949497649df03607abdb1f3cbcbceadca379ba655325a3d979f93857ff002a6b7fa8a622ee3d38d5d2d7ed2f5bb23b45798ae9f483922bf5de99dcd4ed85ab95a681e9d24572a273bd32de5cb532ae5e5947d979f93857ff002a6b7fa8a625b56630ef31b6f2ba62629dd28f1a75735170b5b89340e56b9d6b6c4aa8bf9af9a36393f4394e281da9e37bf255dc2fe2f87f5988e2b13693f24feebf0f800065a5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004d5c2ef13dab386bd64eb9dbe37dcb4edcd58cbc5a5cfc24cc4ed2c6bd9b2b72b85eca9945ee8a9d65dbbdd9d98e25b454cfd3971b66a1b6d6c2b15c6d15d135d2c48bd1d1d453bf2a89dfae15abdd1553a9c302b6cd7cbd69cb8c577d3d78adb5d7c0aab15551543e09a3cf45e57b151c9f7298f970464ef1da565f1c5bbbac9ad7d9afc356acab7d6daa8eff00a5e492574af65a2e08b12aaf554465432546b72bd11bca89d93a743e347fb34b86ad335095377a6d45a9dcd7a3dacba5c91b1a63cb969d91653d51cab9341acfc72715962a48e8a8b78ae32471351ad5aca2a4ab7e13d5f344f72afcd5554f8bff001bdc54ea4a196df72de2ba470ccd563968696968a4c2fa494f131edfb515148fd9cde392ce17fbba9bae772787ce16f4525bef1358b4d5b5b1bbdd6c76fa78d27aacf4548e9d8997e55c9972a63ae5ca9dce316e25e34b6a1d737cbe688d3afb0d86baba59e82daf95245a689cb94665111113d1a9d1a8bcb95c656cf73badcef75f35d6f371aaafada9773cd535533a59647631973dcaaae5e9e6a529362c318bbefbcafa538b6834e7b3c37e3575af4a6a4d38fb15558754db286eadae756a46b471d440c955b2c4e4e6556f3aa7c1cd9e5cf4ce13aeb474e94949052a3b9bc18db1e7d7098c9a33c34fb43f65acdb67a6f406e54573d335da66d349694ab6d33eb296a990449135e8b122c8d72b588aad5661157a39494354fb46785bb0dae6adb3eafb86a1ab6339a2a2a1b4d4c6f91553a273cec8d8defd72ee9d7a67a1879a32e49da63c22bf3b4ed30d71f6b157d249adf405ad93316a69ed5593c91a2fc4d649331ac554f45589f8ff00454d0e243dfadebd49bffb9570dc5d490474aea86b29e8e8a2773328e9599f0e1472a22bb197395ca899739cb8445c24786762acd291594d48da36657a777677534851b6dda4f73355d929199e582dd79a9a68db9ef86c6f4443d6fbbcbbbfaa2865b66a5dd6d6176a39daac969ebafb555113dabdd1cd7bd5153e4a861e0bb8c79d976d0000b85eb4c6b6d65a26a25acd19ab6f5619e7446cb2db2be5a57bd1338472c6e455c657bfaa972d47bb7badac285d6cd5bb9bab2f746f545753dc6f5535312aa76cb647aa7f3189829b479365dedfac7575a6919416bd5377a3a68f3c90d3d74b1c6dcae570d6b91132aaabf79f971d5daaef14ab4577d4f76aea772a3961a9ad92562aa765e573950b481b4017fd31b81af744a489a335bdfec2933b9a44b65ca6a5e7763195f0dc995c16002637f233cabdfcdf5af89d0576f4ebca989c987325d4758f6aa7a2a2c860d3cf354cd254d4ccf96595caf9247b95ce7b9572aaaabd55557ccf8022223c1b05d34eeaad51a42b96e7a4f525d2cb58ade55a8b756494d2f2fa7346a8b8fbcb580331bdef3ef0ea6b7cb69d49bafac6eb433b5592d3575f6aa789ed5f2731ef5454f92a163b66abd5365a75a3b36a4bad040ae57ac54d59244c572f75c355133d13afc8b501b441b42f15dacf585ce964a1b96abbc55d34a8892433d74b231f85ca65ae72a2f5445fb8b3803c0000a8190696dc3d7fa1d254d15ae75069f499dcd2fd17739e939d7b65de1b9b95fb4c7c1498dfc8ca3536ea6e7eb5a4f70d65b8faa2fd4a8e4778373bc545547cc9d979647aa64f2b3ee46e269eb7c769b06bdd476ca1855cb1d351dd2786262b955570c6391132aaaabd3baa98e01b47836864379dc6dc2d4740eb5ea1d77a86e944f7239d4d5b749e789ca8b945563dca8aa8bdba18f0036d866565de8de2d356f8ad1a77763595aa8606247152d15faaa08a36a7446b58c7a2227c910b25e7586add47768efda87545dee973855ab1d6d6d74b3cec56ae5b891ee572617aa75e8a5a00da0da1907ec85afbff007e3507ff00339bff00519a70ff00b8f49a637fb466b8dc0ac92e56fa4b9471574d5f22cc8ca791ae89cf72bf396b12457e3f7a4560a4d62636261fd00c5a5346cf1327834dd9a48e46a3d8f651c4ad7355328a8a89d50d36e2c3d9eb79ddcd7f3ee46d45fec76baab9470b2e16cb8a490c1cf1c691a4b13e263f1963188ace444ca2ae72b835ab874e3f773f63ad34ba36fb4116afd2d46d48e9696aa758aaa8e3ca61914f877c0899c31cd544e88d56a260da5a2f6ab6c6c90b5d71d07aea09553e26c34d472b517e4e5a86aafe8303dacb8adbd7bb1f8de93d99af063c1d4dc34c377d43aa35051ddf53df218e9645a263929a8e06af32c6c7bd11ef573f0aae546a7c0dc2745559ab793736c9b3db697fdc3bf5432386d346f9218d5c88ea8a854c450b73ddcf7ab5a9f6e7b21a97a9fdab9b6b4f4123b466d8ea6afadc7e2db73969e922cfaaba37cabfcdfa3b9a4fbffc4f6e8f117768aab5b5c22a7b55148e9282cf448aca4a655e9cd855557c98e9cee555eab8e545542b183265b72b914b5a77b2279e79aaa792a6a657cb2caf59247bd72e739572aaabe6aaa7c006c1900000fb8279a9a68ea69a67c52c4e47c7231cad731c8b945454ea8a8be66754dbfdbef470a53d1ef5ebd8226a61191ea4ac6b513ec49306040a4c44f936dd7ed4dafb5deb4e4fc31d6b7ebf784ee667d27729aab95d8c653c472e17058401b6c0002a00003ee09e7a59e3a9a699f0cd0bd248e48dcad731c8b94722a754545eb92fbfb216beff00df8d41ff00cce6ff00d463e0a6db8aab95d6e979a9f7dbbdcaaabaa15a8df16a6674afc2764e672aae0a500a8ce2dbbe9bdb67a6651da378f5c50d3c6d46b22a6d4357131a9e88d6c888885b7526e7ee5eb2a6f72d5fb87a9af94eaa8be15caed5152cca2e5179647aa7731905bc63ec6d0000b8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000032cdaddaed67bc7ad68341684b62d65ceb9cab972f2c50449f5e695d85e48da8bd57ec444555445a4cedde4f0c4c13beeb70c3acf878ddfd37a6358c305d6cb75b9537b85ce3857ddaba3f1589246ad76795e9cd873173d1517aa2a29b77ed1ada4da9d0fb054579d15b65a4f4fdc1fa8e9207555aecb4d4932c6b0d42ab15f1b11dcaaad6aaa671d13d08a735626223e56cde378fd5ccd06c4c9c0bef7c7b1a9bd2eb4fc499aa7583c377bfb6dfcb9f79e5f5f3f0f1cdc9f17c935d892b68b789562627c001b3fc16f08969e2617535cb565e6ed69b458fdde0827a048f9a7a99399ce665ed7261ac6a2ae13f3da2f68a47292662b1bcb5801b1355c24dc35df117aaf647622e8db950e95f86a6ed79a946c71b988c6cc8f7431ae152673a346b5aabf02af92e239df2d89d77c3e6b26689d7d1d13aaa6a5656d3d4d0cae969ea21739cde6639cd6bba398e45456a2a2a76c2a2ad22f599da08b44a3c0017aa00000000000000000000000000000325db5d0179dd3d7765dbdd3f53454f71bed5252534b58f7b2063d51572f5635ce44e9e4d533ee223859dc1e19e4b047aeef1a7abd75136a9d4bf44544f2f2781e173f3f8b0c78cf8cdc633d9738e99b66d113c7e4de37d90e000b8000000000000000000000000015d61b1dd3535f2dda6ec94ab5371bb55c343470a2a22cb3caf4631b95e89973913afa9376f8f051bcdb03a3a0d75ac1f61aeb5493b29a77daeae495d4af7fd5f151f1b3a2aa632d572671ea85b36889da6549988ec80c005ca800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004d1b25b6dc50d9ebacdbc3b2fa1b5349e1bdefa2b950d2abe19dad7ab248dde4f62ab5cd7357a2e15085cdd0e1f3da254bb1bb4561dae936925bcbaca9528b5adbe253a4be2d44937ed7e03b971e263eb2e719f911e49b6df4c6eb6dbedda1bd3a29ebc46ed5c141be1b4970d3b76a5a8865aab75c699d1a4757161d1d55248bd719ce3af337e26bb2d5cba40d65a034a6bf8ed106adb532e10592e90de6961917f17ef5135ed8dce6fe7237c457222f4ca27a162d95dc1d69b97a260d67ad36d9fa23df9125a3a0a8b8fbcd43a054ca492b7c28fc2cf746ae571d571d8f8db3dfeda5de0bcdfac3b79ac68eef59a767586ad912aa73b7a278d12afedb1732ab7c46e5aaa9d170ad55d5cf2de76f862ceed6ce35b5cf135ada3b86d0ecaed26ac6e9d958b4f77bec544e6bae4d54f8e083cdb075c39fd164ea898675939afad7416b2db8bd7e0e6bad375d63b9f82d9fdd6b22f0e4f0dd9e5763d170bfa0ea9711dc6b6ace1bb56b6c5a97616a2bed35a8afb5dea1bff002415ac4ee98f765e491bf9d1aaaaa6515155151579d5c4fefc47c45ee77ec8916977581bf474141ee8eacf795fc5abd79b9f919df9fb63cbb99da6e511b6dd93e3dfedd9121d70e17ad741c3570509af2f14a8da996d555abab58d4c3a67c91f353c7f163e2589b0330b8eaa730b6676faa77577574b6de53b1ea97cb9c34d3ab170e653f3734cf45fdec4d7bbee3a25ed3adc1a5d1db2762da9b53a38a4d515ac47c08d5f86868f95f84c744fc6ad3e33e48efbab9febb571fdd5c9de62ad46e0f7703883a3decbadef67b4fd36afd4179a4a8abbd5bebaaa2a665642b335d24aaf7be36b5e923daa8a8b9f897a2a64b771a5a9b7bf536efb27df7d3149a6ef10db216d0daa92aa3a8869e895f22b151f1c8f6ab9cee755555cae13a22222120fb2f7f28fadfe4bd6ff005f4c66bc656dcbb76f8f1d1bb74b2ac50deed96d86a5e8ec3994ed9677ccad5c2fc491b5f8f9e04da23378f83788bb58767f863debdf345aadbdd173d4db59278725cea9eda6a363bae51247aa73aa63aa311ca994ca123eacf675713da5ed8eba41a66d77d6c699920b4dc5b24cd6e155551922315ddb186f32f5e886ee7163c46db783cdbdd35a376cf4bdbbe94b844fa6b4d2cac725250d2408d4748e6b70af5cb9a88dca6555ce555c6175bb65bda69b9add776eb76f0d3596b74d5c2a1b4f53554b4beed3d0a3dc889322a3b95cc6e72e6aa6719545ca616d8c996f1cab1d948b5edde21a415b45596dac9edd71a49a96aa9657433c1346ac92291aaa8e639abd5ae45454545ea8a84ab5dc286ff5b76d5bbbf5ba0bc3d22fb6c5776dc7e95a25cd24ad6b9927849378bd51ed5e5e4e64cf54436cfda93b35a7e8edfa7f7c6cb44ca7b8565736cb76744ce9528e89f2412bb1d399a913d9cd8caa3988abf0a12f6b7ff26b537ff0e2d3fabc05d39e662b35f9957dced130e4992dd770a1bfd6ddb56eefd6e82f0f48bedb15ddb71fa568973492b5ae649e124de2f547b5797939933d510890eb66b7ff0026b537ff000e2d3fabc05f9724d2636f9956f69aedb394561b05ef54de2934fe9bb4d5dcee75d22454d494b13a59657fa35adeabd1157ec4553652c9ecdce27eef6a65caa6c962b548f4554a3aebab3c744cf4cf868f6267be15de7d70bd0d94f6606cd59ad1b7570deab850c33deafb553505be654473a9e8a1546bd1b9faae7ca8fcfaa319f32f3aef5c7b4a6e1ac2aeb340ecc58ed3a7629dc945475570b5cf2cb0a2e1ab33d6ab3ccbdd519ca899c75c6562be6b729ad768dbeeb66f3bed0e746e9ec8ee9ecadd23b56e5e8eadb33e7cad3ccfe5929e744cfed7331558e5e995445ca65328992a76936037737d5d7566d5e92fa6d6ca90ad727bfd2d37829373f87fb7c8ce6cf84ffab9c63ae3299eba6a3d0b7ee217877acd27bd1a0e1d39a92e5412b65a26d4c354da3ae667c2a88648def6e3991ae44e6ca22ab5d9eb9d52f649ff00ca774bf83b2ff4d688d44ce39b7cc1ee4f199fb343f58e8fd45a0353dcb466adb77b85e2d13ad3565378d1cbe1489ddbcf1b9cc777ee8aa8653b49b01bb9beaebab36af497d36b654856b93dfe969bc149b9fc3fdbe467367c27fd5ce31d7194ce43c627e53db8dfc772ff00e169b4dec93ff94ee97f0765fe9ad25be49ae2e71e575ad315e4d2fa2d92dceb86eabb64e8f4cf89ad19512d2adb3df69d312c71ba57b7c6593c2e8c6b973cf85c613af433a4e09389b66b1a1d0d53b6534173af816adabf4852cb0434e8f462c92cb1c8e646995e88abccec2f2a3b04dfa37fcaa551fca0ba7f66ce6d0f1adc54d570d160b4334a59682bf556a6748ca77d635cb0d3d34185748f46aa2bd79a5446b79913e272f96163b66bf28ad63cc2d9bdb7888736f7df857dd6e1d696d55fb8305a9d4b78924869a6a0acf19be2311155ae4546b9170b9ce31f32efb4dc13f107bc7668752e9dd270dbecd551a4b4b5f77a94a58ea1abd9d1b70b239aa9d51dcbcaa9d9549ab68775f59f1dfbc1a336fb78ecf61a8b3e94a8aad4553ee94ef8bde61646d6a412315ee47356458917b65aae45c93971b3c69dfb87dbddb36cf6cad36e7dee6a26d755d5d644af868e072ab628e38d15115ebc8e55555c3511bd179be14e4c9131488fa89b5bf2fcb5cb67f84cdf1d89e2476e2f3ae74a23acdf4ec31add6df3b6a695af735c88d7aa7c51e57088af6b5155511155490fdad9ff002bdadfe0ef5fd3465fb83ee3e75a6eaee451ed56ee5bad734b7a6bd2d772a28161736a236ac891caccab551c8d761c9caa8e444c2f3652c3ed6cff0095ed6ff077afe9a32c89bce688bf95379e71c9aa1aab853dfcd13b76bbafa9f41fb96956d3d3552d7fd294527e2aa1cc6c2ef09932c9f13a562639729cdd7185c44c75978a8ff2774bfc9fd33facd11c9a27c3927244ccfdd7d2d368de52ceaae14f7f344eddaeebea7d07ee5a55b4f4d54b5ff4a5149f8aa8731b0bbc264cb27c4e95898e5ca7375c61711e694d25a9b5cdfe934be8fb156de2ed5cf48e9e9292259247af9ae13b353bab9708899555444c9d4fe2a3fc9dd2ff0027f4cfeb34458bd99bb57a7f4a6ccd66f1d7450beeba9aa2a18954e6f5a7a0a67ac7e1a755c66464af72a2267e045cf2a11c6a27db9bcfdf65b193e9de5ab71fb36f8a192c9f4b2d8ac4ca8f0bc4fa35d778fde738cf2653f15cde5fb663e6613a7782ae27f553ee7159f69eb164b3d6badf58caaafa3a473264631f8449a562bdaad918a8f6e58b9e8abd49ab70bda85bb953acab64db7b2e9fa1d3704ee651475d48f9e7a88915512495dcede557261795a89cb9c6571937b7867df4b6f10fb5543b854940ca0adf19f4374a363f9d29eae344573517bf2ab5cc7b73d795e992db65cd8ebbda2149b5eb1bcb8f1b7bb11badbababeeba0f41695fa52fb648e596ba93dfa9a0f0591cad89ebcf2c8d63b0f7353e172e7394e9d4ce34af047c47eabd6b76d0b0e866d057585626dcea2b2b61f74a67cb13658d9e346e7b5ef563d8ee58f995a8e4e644c9b05ecf6fcaf374ff8bee9fda70129f1adc6c6a4d80d5f47b73b6563b5c97aa8a58ee774afaf85648e36bf2c8e3631ae6e64c468aae76511bca888b9f86eb65bf3e158566f6df6873d37b763f5d6c06af8b44ee04542db85450c77185d4751e344f81ef7b11c8b84545e689e985445e9e8a8499b7fc00f12fb81688ef91692a5b1524ec6c902deead29a495aa99cf8488e91bfedb5bdc9f784abb5cf8cbe211fbd1bb769b44b51b7161a5a2a7a7a5a773619aa9f53512413b98e73932c4597a754e66b1c9854278e21f5771bcdd58b65e1e36aedcb60a56339af35b5f6f74b5b22a22af8714d50d58d8dcab7e26732aa2af44c6696cd789e1db7f926f31dbe5cddde0e13b7d763e95d76d71a324fa1daf6b3e95a095b554a8abdb99ccf8a3ebd3e36b72bdb3d0c136f36eb596eb6ada3d0ba06cff4a5f2e0d95d4f4bef1141ce91c6e91ff1cae6b130c6397ab9338c2753b25b1173df5d6da36eda778a0dacb75a2b513c04921aaa5a8a4ba53488e4735d145348ac73718722e1ae47263cd13477879db7a6da3f69026de5039568ad157764a3caaaab69a4b74d2c2d5555555548e4622aaf754552b4cf331689f304649da7ee8721e09f89a935ac5a024db1a88aeb252477091cb5d4afa68299f23a36c924f1c8e8db97472619cdcea8c72a354c8f5bfb3d389ad156492fdf8316fbec3035649e1b35724f3c6c445555f09c8d73fb630c473baf637578e8e2df5270ed158b4d6dfd05049a8afd149552d55647e2b296998ee56e188a9cce7395d855e888d7745cf4c3b823e3835d6f46bd9b6bb74a9edb35754d1cb576cb851c1e039ee8939a48a4622f2ae599722b5131c8b9ce7a5beee59af3da36539df6e4e71e8caad4768d6d62add2ec565fe8aeb4b2db9af46a2b6b193356245e6c227c68def84f537138d6dc6e302ebb5369b36f56d6d9f46e9caab8430d4cf4171a7a975c2b5ac7bd8d56b2791d1b30c7bf18eed4cbbb22d9f8cfdbcb2e82e3574dd5d8685b494faa67b55f268e362363f797d63a2955a8898cb961e777ef9eabe66c0fb557fc44e98fe56c1fa9d5175af16b5276f2acdb798973736fb6d35e6eaea08f4bede696aebe5ce46abd61a662623627e7c8f72a3236f973395132a899caa1b0351ecd6e27e0b4bae51da74f4f3b63e74a08eeecf1d5719e44572247cde5f5f1f33787846dac66c8f0c36ebde96d26fbceacd436966a0a9a64963a79ab6a66891f0532c92b91b1b5ad7319d55111799d8caae63aa5d73ed418b5336ed57b2da667b578c8e7da52e16d637c2e6eac6cbef6b223b97a23955533d7957b16ce7b5a662bb6d1f72724ccf6736b5be83d63b6fa867d2baeb4e56d92eb4e88e7d355c7cae56ae70e6af67b570b873555170b8533edb9e13f7ff76b49b75cedf681fa56c8f92585b55f4ad14197c6b87a724b335fd17f7bd7c8e8b71efb5947ba1c36d5eb7aed3aca0d4fa4e9a3bbc0933d8e9a9635567bd533a48d5cd722315cb86aab55f1b5517ccfbf66db5afe16edcd7a22b56ed714545eca9e2159d44fb7ce23b9ee4f1de1a21b67c06f117ba3a622d5d6ad39436ab7d53124a45bbd5fbb4952c5ecf6468d7391abe4ae46a2a754ca75209d4362b9697bfdcf4cde616c570b4564d43571b5e8f464d13d58f4472745c39abd53a29bb5bb9ed36dcbb7ee05ced3b5165d370699b554be9291f5b4af9e4ac6c6e56f8aaad91a8d63b196b5a9944c6557cb4b358ea4a9d65abaf9abeb29e3a79ef972a9b94b144aaac8df34ae91cd6e7ae115ca89926c73927bdd7d66d3e5680012ae0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000093f86bd79b7bb6bbc561d5fb9da512fd63a29b2f8feb2d2c8aa9c95291f695635f8b917bf74ea884600a4c728da498dfb37fb8bbe3622dcebb536c46c8df962b05de78286f3a8604723aad2572356081170a91223be377457ae5a986a2abf16de4e15352f03964b3efc683de6a9afbc51de60a08a14b3a52b55b247239c8f5f1de8f62a47cae62b70a8eefd0d48d01ffb79a6ff008de8ff00ae61d40f6a1fe4e143fca9a2fea2a4c598f6ad5a57c4f94531c262b08f37438e6d88ddfe16eba935ce966576aeaf6fb97e0e2f327815a8df86b639f1f044dcf322a2f3e72c54545571ce4009f1e38c7daa92b58af86ef7b2cf6cfe9cdccd43ba15b4dcd4da668128a8dcf8f29ef752aa8ae6bbf74d898f4544f2993d7ac75ed0ddcdfd90b88fbadae8ea7c5b7690823b1c08d97998b3332fa8763b23bc57b98be7f8a4cf6c26e870956ab7f0e7c153b716f54ed6cf596eabd61588c72aaca8f8f34cc4ce3aba164098edcce5f5caf28af377b85feef5d7dbb542d4575caa65aba99551116496472b9ee5c7ab9554871fd796d7fb76595faaf32db0f65efe51f5bfc97adfebe9895388ed6d6adbcf68eedeeacbe4a9150535be829ea2555446c4c9d6a60591cabd11adf179957d1148afd97bf947d77f25eb7fafa63cbda79f949c1fc9aa1feb67131cb34c7e8a4c6f7d9b0ded2bd84d75b9767d33b89a0ecf537a769d8ea296e143471acb3f812ab5cd998c4eaf46ab551c8d455f8917184554d20d95e18375b7875ddbb4b5368dbd5bedcfa86fd2773aaa2920868e9d1c9e2395ef6f2abf19e5675555c74c65526be1f7da45ae76bec545a3371f4f7e17da2818d8296b5953e0d7c10b5308d739c8ad991130899e57613ab94963567b5834c476b72686da8ba4f717261aebb56470c31ae17e2548b9dcfc2e3e1cb73ea85b5f7b1c7088dff5239d638c42fded4bd676eb3ecfe99dbd86aa34afbc5e5959e02f577ba53452239df2fc6491267cfafcf121e91b0bf7af800b5691d235305456dc742c36ba6fc622316b29e148d6373bf37f1b0ab57d0e566eb6ebeb7de8d6757aef5f5d7df6e754891b51ade48a9e14555643133f358dcae13aaf5555555555597f858e3575a70dd14fa6aa2d2dd49a4aae6f1d6dd2542c32d24ab847c9049872265132ac54c2aa22a2b555caa9c168c7115f31dc9c73158dbca2ab7ec5ef1dcf55b34452ed9ea45bd3ea1299699f6e95aac72bb972f72b795ac45eaaf5546a275ce3a9d56dff00d24ba07818bee865a859d74f68ea4b5acbfe71606451abbef56e4843577b57b4cb6cd237426d5dd24babdaad8dd76aa8e3a78970bf12a44ae73f0b8f872dcfaa1156e3fb476ebb9bb2773da8beed6b12e578b53282b2f4cbd7c2f993955f3253253a72a39cd5546789d338cae05a32e498998db65262d698de1b35ecdbd5943a938654d296dadf02e7a72e35b493f445744b33d678a546af74fc6aa267a2ab1c9e46b36bddfbf68deddeafadd1d7abddfe5a9a5a87430cf4ba468a682b1a8bf0c90bdb4aa8f6b930bd17299c2e1515135e762f7eb5ff000f9ac9babf42d6c7f8e62435f41508aea6ae8739e491a8a8b945ead722a39ab9c2e15c8bbc962f6b068696d8c7ea6da7bed2dc30bcf1d0d6c33c2ab9e8a8f7f86e4ca7972f4ed95ee2d8ed4bcda2bbc4ab3598999db7645b7fa6b8f0d47b691ee1ebfe2561d0cf5a79ab26b6dc3475ba49a9a9988aa8f957c36f22ab539b95532d4c670b9448c3d949a92964d63b9568adab8be92bb52505c191fc2d748d8a59d25735a98e88ea88f384c2732114f12bc7e6e06fb592a34469fb3b349697aa5e5ab822a959aaab988bd192cbcad46b17a2ab1a9d7b2b9c9d080f6bb73f586cf6b6b76bfd0d71f74ba5b9eaa9ce9cd14f1aa61f14adca7331c9d153a2f6545454454ba315ad4989da2648a4cd6774f5c75ec66e3d83882d49aae0d2973afb1ea7a96d7d0d75252c9346aae6351f1b95a8a8d7a3d1c9cabdd30a9dcda4f665ecc6b0db9d0faa75a6b2b2d75a27d57534b151d1d6c4b14beef4c92e25563911cd473a77a2732265188a9d151571dd3fed60d1b259d8ed55b4f7982ea8987b2df5914b4ee5f5473f95cd45f4c2e3d57b987507b57b52c1a8eeb5f72da1a5abb44f1c31db6822bd2c0fa556abd647c92ac0ff0015cfe667446b11a8cf3caa965a335e9c38a93179af1d96bd1bfe552a8fe505d3fb3672bbdac4e55d75a01b9e8969ab544fff0019bff910059b89afa238a993899fc09f17c4b85557fd09f4972e3c6a67c3c9ef1e12f6e7e6cf87d718c2773db8b1e28bfc282fd60bdfe037e0cfd07492d2f85f49fbef8dcef477367c28f9718c630a4918ed192b6dbc42e8acf289653ece2d616bd29c4d5ba96e932449a86d9576781ee5c35267724ac455fdf2c3ca9f372212c7b4a387cdc3bb6e3516ef693d395f7bb3d6db62a1aef7181d3c9473c2aec39ec6e5c8c731cdc391308ad722aa65b9d0da3acabb7d5c15f4155353555348d9a09e17ab248a46ae5af6b93ab5c8a88a8a9d5150df6da2f6a6dc6cf62a6b2ef0e86a8bd5652c491added5332396a553a734b03d1188e54eaae6b91157b35064a5eb7f729dcb44c5b9423de023875dcabe6f8d8b70aefa5ae768d39a5e47d6cd595d4cf81b513786e6c70c5ce88af557391caa88a888d5caa2ab5164ef6b67fcaf6b7f83bd7f4d19e1adfdab15d5379b6b741ed93a0b3d3d5473d7ad7d7b5b555913572b0b3958e6428ab8457fe317194446af5202e2db8b3ff000a5974b4bf801f831f834dad6e3e95f7df78f78587fea63e4e5f07e79e6f2c75b6b5c96cb17b46d0a445a6d1696fede74ad67113c035bb4de9a92396e577d1f6b7d3b227a235f5b4890c8b0e57a2665a758d73db2bd8e5de9fd87de2d4baba0d0f6edb8d42dbbcd3a53ba29edd344902aae15d2b9cdc3189dd5cbd3084b7c2c71c1ac3873a07e8fb8d91ba97494b3aceca27542c33d13dca9cee81f87272af572c6a985775456e5cabb07adbdabb62fa1248f6eb6b6e0ebbc8d56c72de6a63653c0b85c3d5912b9d2e171f0f333299f8905632e299ad63789222d49da213171b5646e99e07750e9c6c9ce96aa1b1d0a3bf74915752333ff64b47b39b5358f59f0b91e868ea53deac3575f6eae89170f6b2a247ccc7a27a2b665445f56393c8d57debf684576f4ec65c367ee9b61ee75b73a7a18ea2f5f4da49cf2d3cf0ccf93c04a76a273ac4bf0a3fe1e6f3c616a3849d91e28f4c6948b890d91d4ba5bdc2aa96b3c7b2d6d4d43a4b8474f248d741242d8b955cae8d558a9222a7327c4dcaa167b535c5317ed3bade3314da5126e2f077c40680d6d51a422db7bfdfe2f1d63a2b95aadd2d45355c6aec31fcec47246aa98556bd515be7d3a9d32e08b63afdb0db1d4da7756c2d82fd78af9af371a66ca92253492358c645cc9d15c91c51f36329ccaec2aa755d654f6b4dd5b47e149b154ab588dc2ca9a85c91f37af87eed9c7cb9bef366b837dcfdcaddcdabbaee9ee9253d37d337aa89ad30431ac70d3dba38a28d1188bd55be23275e672aaaaaaae71844a669cb34fae362f36dbbb56bd9edf95e6e9ff17dd3fb4e0219f6884b249c596ad63deaa9153db1ac45fcd4f718571fa5557ef2dfb0fc52536c06f56b1dcfa2d1cba9a9f5132b6962a75b82d12b192d5b276c9ccb148abd2344e5e54faddfa61705e21f787f67addabc6e8fe0efd05f4b32959ee3ef7ef5e17834f1c59f13919cd9f0f3f55319c75c649eb4b465e5f1b248acf2ddb51eca0d576ab7eb4d7ba3aa6a1acafbcdbe8ab6958bff00da3695f3364445f54f796ae3be1157c94c9f8b8dd1e39b68b74ee5f80f7fbacda22e2e6d459e6a2d3b47591c0c56b79e091eb4ee735ed7f3639d5555b85455eb8d01d1bac7526dfea8b76b3d217596db78b4cc93d254c58cb1d8545e8bd1515155aa8a8a8a8aa8bd14dfad03ed5ca16daa3a6dcedafaa75c22635afabb25531639dd8eaef065c2c7f673bbee2dc98ed17e711badb56797288dd75e1f1fed0adecb557dfb50ef255685b7c0e6328a4ba68ea07495ae5cf3ab235858e46b70df897a2abb099c291aec5bb517fc254d8356ebba7d6579a49ae1475b7a828e3a5654cb0daa48dc89145f03159c9e1ae3bab1557aaa957bd3ed42d53aa2cf53a7b67f48bb4ca5531637ddebe76cd56c6aa2a2f851b53923776c3d5cff003c222e15358787fde89b63b782d5bb553627ea296dc957e2523eb569dd3ba7824895cb2ab1ea8a8b2737d55ce3cb39295c7798b4cc446f1e08accc4f66c47b55957f672d2e99e9f8270feb954465ecfdfcaeb417ff009a7f6655162e2af88fff0009bd756bd69f81bf837f46da596bf76fa47df3c4e59a593c4e7f0a3c7edb8c617eae73d7098cf0fdbb7fb056eed87753f07fe9bfa0fdebfe21ef7eede378d4b2c1fb6723f971e2f37d55cf2e3a6729256968c3c7e765d113c366dffb437f2a8da4ff0056a0fed17923fb557fc44e98fe56c1fa9d51a6fc43f15ffb3d6ea692dccfc01fa0bf05a3823f72fa57debde7c3a959b3e2782ce4ce797eabb1dfe4649c55f1c1fe137a12d9a2bf630fc1bfa3aeecba7bcfd35ef9e272c32c7e1f27811e3f6dce72bf5718eb948e315e269dbc2d8acfd2df9d11a975a6e7f06f64be6cd6a386dfabdfa62963a1a98e38656b2e14cd6365815b335cc4e67c5246bccde9cd94c6114d1d6f123ed1d7ea1fc146d56ab5bb78de07bafe06d1f373671dfdd71cb9fcecf2e3ae71d48eb869e30371b86ca89edf68a6a7be69aad97c6aab355c8e637c4c63c4864445589eb86e7a39aa89d5b9c2a6dd3bdabfb75f462cadda9d46b70f0f2902d5c090f3e3b78bf5b19f3e4cfc8b7dbb6399dab130a719acf8dde1bf1a438b6d2fc3aea0d55bb5c4fdbe4a1a8b3b62b9d81ba5685ab2c93a358b48da8631172ae7f2f3b513b2aa60917d9ceaa9c27d2aa2e152e573ff00c66817129c5c6e37129590535f2282cda72865f1a8ecd48f5731b2631e24af5c2cafc2aa22e11111570d4caaac8bc39f1f3fb006d3c5b5ff00b147d3de154d4d47bf7d3beeb9f19738f0fdddfdbd79bafc8adb15e71edb77dc9a5a6bb35200066260000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007a53d44f493c7554b3c90cd0bd248e48dcad731c8b94722a754545ea8a8651aa376f75b5c5b5b66d6bb9bab3505bdb2b676d25d2f553570a4888a88f4648f56f32239c88b8cf55f53130536890001512eeb4e2cf881dc2d0d2edaeadd7fef9a6e68e085f411daa8a9daac85cd746de78a16bd11158de88eeb8eb9234d3570a3b4ea3b55d6e303a7a4a3ae82a2789ad472be36488e73511708b94454c2ae0b682d8ac446d106d11e1d72dbdddaf67fedc4770dd1d017ed1da7eb6e94aaeaa4819232b7c3e8e585b4aa8af665cd6e591b11155a9d17a29cebe2af7b20dfede8bbebdb6d2c94f6a4645416c8e56e24f7589308e7a657e27395efc79732279110823c786296e5bef2b2b48acee00099780000000000000000000000000000000000006d57069c6acdc3bc753a2359db2aeeda3abea56a9ab4ce47545ba6722239d1b5ca8d731d84573329d72e4caaaa2eaa82dbd22f1b594988b46d2e9fddb7bfd98faa6eb26abbfdb34f4d75a97acd3acda4eb79e5917aaac88d8391ee55eeab9c91df133ed0ed2d78d0f59b55c3e5a6aa928ab6956827bc490252321a556a3563a5853e26e5aaade67233953eaa2e51c9a0808a34f589de7795b18e200013af000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007fffd9	image/jpg	0	good	2025-11-15 22:02:11.275639	2025-11-16 22:02:11.275647	f	t	2025-11-15 22:02:11.27651	2025-11-15 22:03:26.810223
5	maghla	French YouTube personality who is widely known for her MaghlaOfficiel channel's content. She has gained popularity there for her lifestyle vlogging, as well as personal testimonials and friend tags.	France	f	95	https://walodine.fr/wp-content/uploads/2023/03/Maghla.jpeg	\\xffd8ffe000104a46494600010100000100010000ffe201d84943435f50524f46494c45000101000001c800000000043000006d6e74725247422058595a2007e00001000100000000000061637370000000000000000000000000000000000000000000000000000000010000f6d6000100000000d32d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000964657363000000f0000000247258595a00000114000000146758595a00000128000000146258595a0000013c00000014777470740000015000000014725452430000016400000028675452430000016400000028625452430000016400000028637072740000018c0000003c6d6c756300000000000000010000000c656e5553000000080000001c007300520047004258595a200000000000006fa2000038f50000039058595a2000000000000062990000b785000018da58595a2000000000000024a000000f840000b6cf58595a20000000000000f6d6000100000000d32d706172610000000000040000000266660000f2a700000d59000013d000000a5b00000000000000006d6c756300000000000000010000000c656e5553000000200000001c0047006f006f0067006c006500200049006e0063002e00200032003000310036ffdb004300030202020202030202020303030304060404040404080606050609080a0a090809090a0c0f0c0a0b0e0b09090d110d0e0f101011100a0c12131210130f101010ffdb00430103030304030408040408100b090b1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010ffc0001108022b035903012200021101031101ffc4001e0000010403010101000000000000000000060304050701020800090affc4004810000103030303020502050107010701090102030400051106122107314113510814226171328115234291a1b11624335262c1d17209174382e1f0f1253453925444556373a2ffc4001c0100020203010100000000000000000000040503060102070008ffc40039110002020202010303030303030303050001020003041105211206133122415114326107237115819116334252a1b11724c162d1e1f0f1ffda000c03010002110311003f00a682bc11debdc761e6b44a55c1c8ad89c55a146c752c5f1f31179bce79e0d44dc59fa16120f353b805249a8f9e5a4a493ed59f1fccf11b1012f5043e0a5593819c91cfe2a73a636c2fad719c5900020fdf3ed4d2e6415120802a7ba6ce211726d29230a0739eff009a872429583381b91baa34b18b73c2164952b07ef9a0dd4f6875864971a20a7b1ab6b5aa42677a9bb8241155e6aab83721298894e56bed48c520924c89d74be500182ec7732118cf14eb2eb8a0ac9fc566e8d2a0af0e8233cd4722ea90e0405639e73439a4ab6e2f23bea1dd865485b0dc5ce3071c77a63a82d8e4596870a4ac1e7229083766598e898c39973b63152a9b83b786be6e4a000d8c6076c51b5297fdd2452371dc198fbd05a4b9905236f7e2b2f3c873292be57fdea3e35d12e6f8ed91f4f6c77a9266c3315b1f52567cf146d0c0b687da32aec017a3dc84bb5bdc88cfccaf72828e7f6a8fb73a03841fea3c7da89b55385ab429b75252a240483de846d64aa427feaed574e0f19732d1581f31ae12fbecaa7ee6585a3348c8d4135b5476d4bdfdb15d57d20b1e9ad2af22f7ad0a60d9da5a421d71be5c5f8094f739a16f866d390de762aa5446cb694fa8b52bc0079e28a3aa9a862eacd40d2ec9192d592ce4b31707fe32b38528f8001040fcf8aeaad5b507fd2e91a2476df8ff00f933b970fc526120c423c59c6cbffe907e3fdccebdb45a3a73adac4cdced2db2f5bdc4610faa2ed071f919a849dd1ce9ab8e95972d3b89ecb640ff00b501ea2eb95f344f44e24dd3366b787da2d34e2dd4921083c1200ee6a8981f15fafaff003dd8cd5ae1bc5b3851f48049fdf3541c1e1397777155be2be440d9eccabe0f05cc35ccb5da517c8a8db6f73ac63742f433f9f9636350f6084e4ff8a6f77f87cd333e398aa6edeb6d5fd293b3fc81540db3e2235fc6085a7495b5c4acf0b24a471df9c515c3ebeeb39294aa474eda91cf3e84a04e3ed4464709cfe292c6dd8ff221d7fa7bd4b8ce5bdd075fc887b64f853d2509c53adc26d393fa9b9193fe9417d69e90b1a1ed46eb0485b0a52505255923271c558fd2eeb4c2d4d751619da5655b64ed0afe63a0a7fc1cff008a91f88e84c3fa3e6c340012db699031cf29e7fed49ebbf92a3905c4cc1d1ff1dcaf5777295f295e1f22069bf3f89f37bac56d1350a73714b8d83e78ed407a12d896652de7144ed20735607568dc1a7825964ad0b2939fb1aacecf789d1a6a1b4b413b95c822a87cfd4b8fc8322f4253b97c434653eff265e9062447a1217e9249c77c734e976e8aa4e7d24e383f50e29869698264205408d8d951c7e2a1f57eae6ed280cb4f34a528ff00fbdedf9a0f408ec44c5c01a92f77b5c74c321b6d249c93cf8aae6e57bb65b56a48423272085771f8a78ff53ecedc2704b960baa1b4250090079cd55f7ebcc29f30bec3ff0041249001cd0b6a06f880da41f8965d925469ccbd2520ecc67bf8141b7189f3b78712c80acab03029bc0ea15b6d10fe558b738f12929515ab03fc1a6035bc36a49948b3290547b8778a81abea420ea1bda3484943ad4a5e47638fc52dabe3bbf218467290463f6a8ab5f59a132c263cbb6bc02411b9b215fea452775d7f60b9c65088b70b87394a92063fcd48010866e5b707ec53cc4b806dc56085803fbd1e5f64aa45bf732825413c1fbe2ab58efb2ecd65d38c9567fcf15642560dbd0ea70a0003c76e287ac90ba33653f895a5d557056e4b8e1049c704f6a1b7e290b5070939a30bdc8449b82b6a4a7070463cd0cdd96595904f2454ba10cad40122dd8e818ef5b40791196413e73cd2494b8f656547148a92b0e0da3b1e735ab0eb42782e8ee14b3290e80b18e052cecbc37e720540c47d6da72b231f6a7a2421c411bb3914b6da496ea162f651ad445f529f70eec9a6ca88b07bf7e69e3012147da9c9536b50031ed594a8c1dc073b8c9a8c929e15cd232983b860d49254d8ce00e29b48daa24f8153a544486c50444e027e93fda977c023391c0a6adb9e90213e6bc64fbe6b071d8b6e43d6bb8bb04a01208ad24a94e1c6ea44cac0e36d68660f604d6cd8a1bed34d6a3f825d2a4b63273da89a4585e8b104d7b012a4e79342d6994a5496b03b28673f9ab1ef6cc89f624fa68c809c7d279ed5eaf0d7c4931862561d493062d13521e4b68fab72b68c514cd8aa2cef6d2ac847f9c542f4fb4eae44c599015f41246455853ad4a6d27032923c54b4e26abd49450e6adeb52a87cca6e604ab3fa8640f6a23896b9d19299050b20e15fb54a8d2ac4a9824ad58c90140fb79a2f936e6516d094b6a242309c0ee31405f47b6db91d58e7e488eac8852e1477318240fda9b6b3bc2e236da42370510369f34e34d38879af96f5396ced57dbed4433345b17a650f38095208c66bcb67d30d443b8c2c51157eb2a5a2d25208e49f1535a3f4e26cf2729733b89fc0a9ab2d91ab5c34b0d8c718a751e396dc0a04f079a92946f2dc3021f9930ca0f1f9a902825a053dc5318cb05202bc54b200f4813da9b535b13f136623c7b8dda7493e9f393c56d78b5b722dcbdd92543cd69ea212e82907bd2ef4b538cfa4a191e7f14e12a2c35173da3b139fedd61719d5929496d610167c7079a23d57096eda894b054bc63b7da8f5cb2c143aa91e800a51c93431ae2e312cf00918ca79c56af4841f518af20061d4ab74e69f7ecb33e6e42084924f238145f3eef2dd6961a42820a46144605427fb4c6ef14a7e9ca39481de97bd5ee342b38529c0a5a53c82afb540c82bac953075d0f99150eece5ba72a6249049fab1de9cdc3a8c9056d21d2a52876cf6aace3dfae13a72c32b296f71e4738a7f0edc253ab5c8732b502428f14363332ac1d9806d88db52cf9374794a4295f564f7ed50f6b5390de4194eab624e4f3e2a4642443b89656e0031919ed517a89d4b4c29c6bd8838f34932acf1ba42cc49ea66fba823cf790cb04282391f7c51268ebe370596c3cad8a2719f6aa99b7dd693ea2b8209a98897870b60050247deb2d679bec494743a972dd358391e3111a46fde31c0ed514c6aa90a3bcbb838f7aaed37579c3b4b8afc6ea22b2465ce521bdc4efff004a16f0ce34bd492abca9ee5d3d37d5d3d6a318ab7364e7bd5bd6ebaa9c285700f1deaa9e9fdaa2c26412dfd6455910fd3012adb80299e156028f231c2653a8044368b21121a180334e424f18a8ab57a68482924e6a6123b562d50afd4b76159ef5609f98a2091c1a58018ef492539fde954a01c0ad7cb518859b25292463de95093584a08adf3b7b8ad83684dd6bdcd93b40ca8806b2a792139c8e29a38ee73f6a8f97314db6a4a45614f91d092b2780f23f11f49b9b71815058513e0f8a60bbc3a482d8393ee69b45b7bf38ee525446734f1cb4fa384ec567be689f654c4595ca5887c6b8e235ddc1cbb806a459bab6b195902a0fe554010139fcd24a6dd41dbb4e0f15a9a96454729686dbc9f72f4c20e1069abb7b1bf2318a89f975e72104d60b38fd49ad452a66cdcbdde5f4fc49e8d77428f247352d1df69c4050567341582d9ca476a92b7cb5b78e4f26b5b28006e138dcbbb9d3c2b1db35edc29bc3756e20134eb00f6a0c8d18feb6f30089804e4734a039ad07eafc565479e2b56f89bf8ee2eda8a48dbef5bac29679c5228cf073e69c01bbb506c75f3226aff313d847271c524bc6738ef4e8a0e0f6a4568ce3ed50336a0ec804431f6aced278cd2840ac608e6a02d2129132823baab5293bb3e295209f15ed95a86dc89c08971f7ac6052be99fb57bd3fc567664056714c294cbc36970150a707857d5d8f0283c4d7a3e0b4bc135336bbba1d4ed90b04fb9ae89466efadc496626c6d44982d641daa35077d8129f60b8c150c77c548b9748ada14a4ba08029a0b9b728ec42be93dc668bb72078fcc5ad5eb6257d39e9911d710e85109ee4d35b46ab916b98653292a5278183443ac23b0d87141382a155fa1c31dd59db920e40a5ad73ff009805ea5042db9f52ddb9381a92c9411d89142973bc4972e2dbec2b76dfab9ed51f3de321f0a525493f7af478531dfadb654af6c0a815d8b6a09eef90d18e2ef7b5dc4e1e48c81dc7bd40842d6e1514103dea5d8b4ca5be43aca82739e6b57d088eb2d2f68a9d86e42013b8de2bae474a464e077faa89ec17651062e72858381e735151ed689d18bcdabf4f7e695b3c328790a4646d3c9f6a8fcd946a6403b865a72cab76e254b6890a5038c78cd5bb1ad91dc88948648fa401c507e8dbd5a921a6de42770c02aab223cdb729212c94f2339ddc533e3ea036c4fcc2aa524ca77a896e75a4bca520901436fd8504d9c20c964138fab1fe6ae3ea2c06dfb6bceb68ddf8aa720477113d28208c2f1dfbf357ff004d1355eb2c1c582b928c7f33b77e1a45b25b25525282a53581f5e0f1f6a1dd53758d604cb88a4847a731d70a08c0fad6703edb720d47f40e5cb8b2617a2e06d071b814e49e79c53eeb05a8a6f77353cda865ef5b6a86382315d3b3d0d39cf603d95533e85ca052b1729eca21ff0083dcb41c41d49d05bb2581bdc6d8f5d00fb252155ce9d2e8715cd5de84b6945b79d46e4938c8cf35d21d105ff1be9edd6ce30adf096da523be76631fe2b9cb46386dbabdb71c56d2d908701f0428e7fc50589a5beea5fec77ff23e66d8be3ef5a84fc36ffc6c7ccfa1378d0ba2d5d39622c6b246497e19520848c856da1af840b458ee5a79f5dd1a6e44a4ade6d5ea0076ed5918ab134740ff006a3415b2430f34b4a1b4f7578c555bf0d8f22c5aff0056e91e12a62eef9693b87e85f23fcd73a6bacb303328f33e4a77f3fcce67fa8baee373f14d8c594f97c9deb71c75b6659ba7dacac57cb45bda61d99701114a4703041233fda8efa92c235369054c4919936f28f6ca88e2abef8b282d5b6dac4ab83a90dc39ed4b6d4a3cf0ac903df83e2b9cbad9f1bdea69c674774e63299536d7a3227c8c15038c1084827fb9c5114e37eab1317354fed276c7f026c553f4185c8337ed27649fb7da0a6bd93a6a15b0bd789ed34ac1096d47eb514e4600ef5cfb7ad63676252dcb2db92ada7016f1c63ee00cd0e5feff002ef739c9f2e4b8e3ae2892a5ac923f1ec0fb542baa2b56e2727b77e2a9bea2c9a33b31edac4e7fea3e5c67e63d950ea1149d757c94d9613737da47fcad2f60fc7150afcf90f2f2ebea5e4e72b5151cd34f4cf240e6907d696924958ce2abc5b434656bdd63f31db9256138de073dc1a66e4d4f95123b77a62e494ac7ea3c5372a48e4ab3ce6a1366a7b7b8f1d98327624aa9154a945396500fd946b68cd21d5fd4a281df778a2ab4c465407ca4143b9182b77b67df1e6b5367f13d02c48b86e2a533803d8e69413a5ef00a0ab1cf7c51f7f066dd49f9b761b28cf3b70056a9b5e9d0e61135b7543c21b279fce2b42fb9e82316f6ea148dec94ecec68aed5ade432c7a0e3bb9bf6f34b2ac28582a66105a00c85014c5cd3925c5e63c5503f8a8ce84d94e8ccc8ba264485496b0723383c1cd0fdd262e53815b6a70d8ee918ff0034a1093ff334a27fb81c5347adae290004b6a520924a73ff00702b526195b82245c5dfe91494e72299e16e48da948e0e0f344b09b8acb0b124617e38a6096a1a64a960f739af024c99744c505b1c7230213dc5324c77d970a4a558f1538edc63b11821b23b7bd479b8a1e5e32918f7ad5d442180d4482ca460e41ac0590ace4d6cf7f30eec83f8a4c9281c54206a40c00ee3c6d216d900904d286015b794e49c53044952783c54d417d65a0460d4cac37a8393e5237e4940e14823f3493ac2519c8a979af6539200351cb585f703152ec484c60a6f3fa522b4081ff2f229daca13fa5031f9a4091bb238acee46c7aea6d0def45d0560819f35645b756db5569315d5a52a4a78c1e4d568f388da768c9c7f7a6082e7ab9216326b0c4f8e842f1729b181612deb06ab6d89496e330319c950f228d265d56f464a92405a924fdaab7e9dc16a42838f241001fcd1c3b2a34674216460718a8ebc8f6c10e751ae3dd65d5f675b8be94b1dcaf773321c5ac340f64f9aeb8e98fc28da75de976ae77bd493219920a231651b86e3c0ce71e6aa0e9bd91a9b05b723919c057d1df9ff00bd5dd69ea66b6d0d6c55bb4fdebe5d90823d35c74af61c774e4d727f52fa8327f51ec50da964ab8cb1a9f25d1339ce768f9da175eddf4b4e5a1c72db31d8ae389c1de50783f9c1cd1b5b9294c2fa55de9a487debbdee65c67c9724c998f29e79e58014e2cf25671e73e3daa562b4843411bb3cfb53de1332db295169d981dd8fed6bca44b777522618aa0739c648a968292f64a879ed51d32032995eba473f6a91b62d790558cf6fdaadf4d9af890f7f12453148e53c63de9ea7725ac1238ad98c14e543bd2ab65251f4d3bc570d22bd74bb91eb3f5e6966f9c135a38d90aed592b4b6d82b3819a755f4371158ddf5057575fddb572924249c7155c6a254ed4eea1a2a250b20f6e31e68fb53330ee0f24ad41494ab38fc50eb2c044c4371c0001c60505904d87420effb6026a36d8d270922396cbc7bfd3d8d075eaf122e7012cabce7763cd597acf454ab9b8659495024103340175b51b63e86fd223c114af2ad7a17460c412245e9f8a988d38f293b73db753245dde6a5288564648c0a98b89526004a138f7c50da23e124e0ee049a8533414ea06c35f322eff747df96970af1b4834de4dd9726316940735add58cbd95d6e2d41c8deab69276f7a5d6116bf94c005be2454e4ff00bbe02793ed4ada61ade184233819cd2cf475fa6525071db9a91b38622c65b8a736af078ad880b260a408c1b69c44b2923b1ed5616863898d8527b0c1a010fb7f3a57bf927345da76e1e8484292ae0e0715a377f135f83dce8bd34c8f412b481db8a26616e84818e3cd006919d2df65b6da56edc055ad69b53ae30871d41fd3cd174dc2b1dc7f89856e52ff006e2f6b7dd0b4a467078a2d6c28b683f6a88b6c0690ee4a7b54e02918001c0ac3dcb63752dfc763bd09ab26c8ee2960315ab48dc32303f34a60d464811b84f2f88ab6a0139348c87b1cee15a38f60606699beb0bfab776adfc8193d5492661e90100e49cf7e299a125f736b80904ff8adda2dbcf14a8938e6a62d901b79f404a0f71e2a654f01e517676436fdb125acf6e434c8d8d9cf14b4988a58394f20d165aeca92c83b0f615a4ab3e144149ef413e59f22045cd8a08d9103841ddfd229176d5b8e4278145cbb4103210ac561bb6859d8a15ab65112118a1bed04916d084f229b3f0539e11c51b48b1af6fd0838a839b096c2bf49ef5bd595e5d6e6af89e3f6834ec4c1c240a730e12d67681fe2a415142f9c73e29edb219f5424839cd4cf7f534ab1bea9a3105e6123be3bd381f71442d5b43880b293802a225b61b794002076a045de4659b0830e8c6c0739ac1ef5b6d358283915b79751891a8a23b629c37d8522841c8a7696f09142da44d184c1ad0a33e295d87ed5eda0f18a1988903a44760af140c52de99f6ac14fdaa130665886c15ef4cfda96d95b7a7c678ad01d480aee36dbf8af6c14becfbd7b67deb756fcc848d4f9c0dcd6252d45b1804fd2010734edbe07d09358d453dbbb6a9badd176d44053f2dc023a08286769e02718acc570e4231deadf511f23ef20bba62a6252a23ee364a5d23cf06a33e7a65bc91ea5132d03667143d76825d5ee483c7f6a218b088b2f1fc8128636977944e4944b39cf6cd41c85c644b1b0008c7359b85be4824a41e3da87a53af272852b041f35a0b0995dbd6c4e9a3cbd7a2eca6fe5b078e714f6cf7f16ff00e5484a7676e7bd41419480a2e38b04d37b890ee5c41247daa4aec01a02081dc3d4deed4ffd7f40cd086a55c75485b8c8040ec41a1c44971a51054714b19aa901593c7144b1f2ee6ad713f024842bc2994fa493dfef45b6b750884b5923ebc0cfb66abc0dad4e02803b8a30b621c76196b7673e33daa273d6a7aa724f7178b7690dcadb10ad453ced0aefcd5a5a41b9efb3eb49925248eca3c0a04d1b6961898a91240246d4f3d873c66a72efaaa4b52bf87db9a4a1190323b9a23157bd931a53b1d8877769f1e3437132a424b608072739aaa26cd868b97a91d614028923c7ed53f262aa5c35bd366f3c1db8f3403736cb53561090a48f39ab2e0e6b516835fda38c5b4a306fc4eb5f863beb0fdf60c35242c2d411c80707228dfe2dd0f59f5425d65a21132d8d39c76cefc7f7aa57e19a62616a682e2958dae8ff00515d69f13fa5d17f85a5eefe88536eb2e32b579ed94ff9aeab957bdf7e3584fef4d7fb89da69b9afaf1093fbd187fbfc8101be163518287213ca4a7d41806a96ea29774c6bebb3915904227ba36038c8df91479d3361bd27a963c6945c6582e00b50f1935716a1f86eb37502f2fde2cb7a0bf9b3eaad3b42b39c7635be715c706cb1fc4ba8ef5b1b07ef195cf463a9b2e7285d468eb60107ef2a3e99fc466b8d3915563d3f94c523843ebddb09ee473fd854d0ea44ae98cc95d417e5b4663ab4bd256a5e0beb3ced48cf3ed58d77d2087d1842ae17a2d26284e4399e54ac6703ef5c79d50ea1cfd677a724ad5b22a0ec8ec8070da41c71ee4fbf8a4f99cad7818c726f4526ceb6a3a61fccadf33cf9e270df26c543eef5e4a3f701f9963f5f7e28f58f58aeadbb7094a8f0e2a76478acabe86ffeacf927ef542c894eba415384ed24e49c939a49c7d4be14aff1586d21c56d00f3c5731e479bbb2fe81f428f851f004e33c8f2f77247c18f8a0f803a02610a2bca492493ed4a88e71957029ca596594ee58391c9c5465cae284a70cb87ea06abef636fb899ac627b9e973db615e830a0e2b1ce3c545482b512f2f3827b5388a818538395a87271dc533b8ca09406c900abc544cfb9b28df7193d25485fd0053b8ceb2f3187580a5839cd47a9975490e11c2b814e5a25b46123915096325d08f199818042923ec3dab65dfe62d3e8b4e29b4f6ca78a8e70a9c56559e2954a528015ef5af94d801256df2a2a1e0fcc05fc0fd2a51c66a6c6b0663b7e9b4cb6da71c048c50717539e2937125d1fa8d60b19ed6e4eddb5edcdc2111dc5b681c612ac5338daa6f6a56ef9d787e1551a8869232ae6976d086b18ff0015af97e663c6155b7506a6980b62e2f14fb297807f352685075189f31085f92920d02aa63a08420e07b83cd3a8afa47d4e301c3e724d781dcd9415854f4265c1861ff573e698cbb7a9a0363273ee456d6d7a2a802a65c6bec3353ad34dbcdff2272ddcf05b711dbf06b3bd4211b506d0cb491fcd48cf9ada659d0eb21e8c9edcf153ce58c482021242cf1cd6aab5dd613454a8aa5340e323dab04ee16aeac3e60db6cb8ca76ac56548529394a4e7b01536b80994a19041a796e8d0a3ca4b4f807b1e6b09517334f6c5ade20c186ad931f50223af19f6a978ed188ce1c414e3deac29cf5aadb6df51b69b2427c7e2ab5bd38edc1f596b294abb60d4cd4ad6bb935d82b457bdc697378b9b820f83cd4419afb476a81c54b5be0b8e38843d9c13e6a66f7a761c38489057cac76c544809ee0029f25f21dc1b6241753fa339e2955a0849ca0f6ad63ae1b4e1415f02a7edc6d5206c04295f735b96f11225a7cfb107d96c6e04a3b1cd2c58f54e43671f614568b544dd9084e38a58468cd9da96d3fbd2fb33d43788f992b6395112d2eb7a0a490480481fdeacbd15a45fd69778f1d257b54b483b4673c8a076908db8484f2476ae87f86e0d37766921282a07babc1154ef53f256d341643aea3ae3914baa19d99f0f7f0c3a0e3e8b8f2aeccbf225be8215874a76e0fdaabeeb8f4d22e90d412acd652b5b41b43cd05af71017918cfec6adfd3f78d4961b42d76a9aa61b0852c24a01fbf1cd51b73bf5cf53f52149bac85c92adbea2c8e7680a207f9ae3d6f318dc85207891603b2658b0f1b2a8ca6b3cfe8fc4a8ecba42e71653b266a158528e127359d48e2ecac7ae907039357bdf2c8d34dad51da006de2aadd656044d8cb8cbe00efcd742e0390370001ff69ae6293b66802bd4718c2127c91dea6ec4f894da5d2a042bb50f4bd22a6a3aa38c96c1c8a26d3d07e5a22101a202079abfe3dc62e4efe21133fa5229ce329da0f34d585a4a8209c1c79a916180707bd58712cd4f5abe43523d6d104e49a84bf3ab6e33a94920849edf8a3472234a47d2939a1abcc14b897778e0f1f8ab0d36865f988aea0a9dea52f6d9d70957a76338e28a10a344f6f61299695632a2a03fcd286d36a8131c71b707aee64edadd8fa67a00181c1a1c825e09601e31edc529f95255e33c5541a89b69eb8a94539c2b1cd5a1a9ee08856d71dc90539cff006ae7ad51a9257cdb8eb52780ace296f2cc057a9aa694772765476d2d94903078a1e9b192ce70383da93877e76714a56e0ed820d3e7d1eb240577c718aaaa17121b6b47f895fdfd8906461bce3bd4ee9f47fb828bca07770079a6b78de95ad38e7b53386a9680405109ef53ab159a22ad63b928edb5525d2840c0269ac9b44969b28041c9c522fdda542415955271af0f4a746f5641fbd4e093dc91bc1be230930bd1585ab2927b66a5ad12832b428ac6124139358b8328790dbab3f527c5464a61447f2891f6159d4d05218ea74674f350470192dad248032055e568bfb4e3086ce01dbef5c6ba12e32adcfa0a14b078fd557dd824ddae8db4a438520a403e2b0db596be0ec153f89977c19cc3a9dc95739a7e5e48c7279a12d2903e5c02fbca51ee726a5e7ce6da41692e8dd9e39ac5209696db1d12af2845155ea0fc52d9c1c106995a8a951507392477a7e370ef8a9dfe7508c6fad018c262f6254b03b03de842e3a916d2948491c1e68c2e1b4b2491cd555a89412fbaa46002a20d4f8d5f99d191721907153c8437d3ae1b93a140f3df8ab374edb8b6b41711ec6a99e9d5de3c697e9bee8e46055e169b94556c52569edc60d6731daa1e22058ea328073f30f21210db290938c8f35acd8c1c00e69a40968700fafb0a71265e1200e735597b18b75181c6d8f889061013b724d6d1e1b7bb72935869c046ecd2ea74848dbdeb0ccfa90fe9b516723b65180d8c50ddded8db9b800727b51547515b7f5014d6647428e48158aad656ee64e3ab407fe185bfea27f6a7106112f64248fcd4f488a804ed4d69158dae6e238a345cc44d6bc405ba8e5294b317073d8d07cd70aa4399fd20f144178b8250d9681c6050a38e15a944f735a0620c714e3858a0e7fb66956920e322926c65438f14e9a4511e7d421ea03e26cda06eedf8a71b46315a213839a509c50d6313f105287ef31b4d78a456c78af633506ff32365ea6800cf7358563dab7e3dab2539e45637b1d41196235b81c56de99359092054720649ae3ec6b1b0ff00cb5b0dd9e456dc7fd55a31d484acf9d33d98d77ba3b728d6e4c10f294e1602b70dcaefcd6c88e88c415715a5ee73362bb4cb33725a7dc84f38c953678504f91f6fbf6a855dd5c92e807cfdeba453842d5162fc195abf952e7b9392273484ed0b1fbd41cf9f9cec73fb52af305e682b26a1e420b4b52783c54b663780d1811cfdf5a98766ad6da8104e411417764482eac86d4067bd1ac7692b4107cd329d0bd451652919a14d1a1bd45f93bbfb80f0a1beb201cf07da9d7ca3c9ca54a213dff34656bd1b2e6b6a7db6ce01c6298ceb4fcab8e34fa30a41c707cd466af03dc5a68f1824ec2694a3914c9d8c9632338cd151b24b91971964948f351536d4fb6a216d91cf9a9577a90b55a8c62a9bc049cf3c55b7d27d2f6ed53165c97a37cdbad109dbea04a5b4f951e7c77aa85c6bd338e478a2cd3f3d9b55bbd66a52d9708215b1c29cfede6a4c6b56bb36e3626a343a855a9988fa62ff003a3dae47ab0597cb4cbd9077a42738fc678cd035daf331d95eac6ce739c81da9dfcfbb7779b6801b738091c8c67bfe4d5eb61e8e5be569a173510e2db6d2e38929c000fb1c56fbf7ed26b8df1945a3c41945439d7a7e3954990b503e29b15ca7a4fa6bddc9ab8ee3a3edb052a434d8e39a0c996b8edcd250803da8aa2bb12cecc6b4e1329f9f9867d229132d7728f2123f4b99cfb577bf50672af7d22b3ce2871418951ca881d92a201ff5ae18d07196890ca769c157faf15de9d29d53a2f52f4ed7a33532c21e71b09dab3b4823b119aeb0b925f8fa6f5059ab23a1f89d570ec6af8ca2d5059ab61d0fc1f99475eb4fa6ebb9c61f2c9731c8fb7deb587375368b8c64b5ad6e16d6184efdc5594a7f3cd5ebff00b91d1a4a9e897c5004e427e64118ae3ff8b9d408d357573a7d68ba175a650971f5a5593bbb804d196f35ba5fc58788efc58746306e6855458ca4151b2558747fe606f5e3e21f50f5117fc3655e552a3c6cb69fa30178feafcd50cebea5614b2564a76f27b735a4892a7147d424e39ce69b97d39ce7815c9398e62fe54e880aa3e00f81388f39cedbcdd81d805ac7c28f88aa1a5ad59e31520ca12da7db0324f815e82965482b7541090376e576a87bbea14380c589ff000d270a50f3484b1f93117906ee6f75bd7a2764758273824d443497273e015ef5535214f9247d593e2886c16d115a329f4f6fab9f6a889dcd7c7f31bcd71301909270a29c71502d216fc84b8e9dc949cd49cd43d2e4acf640571f8a6ee2032309ef5a377365ea4d1663bd07d34a0652293b5c06df91e89412735191a538004a9471e715291e608d875b51071dc77ad66d093fd84625212b0eed27c522f68687186e1706947ca54bc1a8646a29887377cc28f3c738a6a25ae5492ebeb254559c9e715a6a6c211b9d3c71c8df3715bf5010490950247ed509374a4c8a0931dd03df69a23b5eb0976c406ad85a4b8a037a949e49f18a3fd3fa964dc594c6b9db199455c9fa467f6c56ac75245d7de51ae5b643430a6d491ee477af3711653b8a4f157edeba78e5ca1fcedb6cd28255f5147a781559de348ce83214db91168c1e40cf1f9a80bc95408182200aced39a5da4fa4a0ac7e939a925dae5209fe528738c11c9a6aec2921407a46bc2c03e4cdbc7736fe2f350425b5a529fb0e69cc4bdbed2c1764a5273df34cc4250c05b64678e4526ec04281cb655e3bd6c2d07ef3050fda17dbb52a5d3e90b845593e0a88ff51445166c95320e12a6d638c2c293555980856dce120782807fcd4ada2dd38292986e48013c90d9ce47e335b86d89b57b061bcbb797125d8e0027929079a1c91eba1d24b6a0a0703352b0de96da72eaf72d3c76c11f915baf6bcadc539fbfdeb54b083085af6760c8f65eb85c47cbbc93b7b54c7f014c6b729d5a32a1ce6912bf937927180454a3d7743f094ca94391c54d6d9b58cab50d590f052306be71b4156083935ed7d2d4dc665849e001daa36ec5c61c448695ceea637b982e084970f2120726b5a9fad4005ab5214d4805b8add919e6a7ac31569507c1383504d10dba011919a30b3143eda5081850a1f2ad2884c5e8743a3081b594b7819c9c1ac24acaf91deb66ca5291b87614a84950ca539cfb556fc99df624e18912460a10a40ec0f83471a2b56af4cce13a39c8df9c67191e6aad7ae6e435601200ef45fd3ed39a975cdd58b559213b25e7561084a13c924f14af3f17c959effdb0ac6b88b014f913e847497a8b2b5be984b650520b45215e40c76a7da3ecb67b66aa94ece71a1297828f50fdb1531d0ee856b3d0ba69b45eade8485b495602c152491e4527a93a7d711aa5abb32a5e1bfd5ec0d7cffcb8fd066b788d29f8978c2cbaf2534a7b89eac6d2fdc9f6e2a52b69691db800d72f7573545c34f6aa66004a834bfd5ed8aebf7ed492a4295f510919fc8ae76eb574fd77bbfb531a4a8068f3819ab67a3b2dc5ff0051ea6b9e83db207cc101708bfc3fe65f5feb403c9e0714b59ee71a5b3feeee8573e0d466aab194599c8ea2a4e11b011c11c50df4d23ca4c9723ad454db6a3839e6bb7e2582cf1225611dbcb52c25beb43a17c802a6adb7249484eefef51662a15ddbff0035b21af4bf4e062add8b50224375cc877b84e24fd2140e71cd0fdfe5fa6c2d63bf24d6cdcb710319cd34963e6814b83215c53509e3d0835991eeace7fbf5d6eeeeab53aca9612dab803383cd19da6548796dadf2776d14532f4c5a90eaa42986c28f249a846620f9fc464e413818a8bda70de5b813024484d78e3cfc271a4f6db9ff0015cf3392b54b782c6415102ba5f57b086ed2fad49faf0473f8ae7195f5ce75091cfa8697728095ee0b793e2351ac76cc7703894e28a22c869c652addc81cd4398c528056955281d0ca025b23278a43e20aee43593bd1895e2336ea89c64939e29936c3884e369da3ed4a2a4bc5fc2927683dcd4b17a2fcba505490a239a19db5d086be333a6c4139cc090928746076a4a0c661a706d27e9a9ab936c6dc208e69ac6663a413bb9a291ce8090d15e8f898aae1aa436148191e29bb9116805253822a51a69f763ee6060279351c0b82490ee4e0d48adb3a8cde9f6d7c847f657971a4a327c8ef56ac5d7ae406d966324128478f7aabe23056ea541247b51b5934eadc4a653c95107b71442561cf723a6eb2bfa9659fa575f5c6e0e243b94818f3464c4e7654b6dc789092455696582db0b4fa692318c8a2cbccf760590c841c38849c11f8a9ca2d2371c63e4be57d2ddea5d36494cae3212858e073526a750072aaa43a59aa65ce5abe71d5edf04f6ab5a65c502224a4f2477a0fc496ff0032eb899550c6f35f8114bd4c6111b0958c938aa9ef6e171c7483d94689e64d5be54da963be450f5c63a4a54479ef4df129f03b32adc9f2dfaa3e2b1858a7b8c4e1c8e3b55e9a366892db216e02a38e0573fa585b4eee48c73fe28cf4a6ac7ed3213eb2b084e39f6ad73683683a126e232fdae98ce9fb73050da56523914ee42806f38154fb3d6583198405491c7738a9ab2f53205e9fda9940a48c7231556b302c46f232e15e4d36680610ddb7d495104f73c54947737e013cd4334eb4f84ec5824e0e453f61c6da58dcb03f7ad3c0993d94fde4db2a094d624a9211b89a8a7aeec329fa9e031f7a17d49ae5b82c2834e83804e3f6ac574339d01046ac2f64c269535b68127915092af4b05496118c83cd0141d6cf5d6429b74a929cff00cd44cc90b42549c9ddce68e38ad48faa4f886bb5be931471d91215b9c04fe692f4544f6ef4ed031ef4a0033fa6a32aa235f6c088b2d80a1c53909c1e2bc9481ce2b61dea363212099b8031582924d641c78ac8049c8a84b6be644575f330aeff0081590383592824f8ac818ef5093b83ba89ae07b1adb290318ad8241ac94fe6a30da106659aa48f6359e3ef5b06f033c57b6fdab42d2175134e4fb57b6abfe5a536fe2b38fb56a4ee0cc93e5c7582359749f5027586c0e3ff002ec0438b6e49fe625d5fd45241c14e320846558cf3c82040c1bf242c070f8ab0fe2d2c9360f52dcbc4eb9990f5d14a7d71c1429308ede1853a9fd6be544abfa893db8aa55a7029c49de9c1f20e715d4789bcbe156cc7ed39a64034dc51be65976cbcb523f96579c0e2b135092a2b491f550b5b9f5320282fc54dc796242427773f7a2ad3e7f132a54c5dbfe58fd4052f6f832ef73da896f64b8eacf03b0ad7e45e79b25293c8e0d1c745f4d0997a973ee32d486203197928385fd5c04fe4fbf8a230b09b26e5422417650a84731ed1334b30d46bd342399092a6c8582158ef8e7b8a0bb87f0ffe22ebb2b616ce7927bd589f13ae5cec2bb2b420bad5a62db4c9676024875d5655ea2b1f6ede6b9d65dc1cbf4c663457544bc529c78fabed45f2f8098b6841167eb0d87624dced54dc6756c5b63fd233838343cf5c26c9794ebeafd47b1a3db9f4b245874bbbaa8ce4bcc447196a4214d01e9adcfd233bb9fda831e2cc83f4a3b7622956450d5a8ea482d0ff0006464b092df3dfbd33ca963d307e9fbd3e9ed84a780698a4ed3bb38c5286520ecfc4c8d0967f4d349c4ba36dc95cb28715f5246cc2703b827c5590f6b7b84580cdae1cc71682d82e201e385600e3bd515a76fd298db09a98e211820a42b19cf8ab1edcd04448ca1f513db279c7ff009a9322faaaac7b3d1fbcb37a7e846b0979312deba4c4fcd3895049ef508b6d2e484950ca89a9ebb39718f6e4e70138c903da84132e59900b682540d7a8e47dbd791d996c7c564d1f1ea5ada5a3610d2920718fcd58b25f4181be43282b6d384a8294938fd8d54fd3e372972421f250090066aee9915876cdb5e286d296812b29e7b536abd5d93843fb6da1ff00ccb8f0d6dd52f921d003e2529d44ea53da75a2c5a65c96e4ac91b43ab1b303bf7aa2af9a96e7a8252e6dca638fbab3f529c3952bf27ed521aeaf86efa927bc1d2a4074a51cf0534324e0118152e57a8b3b397563746730f557a832f90c83579680fc7e278ab7139f35e65a5c8712ca1bca97c015af1e4e2a7b4942fe7bf777465b84defc9ed9f03f349f417604a69eb67ed18ea3537052dc04b8014a01591db26845282fbc5942376e38181dea52f721532438b73f5ad6a3fb54a697b2ed704b74e558e01f143d8666b1b89dbec82394b2a0379209fb511cb80a5c60cb6484edda78f7a5dc61b692a736e56a200fc549c3d8b534ca872473431264c575045cb038d3476a0f07bfbd42cfb71641511cf9ab62ea965110212d8078e680750b4d20641e4d6431131e3b82686cefc0ad9c0b4719fc53961adcf703cd7a6a369c76af6f73609a91ea7159c6056e87549e73cd26b042ab6d8719af11307a8ed994a6d7bf39fb51469ed6171b4906229214082164729fc507b480bc1edcf9a9db75aa53e07a2d1513db15159d0d99951b20097668beaf4b86b4ff001790eca42b19429cc0fed472a9ba1b59bc853b0dd8655825431c9fdcf6aa8349749eff007e79af45970e48c91e2ba074474014ca1b72e4952cf19052a34b2cb42fc18ca9c72df683ed747e0cb7d4b438d2db58fe5e1409fb6714d5fe86b8974e22829f728ae9bd3bd2f836f8cdb8c400971200dc33dbf1444ad2eb0d84a990523edcd2e7cb20c62b863538b6f1d08bc25853b112d94ed27000cf6aab2ffd3dbb5b1e536eb07703e135f44e6e995286d4a5c03db8c7fa502ea3e92c7b838242a282b0771e056173bc4cc9c2d8ea7015c74ddea137eaaedefedc673b0f6f7a898b795c19202bd4688e72924118afa0f73e9645990d2dfc92494b653850efc7e2b9fbab5d03f4197ae16d8a5bc0ddb5039cd1f4720ac74603761327625490752a272528752c398fd95f92af26a5528b54c485c496a6a48e4b4e0c83f7cd55973b7cdb1dc5c8d212b6d685700f04d4c5baf2e7a0952d5b963c91c8a3ca93f5083556f8369a1cadb548c9002b60c67ef51728c965c083dab16fbc2d4d82850fb83dea4f2dcd01646081e6a17b0858e3c7dcafe990934306228b89191c8a0f90e9716b4240c03fe28baf11d412a40f63da831c6de6a428286326b6a5f72bf78646d1998cc36b73eb381e4d1131219849096559200fd3e6a222465be3720679c1a92856d7bd56c96fbf7adae4f747899a57bf8d49a8b224c9213b09cfb5145ba1b85a00a727da9a5a233714071d6f1f4f7c519db9e8529a4a1840de9e3b77a1abc6543f10e4c7eb7b95dce82b72e0a6d69e338aeedf82ed156986216a431497d9712ee7df041c7f8ae3cd4103e55e539b0026bad7e0fb5d436e3a2d4fc84276270466a95ebabaca304fb43e0fda17c45753dec967e27d126f525a9d80ae405947202791c7bd549af6ff001a034fbc71bf9c1cf1ff00e6a6debdc28d6c5c81212121bcf0a073c502ea782754c5681242547278ee2b80f3dcd6572695d37803c7aebe75fccb0f15c77b0e5d641c6baca94c979a5ee079efda8135bea28b6e9422cc74853c48c91e71568c3b1c7b2c40de41da39aa0bad30c5f6f8c47b62ca9d69ddc4255567f4bdd5ab84411a65212a4c10ea2dde24382e2bd5490bc63ef9a16e9f2590c2a583852d648c54a6bbd2b2ae109b8ee2d40a76850f34ae94b0ff000b80dc63b8e3dc79aedfc492cab2a6e42d90812b59206eadf9f22b7447e73b4f6aca9a50fe9cd5f30c8022cc82cefa112e073835e5a923b77c66847506b2fe0b216d48fa53c81c50fb3d538b225a58041dc70703b519fad456f0dc8021afe64f6a8957171d31e236ae783c56ba6a03ec617212a0b1df34496b7599b1d1252949c807047269acd71b8cb71e58da11ed536cfeefb4db47e604f522e2d4586ea073bc1cff006ae78f4d48b8add50e14bce7f7ab5ba83737a6bcea51fa39155eb90cbec9d83ea39c11559e4b24dcde220160ecc45d75875a290bfa878a66cc03b8beb51233c0cd622d86797d4b71c252159c531bedcdc80e21b8e3052467f350a63ff6fb337ad500dee1535625486492cf619cd0edda04868282138c1c0e6a7ed5aec3115225a52afa4673c5667dead3744ee6bd30a23381ef48dbcd6d235d4b050953d7fba0336e38e3a187c9c838c53f7adaeb6c871295007cd23292d373ca9033ce7268b22bb0665b5285e37245310c517c8c5cd87ab360c0d6e7cd8ab21285148f2690767385c2e2f8268bd70e22d3b52949f350b36c41e74b891b403daa6ad811e464ae1b5e1f325f4f3cdc84a77a89c7238ab42cb3db76088e78da2aa4b4b8984bf4c39c8e08a937ef9323e12c95273eddaa7a2d0adb2668f432a6809693d7c8969487d4aeddf07914d6edadc5e223101a56525401e7b8aa89cbd5de638b656fa824fdb353d628ef15b6b7092722a4cdc9529d49f8f7b287fa65d16f92ddb60c68f0861c52772b1deac3897179db7b297dce7038cd0074fe24797290ec95052d09000551f488853fa1bc01da85c4b767ea96db03b636abf89a2d68512477a65212169c1ada492de39c11de914ba091cd59ab21946a53ed051fb9a8b7a579c03c8a53e4fb0f47b0a7cc2b77d407614b64d49e417e67bdcd4887ede549fd1fe69286ec883252b649414907f51c54dad1bd04027b5222224ff464fdeb5b3c2c1af193d197654de4a61e583a84eb11364a70670056f3ba94e93b62a377df340d1e3ed5ed2819f069d08890aca9209ee2978c1acb6e3aff00a86ff0f1064fbdaceef30005d2849f6a68fcf7a60c3ee15669924e001b534a25401e5346a62549f022dbb95c9bb60b490b3ff25dee304fb55976957ab19b5a4e0018c556111450b07deac4d32eef8e904f14067d435b11ff00a7325bcc2b193a84fdab7c007b56e846466b2a4639aaebcbf6f7309c63b57b183dab74815e5633daa3334debe6638f635b26bdf4fb56e91c138a86c1bf89a3e8cc019af118ad923b0f7358503bb14312441d944ca3fef4a6011c52690452a9a1d9bb833813c070056423ed5b81f6af63ed5af9415c6a6b8fcd7b1f9a50241f15ed9590772033803acb29cea84fb6b125f930da1b9f610961bc37bb21454a182b246d1c8e0018ef544eaad3166d3b3bf8642bb489d2da23e607cb869b689fe92bcfd4a1ed57ff00a367b25b1ed5da96e4b6edd19853a637a814f3ab4a72da59032434b28082bec9390ac1c03ccb71d4526e32e45ca47d0e4c757217b791b96aec7df8c60e01fc55e7d11c7656421766d20f806716c96c857f7ef3fbbb1fe24823732d0cf6f14ea24ff4960f079f1432bbd3ae61af02b2ccc71b57a8a27157e5e25ae3b27b9a1e47e350d65ea193e9a5085613e7f14eac9d4ebf69a7d2ed96eeb82a49192ca520948f0add9ddfbd08a27a5e40e47deb462dee4a7cf0769fb504def71770b077a932b8b8789fbce9cbbfc40f4fefdd35bb4695769d77d4174b7b90910571b21b795c7aab708c109072318c1fef55a747ecf68b7ad52ae1f231d68752b5bd2549252dff0056defce3b71439a3b4fc654e6d5210b563fe627fc518dfadb058610da1848241cf039fdeb19dce59956ad968dea6a98215ba3227a8bae26eab724586dcfbcdd8a3c953ac344049771d8af1dfedcd57ea6561410da144e7b27cfdaac0b7d9932a3b8568efc77ed596f45b6b8cb90c24a9c0781f7a9ef56c84f707de1c98275d413b0683d4bace77f0ed3f6c7673c94eedad91c0f7392291d4da12f7a5e5bb69d436a7adf35a6fd55b4ee3210784ab8ce413db19ab5fa55ad9ce935ee448b8dae73f1a5b61a5888a485800e7002b1dfcf35656b0fe0df10f7887744db255b4a2d69850101c07d269a492a5b8aec772bdce6b14f16975440fddf881066c7bc7b83e99c58a6dc8d23d4656414f9fbf8ab0344dfe5b8fc68f316549047fad4c751fa05d44d01186a1bbd8ff00fd2d6e84194d2c2c0cfe90a039048e7db83437a71a676a5d276a9183fdc023fd6aa3c963db86c458a44b3712c56ff2a9ba33b97a25d39d39ad1c42a72197d2942729501806a07e213a4ba6f45eae8bfc29969b64c6f55e01380924e07ef555f4f3aeacf4e12952e514270324139c8a61d4ff0088d575026485404a9f7e684b6642d6414247802b92594f34fcd0b2927dafbcee145b855a8bb26d5f6c2e8afdcb422b6dcad905ef4d87104a14949c7b93567dfaed6eb2745eff00ab252c7acf36a8b19b3dca9478c67c815cd163170f503afc85052885138e2a57ad7ae9f7b4fd9b48332bd461947cd3c9071970f1569ca36dce95567efdc19336ba70edcad78a81d7f894aca754b794b381c9ff0039cffad362727b77a5952231c971c19cf60291724c307e994d8fb1357a4d22aafe04e019567bd90eff00933c41c1dbdc76a2ab825166d24cc74a885dc55eb399e3091fa7fcd0edb911654b69b5ce8c8429690a2a747033cd4e6bb90ccf97be33a85468cda586824f1b31dff39adddbaea0adb3d082d6a866e53cadd1f4340eecfb518c14331e21796909483b53834376973e4edcfbf8fa9e580a578c52cab92dd64472afa41c8c506efb85d29d7725ccef525ef2b010380334bc59eaf594e156027f4d0d2a46477ed4e9b755e9a5215c920d41e531602611bf707242795938f15077167e673b81e29fb0da90ca5c20e4d614da967614f73582d37ad091201889e9152827b5319a9dee7e93c5114a88a6d048c8e6a21c64af2e73818ff26b01bb93151a908e3642f0456c13b86d039a772da1bc6d4f6ef49b4da8a8613939a97cb5f3206504ea49696d3f2ef9736e2b2d6f0a206d079ef5d83d25f87865a82d5cef76ede54014a147c7e2863e0eba48dea99ebd413104c78e73cb79ca81f735dc89b6b115b445434848424212027c521cecd284aac71878835e444af2c1d3d828298f0e0b709094e0940e4d1e5a348b109292892f2b1dc28e41a9f816d46d04231c54a336f00719a4ad90cf1a2d6abf11844848680009fc5387e10db9481cf7a916e104e0915953472462a224c901900e5b9beea467f6a66f42650495348c0fb512bad280ced1c5474b602812478ac6e6e20bdc20b5b54a4207208ed4137dd3cccc8eeb6eb2956538194f91566b91f77053c76a88b85b93b54003d89af06607626c4023444e16f883e8c20876f56d8e12ea412b011c6315caf95c390e46564142f6e0d7d5ad5da4e25c62bcdbed9505a0f0477e2be787c40f4f13a2f581971d85a22c83bc9238c93561e3f33cc7834439789e3f5880b1a538c3c95851da4518da25256de14ae71c5041da5291dc11c62a5ed12969652771ca1546dc0107531876907c4c2894c7a80952739a1ab85a14e3a14867cd17417512e32544f3ede6a4635adb7507201f350e393e5a327bf105a7620e698d365d5ee71042072454fa6db15a909683606df34ee238e449698ad34005f6228cadba29570db357bbdc8f7a6c95797c42b03086fc3ef214e9ff00988cd8427391c62a7ad3a5550180e8c82aa95760b70548654ada123b54eb658540094e15f4fbd417e906a313c66f7e7d4acb544290f28b6c216b70fe94e3278ab4ba15d1deb0028be45d2f716e22c6e4ba96c8047bf3475d11e9d5af54ea56e54e4a9496ce31b41048afa65a599b4c5b1c5811434865865080848031815cff0095e41395cb6e3c305206f6626caa0f0ee2f41bdce2ab5a3512e4b56fbe487da09284a90e1208c1e7357ee9bb3b32233201ca5281b7daa1fad36bb51b89930cb687b2784f9349689d44eb30d31dc5e1481819ae17c9638c9cc7a146ca9d6c7de59fdd6bf103d7d132475759cb715d536391cf1f6ae2fb85e2e2cf52e5c5702c23d529048fbd7704ab835286d75c49dc39aa875ae86b03d76170447683bbcb8549c73561f4df136d191e4c3a9afba7daf063dcaa2f501321c0549ca8849c8ac316adac25453e6a42f9eab37369a8e8ca14a03f001a9c4434aa3a01460915da709c63d6098a0d01d89828b845209c631491484a4fd3e2a7a7c35379c76c543bccaf1909fb55a71327dd5fa62cb505764a53ab6cb81adedb79255fd23381409a534ebf749683e9900727ef57fea9b3db9f61c5cb403b124907f1559dbb56da2cf3be562b4da5417b791f7acb5405c18b40af6f230fac8516f8494389292801201a8ad413d4fb6b6d846ede719a5df986e0ca5c68f0a1feb4ce52e35ba229f9ca094a7be4d3e7f2f6c113cac02772bdd5b64793054ffa2ac907b50142f4d8052f8c6d2739ab1352ebfb1bb1d5137208e7183552dea5b721e53b154304e460d25ca545ff0030271b8bde6f098c9288c0e4f91424e21d90fa9f753bb272734e4b8e3aee179e3c9a738fe5fe9c783401bc29d4896af33f3229f60bc8d80e0fe2b102d8eb4f1703840f22979aeb6846507915b5b1d0e0deb3819ee4d0d6956f8109a7c95b5b999710a4fa8092714adb8c941ca96768a5de931540a02b247f9a45996ca5c09da79ad3c0b2770e51f56f7179f35c86d8780e0f9acc0ba479880dee1b8f39cf6a4e7142a2a8ac13c1c0c50c448529327d54257c1a2360a68488797bb0c5988cb723d52739e734f952223aa0de13c7151b15c52a380ee414a7cd324c96d12085ab1cf15081bf88d1ec18ea038844d37112f64a522a459ba438ea404b801c802879202c256803fbd6926d6f49295b20f041ad5b7ff97c4d5196d3b412dbd1d73908b8b6e34ff04a4e33f7ae87b425bb842696402a090155cf7d2cb1992eb624029da0726ba36c2d3119a4b08713d86083deb7ac853d4b8f078ee06ad1d18357c841b90401c0a8f4328c83b45146a4652957a9b782687945208c0a7f8d76d752bfce622d1904fc6e28d0091814a5249504f7a50107b5141b7f3101037a8aa294071e29241f14a6738152023531f1f11664ff003376052aeac95023b76a6cdee0695cf1cd6bbd4c0d91360735b8ee29349fb52893923f35bab99900c76da82704d1b6919692361278e6819272001e2a56d93e4457029b73818ce6a0c94f34ea37e2b2bf4b7027e25b2c9dc9183deb6738c03e2a16c17812d210b50dc054e10158e47355cbebf0f99d471b253253c9661391c7dab74807bd780e7b78c5640dbde8361d494807b9ed95ba53c118ef590326944a71cd40c7426a5444c20f1c79ac94e15c8ef4af3debdc1f1423191309a06eb6000f15b241adb02856306759e0062bd81ed594a4f14a06c9f02a32df882bacd00c78ace3ed4a06ce7b56de9fdab1e660e527cd8ea0c8fe1f6dba42b5e8c371637b6203b29cf5be54adbcbc54db7dde52882904600c8c13cd50e9829c943c93ea6541431b7241e78f1f61debea45fa0741dfb4c862d6ddcb4e6a777d490cdb5a99eaae33233e9fcc2cfd0874a4654dee516c1016527207cfceaa6916ac57e7c437c3ed156e5ac1cee5e49528fb9fbd7d09e8ae00e6f0ef761fcd63b03ff0099c97c3f554867ec28025709b7c446e5a9bc63b537520b8a096c641e0629c49945a494b83033c135a585e61fb9b4db8bda9cf9eddea1c6bb2afc95c6de8ef5026a6951a11d5be038db894ac15151c600a37876e758b6173e5c7e40e4546ea3316def40911ca76ad593567db2e7617f4c96c21b2a4a0151f39c55beff004a7eb7205163eb426f8f8a3b3b95f5a6f6e5aa5255206d4a4f9149ea7d6122704a62a8637633f6fda9aea790cbcead2ce529c918c0e4521667196d2187109215db806a83ca714b8171a94ef532ff00d93f324acbabd5123a9b73824609551e68a97f331d7224389daa3909079aab2e903649f518c14919c11c0a4e3deaed0c7cb4294bc79c78fc5475e6154f03335673071bf896f5f2ef674bde83c72bf181cff7a85675cccd2b778d3a338eb9150f07dd8a970a1b7520fe82003c5045b25cb7ae4854d754e1246771ed53b7e722aa1e7720ac24e3fb54033adaec0ebd6a1ed7a650f1d753a4f557c4ae92d49d2e91636ace6292cbcfb90c8538e4b77d05210a7144612949513807dab8899b8bf1929daa2da9230403c678cfed81c53a9b75b932d390d996b4b27254371ffef1f6a8771b746e71ce30470a3c8e4ff6ed5b729c98e5516a45ec7c98b763118d887e24c5bdbbb6a19ecc188971e71e50084839279a30bc74bb58e8a663ddeff6d2cc556141cdc158f6071c8a43a1f3625a359c3b85cd942da6ced5ee50e32ae143c7835d1bd68d7fa32eda0d563b6488cfcf94b42806c6ed807826b9c727cadb8392b8f557bdfc99d5fd33e99a798c0fd7e5587cc7606faff795f68b4b5a9ad5e8b0a0dad00614053fb474164750f5148b2dd2ee62a9941703db32508238cfbfe0557fa57515db4a38b5c36d2adc7b2c71fdaaece8b6ac986eceddaeefa54ec848412aec79e38f149f2ff5f4b9ba93d4be623713cae27e8b2c6edf8d0f89cf1d56e8d5cfa657c45a64cf8f29a2494bd82938f048a06936a4c71bc4965dcf94a6adeebbea45ea9d7d7092d6d710c90da307207b8aaa6e6a2169d8d842bb6d1daae3c45d957622d995fba716f586261e0f26d8f87d288393b730f851649fc2714bc69931e5868eef4d5f73c517dae0b2b47af29014a09fea1c014de531157971b481ce3818a20e46cf8c4a9c7305f70c8f79f2ddbd11379dbb82bf7a736b8c5c0e387b2124e7f6a8db96d4148c9c67c5115aa3293635a86773878fc544ef0aae891401f588cf19a938cd152d201f6c524dc5fa882839f7a94889619295afc546b67e6696d3a93b0e27a884a179c04e463de956ede0be14738f6a52d2f21c054481ed53898ed2f61c7723b561ecd4f56a3e20f5d6dc8432084abbe6a09504861c3e99e0a79fde8f2f3015e8a427b115172edeb6a2b69427f5f06a316f727b291f680126265c2026b685072a3bc77ec7daa4de8efa65391d672527c0f14fad91c0712569c0dc33c54ef6fd04c1d6905c4fa13f0afa75361e8ed9dc08c2e727d7e460e0f6ab89a654f3a92a00e08a19e925ad30fa6da7180b2bdb6f671c63ba7c51cc48e524613e6aa1916b3d9a964a902d6351d448e0048c9a94623050c7349446b18e3cd4ab0d0032535a2afe645b3b8808408e0f3584c220fd49a914a40e478af2d7ce08a97c44c16ee43cb8e9008005444a680f14412c0dd51729b0a06a371a93a1dc865b5c670299bf1f7f702a5dd6f09f14cde013cd47bd498414bc30decd8a4f39c76f15cbff0013dd376b526959725968ade611bd071e4735d6171650e24a943383e2ab9d6b6d44cb5bf11c4643882923152635a6bb0348f22a0c844f954c1536c86dd490e36a52083dc60e29fdb5dd8bc78a92ea15855a5f5cdcad8a42b05c52803f73e2a0da516dc07c1356b5716202221ad3c2cd0871679202804e00f34511a721a68952876a06b3b89dc0e7b8a20255b76f1438628e0c7007d3b1266d5253267254e90024f068e24eb36ed2cb2cb680b4100139e6ab68af9630401c53e99390fb49dcb49e3b5325c935aee694e58c624fde4ddf355bb2d615154a4922a6f4acfb9cb8f875c25247634120b46302a40cf923daa7b4bdf5b84a2d39c231dfda827c836383a9a7fa93596fd6742755fc365f625bef022c8504655bf2a35daf065a3f877aa8770928c9215df8af96568d7a9b1ce6a4429012e8c1c7df3c0ab919f891d5b26c661b0e03f4ed1fa811c7e2b8efadfd2b7dd97fabc67d13d7cc6ce6bca40bb12cdea6f53633daf1ab5c6948286c94b802f2739f347da5d89b795b316d6529549012147903deb8834ebb7fbb6aa3747d2ead6ebdb96ae48009aee7e90fcd316e8739d47f311dbc553f23157820ba209eb72616358193e3c7e2146ade95eaab3d924deedd7e4c85b2d7a8a614ce31c7839aa3636a8bcb97030aed1832b2b09c9ee735d5f72d452675adc80f464a52f35b1441cf1e6a90d51a66ca2ecc2c84a5e241ec39e31566e2794a727352aa3e35dc030c64329391012e11e287d2f1c6e3db3ef52916229c6d076823c533d53a7ee6e4b67f86b25694ad3dbf356569bd292d56e60ca64255b33fa79ae8b9572840a0cdd7e87d9f880336d7968a96d1e463b50dccb76d50425040cf2715784dd29fcad873fda85a768f716e2836957f6acd5c87e8d01f2903d02e6dca0b59d865dc633b16392da94080bf618aa60748efadde43a54a5a4af257e3bd7576a2b0c8b7acfa8dfd383deab9bf5f0da14ada13bbc0c0a734e6a5dab09833e220fa4c1d7edbfc0ed60484ef2da4673407a9262751db1f8711412e024633469719d73be8710a6f0850ff00141d74b23fa6db5cd693b8a8e549f7a7d5f2f5ba8af46016e11d69651b3f495d5134faacaf6051ef484ab3c88691bda232702ad79f39897196e05250b27f4fb5094e75614491ea0f6578a5991900125604d85e0364c13442404853c9c007bd2329c8e968a10b040f6a777879c79b5b6d20233918a8216f908465615ee0d07e7e7d999c7c6363684899ebcad4904e0d3a80dad718047bd79c80af530e01cd4fd86d7bdbd8801593c62a466f05d99a7e918dde220acb2fc49212b1fa8f15236e8ce49750f290adbb87fad6355457113929524a422892c2c34ab4e5272bc54bee2b57d42bd83559a799b9db5a31d25ac7d29e4545c0085ad6d8c653dea590d3a63294e2f904e79a6c95438e852d20257e4d40b61f885352afa611b3ae6094207229a396ff005d5ea2d78269e2595a9c2fa07d3915b6d714b231daa5ad8006672ab2cc14fc18ea0c01e906d0e7d58f3443a798227b4c3c014a88ff005a656984b7482524714536ad3f28ce8ef606d4104fd5f7a8f22d257e23ee3f0534a4cbb749e904376b4494a36294076ac06afd67bbb4a6c38b67760e7c73535a6b52da0408f11c7d21c4a4276e450feb6ea7c6b2c96634686a74ad6129294679cd0d5b15ecce91fa1adb107b7d187d3e33b36d6a7949fa86d3422e2548794958ed469a32e4e6a3b321d7da52378c9fa7b5237bd2ae870bacab293de9ce2dc01ecca8f3dc3596a864ec882391c7de966fb1ad9e86b65c520a718ad5231914e51830d8941be96a5fc5868c5134a03e6934d6e9f15bc8bc62a8e694af349045289464e302b20cf78ea6a800f614a212735ed9b4d28da0eeadc4f09ba01ce69c237004f835aa5b34ba1194e2b70bb3a9b6f43624cd86529890956f38e38ab221381e65b51032455511c86d615923156669c783d15bfab242693f254e8752f3e9ccad9f0264b04722bcb18e314a6dce38aceccf7a447e352da08d44d00e45284605782715923343593c4cc8ed5918ed8ac0f15bf1f7a09e68d329031dab2139f1590401d8d6c923da8578334f200a59205689c7b52c8c1f142b1d41d81980064715becfb564004f9adf02b01e0e7af99c8faa345bb16ce254041b738487dcb7bae06c3a9290a4958590549503fa0e09dd9392723937a9b7efe1f73976b98ca90f209506ce0247fe939edf6a86eb1f59753f55b59deb596a59c572ef12d7216cb4b5065ac8da94a002384a02523f19aad5fb8ce964a644c90e01c2429cc803db9c9ff35f52f09c5d9e83b0d2b91ee075fa97ff0049fc7f3384582cac9446ea6f3e73afbca2a57d2aec3da9b3121e61f43a97384568559c83deb04e39a5d7d9e591fa951a320373ac2272e8e4f6d96dc74a8a71b41f156f74cf406bbd4d66322cd637664474eddfbd201f7ee7b550d1dddae05038fc1ed5d27d1af898b4f4f6c71e34ab24c97718085262202c08fb8f652b9049ce3c53ee3329acc8f7ed6ef530d9b6a0fa4424d43f08fd5583613a93e4614f480dfa90a33a56fb5bce00c6dc13cf827155a6b4e956b4e98bd17fdb4d392ed5f3a55f2ca7c612e6d00900f62403dabbdb4b7c73f49edda2e1cbbc4f85156f3013321c7f51c92641fea0318081ec09cfb57377c677c47685eb6e9dd2da43409992a3d865cab94d9f2da2852df7520250d83f56d18f206297f2059999ee5eb7f33099363fee139e9a9ec3c8d8727271cfb56ca66346dcf34905439a136a4b8cad014a20106a41574dcd1c2c9ce2a8b6b82eda856ff11412e4265ade3807c1f1587253f255f52c9a66666f0413e2b31df08c9f7a5b6da47509a5c88d6e0af454720e4fb77aec0f863d37d19bbf4fa3cbd5f6ed347d72b5dda5cf5214eb4da771291958209078c24f35c6d77714e9c1ec7daa3a3b23b909c9395707923b79a3389e42bc32c6c5dee43914b5bf785ba8e65aa26b0be1d2ebc5a1372908b7e06331c2d5e9e79ff94d39d3f7d434f2d724e54ae38a105abe9c293919e31c60d2b05f2dace694e6d14e5d86df1d4b170dcde4e0a8abc8ea5a2c5ca34ffadc5a138e31ee29eb5aa5db4b4b4c5770082010791f7aaee1ca294f73c9e29efcc2ca30a04e6955985e5f49f896cabd40cb5f98e9bf3333651932d729c70ee5a89563b93512f252e4c6d3951dea1feb521b52b18c6093dcd317121b9719d7b3e9956094f7c679a6949089e1f8949cdb6ccbb8dee764c9494f370982d82a076e0e477a1a6e6ac052377934b5c652243e0477d6a40c82147269898ea49ee39e6a05ab6fb853657f642fde2cac3c72e1cd4c46bba5981f2c16011daa036bc0fd2303b9fb568a7961be4f39f6e6a46ab722af24eb46134496a7092b577a74a5b7c10bfed43d1649f4783ce3cd291ee38590b2329e6876af52736078650a41404a10ac1cd1b5b945e65b1e46326ab5b74f4b8e2411cf156869c682d94157209db914befb0a7cc2b1aa0edd494b8425182d2d409c9029b3f092eb0d9524e1245154986156f6c01903914d13096b8dea6c1b726825bfb8e5f0fe3a95add6ca1bb9a5d6d3ff00150a279a7112d19614bc13b46e27da8b25db0b8af55280a534851fcf15adb2225501e4b9b429408207b628af7c95d413f49a7dea7d04e8fbe64f4eb4e2ca8287c832011ffa71561c58f9c1cf6e6ab3f8797133ba51a75f50014d46f4881ff49c55af1d200e0557c9dda4c35fe858f62b0909cf14ec100638a6cd2c048ee294df5381dc0cb6e2bbc0ef9ad14a04e693c927b1ac950ed5933206e3694a049a8f7f90453e9590338a8c79ce71cd46fdc9d06a3690702a36412a18a7d2159a62f7bd41a9309112d7b3e9cf9a17bfb2979bc948c79a289acef5eea83b834a292829fef5912423c86a7cf3f8bbd2abb46b88978431b1b9631b87935486c2a5240c77e6bb73e31745aaf9a15ebbb09cbd6d507723c24727fd2b862348de94952f1c647b9ab3e1b16a84417815dbd426b61c2d18c9e40e28a939535bc11c8a13b238838e7b9e68a99dc13b07602bd68ee31a0f908ab40ac10719f14de43720286d4f9ad90e292a0b0700280a7416785afb66a77526bdc5f9d595ee388a566384afb81e6b2094a894e318c56aa7411f4f14887d20e49e33428707a110e564f402fccb8fe1e7a550fab3d48b6695bace5b3164c8517543bed480702be846a1f843e95e9ed2cfcbb0c2911e4428e56a5adedfea6c19391d86715f3cbe1db51ceb16bc8132dc5497c3bf4a8738c91935f4bef73f5beb1d1ab8316e2dc776533b4a928e4e45737f53e71a2d616efe3a8eb8f4bad55b11ba1f3288d13a1f4e44b94b84db2db8720a0a7079233571d8d70f4d252dc91b1918efe05553d3cd1fa8b4dea67e3df5f2bf49790a23f5558daaad2bbe422c35b8123194922b985a8d96be16bec8973f699c6cfde125cb5d69d6e3af6dc1bdc076cf7aa56f376997dd731830a2584ac6d009e707fd2946fa3d25b7557454d98b5249250a77e9fede69a8bcc2b7ea48b1494975957200e6affc57009c6f1adc9a9db4d529543edfe65e560b0c5723b4e2d905653f57daa7f6263008d9f4a462a1f4add6398c97b209db9c669ecfb932f8203a12a23dea9d573f9f6de4a9dff1027a9cdbe3aea2133f9bb94919001f3504b792878e41efd8d212f54c684f2a3add4a943c950ffcd4649d4105c49703c8cf72322b5395c867652d458827ed1a63e305ed84abbe206fd71d3d685dca1b19481956e3e0d71cde3a9576bbcd0b20252a39c03f7aebfeb9cb817bd2f2adeb707a81be067bf15c20e34ec5ba391d282af4d45200fcd765e278fcae3ea5f78fcfe620e63fb476bf797be9abcadcb6a5f92ac653918a83d6daa018aeb696f38f7a4f45da6f77a603298ee04b601e0558a7a630d7685bb736fea58eca1f6abb38b5e80aa0007ef00aebb3c366725c8bd4f76790d28ed717c0f6e6889b0b4b00ac02a239cd1bdeb40d8a14c75d6d6d202547033ce687ae50d0db0e08b8581c6697363fb63bee2b75767d18177288f99a92d20107934f7d2615136be94820536727bb1e41f533907001a617296e3a8de8563279a1c025b527aad38e7e246de827e6025ac60516e848a0f2a4827bd0824a1c737bc7edcd1d6867180e90140f1c0adb283254615817adf91b2243ebf82d25d4bea4246ee2a334d02e214d249dbdb0288fa88c190d3696864a4f351d628b1ed70fd77dc4a4ab9a831afd57e261b97806ecaf21f116b92635ba0942d3f5af24f3e283dd98dbf276b47e9cf39a23bb06ee214e2e4255804000f8a80fe1e86d44b4013efed4463d9e2df5083dd43a9f1acf424a19f1a2b4128c2b701c1a60fdc02d5b908db8e78a691e34890fa8b8a3b13f6ef4aad856f0848f3e68c77423a90fb969215a115b2fa5942362428fde89a16a0bbbaf2047692071e2856d505a6d3eb3a91f48cd4a5af51c41714464808c7627b50814dc7423fc7bacc250f61e8cb32c7a73545c5d69f6145049e70938356ed8b444296db6bbc3077a003cfb8a8ce995fe3bb1da4b8b48cf6247b8ab3243885c6f55b70138ce0639a81eb646f19d1f8eb687a45ca7723177985604221c08c08031c1ed5256ababb7138763909238c8a19b55a5d9f7bdd2010806ac5890d98c12da523013e05180f8af503a9f2b3af3f6510635058d2e305e8e8014724e682d4d29b528293d8e0d5bee328750a6978e460502ea0d3ef4790a75b47d0ac9cd1d8795de9a567d4dc280a2ea877f7838118c7deb709f18a554ca904050ec2b180143e93de9d29df7289e0c0f626eca7de9740c76f35ab600e714bb68cf6ada78a998481e69642466bdb002326b746338add247e3af99ba40f6a5d09c0e6b440069ca539038a215483b3244507a89e0e4628ff47ba4b6949038c0a09433f503c1e7b51ee8c6825a52948e3c5019c0142658f810c323a1d4270077ac7bd64e462b1c648cd555be65f47c4c5640cd62b64f6a19fe26773001a5118f22bc13d862b74e38a11a684ee7b656e84722bc06714aa450369fc485a6c940c56eda3b5600cf14b20631c508db9031d4ca5231dab3b4528902b6d95aee0ae7667c230dadee520f3df34a263846770391534fd92e76f6f2b84b3919fa476a8490ebc9590e20a70791e6bea0094dc0d85b67fcce0ae5bee220ee12bcd20b5152b09a51d254a18207e4e2b286881b8e0e47bd01610c7c5441cecf734057b81f14fe24b71b5240510011e6b562385272715a29ad8bfa7c5108a6923ca6848844cca5a98012be79c9229fd887cdc95b2fb8a25631b8abfc64f8a1b84f907628e28c340e98b96b4d57034d5813be7dc1610ca490013f7a0f96a1af55f0249990da1b8cf505ada8734331d6149da0f7cf350c870b44b6479ae9bd5bf045d7182c3526cb608f7a69e077bb12483b163fa4e40e6b9f750e81d63a66f73ac97cd3b3224db7ba5894cad1f534bc6707f6aafd9877d7bf259b579018eb72194eede78c5790e9511b4f149bec2dbc21c18246719e45621a4a54a241da077c647f8a5ed579b6a14ac44de490476a6ec8fa86053879c6d47685027cfd438a480c1ca6b4357874610afbf99a485ec4907bf7ad21a54eaf35975b5b87914ea030519c8a89b5f69327eed88fe3a3681ee2a41a41291dcd34400d0cabb77cd6c273a4ed65b27f3da8761b31925848f08fc359182003f734825b4ee4ab6ee093c0f6a6a99d252b3f32eb2d23cf0781492eff0011b94a654029b18c382bc0191b7d275139d6d583eb32819e49f1512b71d6ff005fd241f3458c3ad486fd469c0a49a8bbcda12e1f5904fdf15916843a91ba161d4dee0cdb99b6426e3c84bf2a47d4ee0f20f814de7589f89099992c21bf9807d104e0ac0ee71f6a8e8f1d6d2b76771cfd47efe314571eef02eb39eb9ea6085a623296d88e0602881c71e28852ac3a81f9321818971c655d8e33c8f6ad1c5fd456827268b6e9a72f57088bbb26c8e33157f5248184848ec45079496564141c671fbd68d5ee4e97184163f51c75bc64f6157b68e614e5a5076e4fa9827f61ff009aa8f4359fe6df4b8f1fa783c76abfb475b508b63eb681d8973033ff00a5348393015259387dd968dc238f03ff00d30a88cec4f63f8ada6406dbb3a9d4b7b48e462a412a4ff097427bed3fe9495c92e2ace36765a71fe2ab82ed1d4bab51bea4469db789f2a4b0b19dcc2c0e3ce0d40b50fe59d931d6de36acf3f6147fd3c8a976fa5381ff00014ae7ec286750c708bacac0384ad59028a5b8f901057a009d4df093785cce9d2a03a4854298f2369f09ddc55fd1fc608ae4af846d42cc69b78d352080a9086a437cf2543bff009ae999fa96d1668ae4bb95c988ac3493b9c7578038a81bab3c47de2fbd7a854928091bc81f9ad54f21032a38f61ef5cdfaf7e2b6cd6c5aedfa514a9ee24149790de500fb827bd55b76eaf7506fedaa4cabd3e9616094a50b295363df09c9e28caf198c5e409dbc64a95ff052547c0033fe958f9a57f594fdf1e2b84daeacf51ad31caecdadc938e50e2c83ff00fd014dd1f137d55b1c94a9cd409712e0e50a642c28fe68a185d48bde0a6779ad4a59e7073e0545c9c6f247838c1e2b926c9f1adaae34b6d1a86c91e546380a535f4ab1e6af8d05d69d27d498a872d52d2d4ac65715c237a686b718d7274b8343078139e3b0a62fb891c1e3ef4f14eefc907391da984a4a86481f81411037a850dc68e949e71f8fbd40dce747677b8e28252dfea2ae00a5efb7a6ad10de90f2804b409573db8ae46eb375b6e57f7dfb069d53ed0528a14a4f248ec7b66a5ae8f2eccd6eb8a2f5253e203abfa7e2db66e9c64b32ccc41697b0ee0904107fd6b831f684694ea1b4ff002d2b51464f20135d2f6ae8cdeb51285c6f77b6e3b2a1b89fd4e1cfdb15cf7ade0b169d4d3add19f53a98ee147a8a4637558710228d032b970b0bf918f2c4e1dc9181dc51db494964280fd40557ba79456fa103c119ab15384464fbedaf5ff3d4b0600f358c3d5421e2951e335212de4a90da5b48002739a8398852d7bd3c735216a0eccdacabf50ed4481e550115e75c3dcf6a2c970293fa87e29dc5829909c639269576c8fb4d02072ae7b52b1224d69054961c563c04939fed4ad88a1bc9fa12bd918ce9668886bd31ba35a6751c6ba3e921b656376064e3debb8349fc586975c6896dc2d4e04ed528a08c0c62b8cba5ba5a75faec98cfc07836a50493e99c5744c4e8a3369696f7cb6d7024290424f3558e778ec1e61fc59bbfe25bf84a1bd90a442bd75d758adcf336d690b71dfd2052b6cea86bcbeb29fe05a7264c5251957a48ce28474bf47debe5ccc99ea5a90858c24938001fc5755f4c2cd68d2d6f11dd6ca3800148c67fc5728e56bc1c1caf66a3f12d56dffa4a3cb5b9c6bafbe2875469096ed8aef61798900e161d052519aad23f585372b89bcae580e839c173806ba8fe2c3a556eea1bf3aeb12de12f292036bcede40ee78ae05d49d20d416669f901d71210a23193c9f1571e1b92c3e4b146297d6bad40c5f6d605de3f32e997f1637db030ea20cd42c849030e9f0282a57c77751a1c857ca8617fff00b326b9eee762b9b0e292eca5eece0a49a8972cee124a9c39fbaaae9c67a478da4fba577b88b379cc82c55340cbbae3f17bd45ba3ce4a76432971d2784e70298a3e2a7a84d72992957be566aa28f667dc50434a0a39ed4bcad33736daf5dc65413f6a789c3f154d81d2b1b8b5b93ce61db4b491d74d5ba89cc4e9ee28ba790164e0558dd39d253350dc197e54452c38a19563bd505d2fb52e7ea68f11d6b214a031fbd7d4ef877e86c192dc59338909da15b40fb50bea1cbab07db27ee40024b85e592c6eca3b0b2234574f22d9e0a1d435b0a900e08a6dd47b6488f64588782e0cf033ed5d7f73e9b59e1d9d6dc469214d23238efc554173d20c4c0a6e43036e55dfc62b4f52fadb1b8ea170dd3c5888eb1b2b1f3d4fb227ccdd50bbf26eeec792a5a4971431cfbd3b6613f16182e124a87393ef56dfc4be9db6596f0caa125287b7fd40632466aa766e8dc868b6e0c00319269671bcc7eb2a057e0c55762f85b022fd6d79c965d6520807b0ef9a64fdb9698a14a41cf9a9e993586e5a82064eea4de58909db83934daabb6ff106b71f7f06573772ea029083b40cd49e86b93d1651c6e24f926a4ae1a75c92e121ae09a563d8556c4178b7b46339a2af75b13c60f8b43d16f9c909b762fa8fa98573ce6a167b12a420a8025b39381d8568d656f9538a1b09cf27c54a5cae90a25b0472e04bab18481f7a0eb02b206a59eeb3f514747460548f5d95e50b2024f6cd6d6e993048efb8679cfb56d2520ee737139e69a479df2d202b191914d1abdaec09594b5eab34c7621736f34f009d81271ce2bc21a12e05e49f350ebb9b4e277a094a88c7152909df996c252e64e2816565f996256aae4040ee49b6a429bd81630286a4b4b6ee49095ed5295807f353f6db7c82f282c6527b734f97a7c87bd72c95149079f06a4a484faa079565ce027fe225e5d1782edc6dad34e924a5230455a722d3768ed80c2d4a40efcf8aa9ba3973fe1a32eaf0903181577c4bc477d014477191835a125acf233a0712b8f6e30ac1d36a21a7e5b31e404ca1b17eeaa259d76661c6f5bd54fda82b5134b69c44b4700f3c50ddcf503efb6585b87008c0144d35fb8fdfc4c59cb7fa521a8fcc2d8bad644cb988e8036eec03fbd1dfcb33708280ea7bf39aa674d4c8adcc47ccc8420e7b9356a357c61888d065d0a18f1cd116d5e274826fc4e5365565f20fd3fcc8dbbe964a145c67b1a1b7ad8eb4e94517bd717a51fa54707818a44c12b3ea2c51548b40faa22e568c1361f684164c35a7b8556e10b482122890414ace0339e714ba2c2a57d41ae3ef450b8afcc4e306b7fdb04d69776fe935b308733950a31162484e14d0ad916364f1b056e995a324ff004b2c34b069a42c8ca5048fc53968924023bf7a34b4d998396d6c0231ed4e9cd230dd56f48093ed467eb148d093afa7ad23c818316c825e5fe827cd1fd8e27a1180d9b4fdeb16cb2c484010d8240ef9a94c80060629765dde63423ee3f8ff00d21f26f999524102b4284039cd2c13bf935aa9b1922915aa47663556ebb896e4fb9ad93b48e0d7bd34fde946da03de836f8992c04c01f5035be056e13590827c0a09fe245e7309a553594347ed4a251e2827123669942452c90315aa0002954e09142b9120633281c8a5702b000c56d50ef50733e71cdd256b911cb463253c11909cf1542f55744b561989762b7c38bc1f15d172ee8d8b7890d292a481c9aa43a997e37c9258dc9296d44803f1567f4b723c9579a7dd6246fef39d72c98d6520563466ba1f48691b8584bf736a1fcc0071bce540fbd57bacad912d9394cc509d993b4a4715231642e000e367eaf61daa0b50ce54b74a979cf8fb57d2f5f39c7721c6ad42ad583ef2ad6141578ebb918d38a031585918249c715a2163071dc56082e2b69f6aaf64697b11501bee291558736e339a3ce96ebf99d32d6f6ad6f0223725fb63a541a50fd61430a19f1f9a0584cb8b90943682a2aed8a3eb5f4f6e7360094db19c8c9ce686c8e42ac4abcec3f126ab19af3a513bb348ff00ed12d0b73b5b769d43a1ef30d98aa4be5a86b41f5dc03949248c027cfb5730ebfebf41d6fd46d41ae35243721bd759c643719afa909013b500e719e319aa5c7af6a96a654852148241ee3b7ef4c6e6faa53ea90b515123819ed496de77dc3bad7a3095c054ee5c8bd07a7b5469c7a65be2a3f88beca4b2a42b2a71e2ae0253e7c77c54c74fbe17aecb90a77a876e9f062ba857ca351940190b1d803dc28f71c5547d38d788d11ab6d97e7db7a4c788f95ad92e1570719dbf71e2bac75075917d57d390ad9d389571b286e52e4b939e520bcf3a46d6d08009da07ed4c70131f37ea71dc5f72d95b6bed3973addd3f8bd32d7f274bc59ae4a4371589480b202da0e8cec700fea1d8d04b49c37ea1c6288f5c69ad62ddf6e571bd8997079521687e6ac295eaa81ee54476cf6ce3350d1e04b78b505961c5bcfaf63694a092b3cf618c9ed49f36922e2888612b60006ccf3290e0e06453a61a093c62ac663e1d3aa3174ea352c9b37a71d4d97832a5ed7bd307f56c20707fee287f5d681d4bd3bbc3365d4f0d31a4c98a898d84ac2816965401c8edfa4f1f71416471d934d5eeb21d4371b22b77f10ddc119ef2d4e222b27b91ba9f32da9a64240049e0d46dac197739324f291f42454f32d8270a1c66962ebc766313bfb462b8a1dfd438f23be6994bb63640cb4381e78a264474a87d22b57ade169c9f6ad56d00e8cd7db63d9304613efda9e38fa90aee0f602899b75998d256da81053822994cb7800ef6c118f149c142e2b98da42155e650c762795ca1d19876336ccb2d6dfa1433fbd349b05c4ffbcb64e09008f6a9c911cc964ba84e54dfb7734a5ba222646f4c9c92ac0c8e335943e3d48ac1bee256bb9bf78d96a972e63fb004b6ca1ce33e2a33526969f655ee95096c024e02bb1f39a76ddbc5b5e6ae4b4ad2d87436f16d5b7e9271fb668a752c1bb5dacc8baadbf4e03dff00ecec2dddeb200fd47da88dee423e9f891fa1259731163a4fd2327357f690752ce963bff5a9c513fd80ff00b57386879addb6e8e7a876ee04007deaf8d39393fc2131d2b0776566abbca8623a96be08eec10cadce876d4e959e544a47ef4f1c689d3b1dd049dca50350715c50825a4ab19e689a7a3e534c4551180b6cad3553b34b66e74355f2d18bf4d1b52af0f38949fa23affc8a85d570fd1b9cf70a71b81228c3a50c054bb83b81c47dbfbe28575fb853747d0a24051c0acadbb7020b6a1ee47f4fb524fd2bac225e2dcd175483e99427fa927b0abadd83a9fa852dc7efef3b022af1b584b7b9241f3cd527a350ca25a9e5f240dc9f7c8ae98d39ac6248b3c62f3c96d6946cc1233fe689b8eacf258b1ebf2dc73a73a3fa22132972e2d4d5e7bfe9d8afdbc512234c74d2da42d8b1c4f513c65584a8fe4d5737feadb305ef93b5b82438aca4e17800fdfc545b3aded65954abf5c105e51e105584a7ff00345d76dadf1007a141d930bb53e99e9bdd72e39a52daa5024e7d4fa8e3f155fdcba75a1ae00263da9b8fb091843a48a61a87aada2ede85bad5d6095215b3f50f7c7bd093dd6dd32b0efcb496d2b511b483919fef5316b80d991eaa3d47f7ce84bf2197245916d2909ee8feac7daa3f40697d47a3b55c3c32f2097124a929ee0287048ab7fa75a8a16a3828dcb42dddb9fa7c8fdaac8b7e9d8af486de5b09ca48e48c50d6e5330d19814aa76213d8fd490d214bfd5e9a4907deb4bcba639c123b54dd8a2361d4e13804639a1dd6eda9b69dda93bb903142a12c773757fb4a43aa72ee7a983b62b22d4da9fc852c67e91d8d0be97e935b74c43f5df73d598bcadc7169fab3f626aed8168b2da2319b74703b2dc3943094e4807c9fb550bf135d4ed4bd39996ab4336983063df90b544942525f51483824a01fa7bf9a62943d83a90365d55b69cc09eab6a99ba462cb96eb814c0412dedc24f6e3b0e6b892f32dfb95ce55c1c4abf9eea964957b9e2ad2ea5eaad5136498777bd9928792957a4521200cff00a50208edac846c183e29f60e21ac771266f228cda513da396173c36a3c91c5588b514a024fb502e9c8be9dddb525184838ff003470f10b5ed49fd3dea3c8015f51df16e4d7e5135b09712123b93de88349d89d7a62160138fa49f18351d696499010b014090055c1a32c83d30f36d02538c803346e2a823460f6638b720346c8b0364ed523838c6e15d57f0fdd27d2772b6a1e996f65e714904ef46706a959b649822faeb8cb084273b827ed567f413aab074c4f6adf76981b4056cc2d439e3354af5e25af807f48ddff0012c069a803f4f7a9d5f63e94696b4b5ea44b5471856e2436011c5456bb856f85150e94a11e91c2001dc7b512b5d53d249b407ff883002d01590a18c62a92ea8f50dabaa1e541737b2d83b481dcd73ae278dcb7abdd1e44c0b8ef77ddfac68492b1dca1c790977e94214ac715694092c0801dde36edce4ab8ae2687d547de7cc28ee1dc1653b477a88ea87c52ea8d070d10a1a12e15a709cabb1c5576df49f2bc8653381bff00319f237d2405633a87aa1aeec76586ea65bada8ab3c1c123ef5ca7aff55d82f2dac0723a01e30918f3dff35425ebe20351eb09c655ea46028fe80ac7150f2f547f1441435bf27dd59ab2f09fd3fccc775361fabf8806472d4575687c08d35e45b67cf38a892776e56720f0281dc659413fcdc91ce73454fd8654d0a7559e41c0cf350174d3cfc546ec2abb971bc25945414994bcbe46ab6e252348739a8ae6ef57ee6a4ae1ac993044464ee51e32684df65e6dd29528fde914a3eae7068ab30753417f52e2f87db7aae1ac23bee01c2d2727b7ea15f58ba4ba81106df1433213f4003b8f02be52f45e50b434ab886c24b692724d1a587e2ef5ae9bd561a4292f5bd95a87a581dbfbd507d73c16672a89fa33daf72c9c5db8e95325ff00f94fb1ef6a712ede595a9054afa4949efc5075d61b6969c58001e48ae52e8efc486a7d71744a9e690dc656d5631efe2ba355aa997e3875ce4ad3d8d50aff004bf3bca1f7b3be17a856161ad3f553f06717fc49e83d537bd64ecd65a518e78460552d2ba6f7b80c972428a403c806bb87554c8378b8bac652a7139501dc0aaa759595a7c2d1b12327c26ba07a5b86b11450bf69be453e4de4671ddc61bb6e96b6dfc9c1f6e697b6a4bcfa709dc38ab1fa93a1d2d20dc184fd69ee3c1155d429ad44696928daa4e4559f2b8f7c6621c4006ab7fabe24d2a1b2b585041000f7f3511a8d9586309ec01e33de921aa63a57e9ab0306b332f3026b3b4609c5237aad56d8f88e2938f68f1ea2da105842c3b797638690afe621c4e4a93e40fda8035436897779060ffc00e2bd2fb27c54e34a698944e414abc7b561d888dff30024e38c7e6b35b3061b916654a95908607ad2f36d61cec38a62b4952f3b462a4af8fe5d56cc048e29934a6d6d81b867b53e472544a7642b0ee61956e596ce39a23b536a8db560e479fc541c68bfef29248c1228ad863084a5201c8a1b234047dc379dbf06495b2ecdfce21b713819033fbd1b4e0c1881c6c03d8f7a13fe1b1d1050e96d21c3ce4548c5ba811d319e4ab00104e28100bebc4cb1d8f5d20fb821269fbdbcdba88d1525083c93ee6aecd33734ae080eac6f4a79e6a8cd1d01e972141a467be0d1adcd9b958a12a687c86f81c1f3470d2800c1b10dcae6c4f89666a0d4b11ab7043ae7291c1aab2e9a9d0e3d88a16b2a3d81a8473524ab932a43aa52d29cf255c51268db2c0b9badac3616ac1fef45e3956f886df8cf9da2f1e5974fdcaf4f34b05684121440357469cd3725a6da8eb0ada12393cd3bd1ba3834c233180ca720f8ab2205a1b43686cb382051ede207709a78f7ad75bea4043d3c50d7e9cfed5e9366280001fda8d9a84943780d8e3ef5a7ca214bc29008a1bccfe614b835fc982b6fb1fd1929e49f3521fc30246d0d73442232109c2538acb51b7abb546ec4fde48316b41d40f99114d9c7a647ef4cbd2215c2a8c2e16c00158467c119a875dbbebc86703f3510f39ab51bfdb1086b71ae41fb54c44595a7ebef484680000481814f52ca5b1c0a913cc1d987e382aba332540700d6c159c7dab423f15b2456413bee4e54474da81fdeb3b4939e2936bc7e696a86fd15909ea6bb315b271ed5eadd2076a58e34268c66c90315ba535a84915b8341b7c48899ba7be2b212726bc91d8d6e9ff5a09e464cf24714aa01ac251d852a94d02e3b91b34ca3935be07b57923ed5b6c350b7720267c8e7ef93dc80a44790bd8ae76e6abbbecd71f96a0d9c2ffaaa7ecafc80cbb19c0a201e1445405e1211377211ce72715d8531ebad8b2af739033b30ecc601e7766d5d44dc0ee59e451748b438b83eb25b092539c1ef4292604a2a252d2b1cf8a7dc53f87ee317de0bfc08c1a04e4d6595ac4a4a71c64673ed4ab2d91b871c1e7ed49050123923da9af2976a80c902a57b3b87ba5d164f9b654f019180738ef57a595cb6356d42195230471f5572db4f38da829a511f834410b56de1a6846449504818ce7b550b97c2c8e497c55b51d6165263ef6212750988326f5b63200292776df7a10956f535c819069d0b8ad6f17a4aca89ee4f9a6771bb36f8f4da4ab23b62b7c7c66c4a56a6eccd1ee0fd89a0b7a76fa8541047208ee3ef445a2fa85a9b49931ad32984959ddfcd6f7e08ec53f7a2cd27f0dfd5ad5ba63fdaab7599b543534a7d0db8f6d79c6c20aca928c648da0d557322bd0ae8dec194925249e403efc7e0d582bc6c9c351700445d63576f4df33a6b4875bfa7de8c4857e2ecb7d410d391e433b59049fadd7167b904e471c62ad4d63d5ee89d8ddd32845c34ecbba37704bdf310190b6a1b096d590e3894fea248e3b9ae167947792a5020f001c9ff00f159deace127380003c2738ed9c0c7f8cd38afd50f4546b7ac13013c72b760cfa2a7e25ba7fd43b940d07a57131d94c223ccbaaf6b68d9fabd2403cf2120761c9fdea91f8f3b65aedfacf4adc6df6f5c7f9cb3bac3993ca832e8c28a3c77382715cc76fbb5cad723e62df27d2742b295ede471814b5f6fd7cd4933f88dfae92ae52c8d9eac9754b504e4109049e07151e47a8abcac56a997b33389c6b517870633d320a5a92a5200fe6641271c54ba9dda42891c9e306893a57d2cb96b46832c3e596f7152965b2b577ec3039ab6a77c29854471cb7eaa91f303036bf0ca519c76c8c91fdaa96d5f99ea5a5411f12898f2b24273ce7b54937fcd460629ceb4e99eb1e9fcc31ef90541a247a529bc169d4fd88ff438a8980f28248f6e083e285b68f0ec4dd1f47b8e5f801c1deb1fc21b79828093bc0e29eb64280e7ef4f22272476ef50a93f99ad8013b105a03ce439051213ff0cf23dc7daa46cec9666cb82a5020282dac7949ee69c6aab63711e6e7b28050a1f51cf9a876e6aa25e614a428ec712a86acf818ef5326f7dc1df6449e8f6f8b35f5db1f400dce64b0b0a3fa57fd047ef8a73a618badcacaf69f8769dd261bcb4cd92b58ca824e1200cf14ca5bbf2f292e8e4e42d3ff00a93c8a92b6df215bb5abd2d414a62f2c7afe9a384fabdb03ef45a9d9d41dba12bdbe32fd9af1b1efa5695f200fbd5bda1ee497a0b67783f4d03f516d65c4aa721b29dc7724281edf9a91e9acd4bb00b6558520e39a5bc8a02863ee06d26e004b9edee0763b8a273b527b7e28c75d3df2d0adb011fa511d2158f7ef41365090c2769cfa8a483f8a27d632512669493c25284a73f8aa164821a756c61e4bb960f4a22a536fb9cb1c847d04fb9a00ea5b47f89af23fabfbd585d317d31b443eeee1ba43ea3fb6681358eeb95cd0948ddf5e0e3f340d76eac135b2b3a319e88b04f9aeed616504a09071da91d4b66ea75a63ade8485bec0ca8ec564a53f8156ef4874eb522e4e21c384a59c8e383c7356e68ad1f6e94ccc71e652b53c9285653c633e3da9ba5a0b02621c9d8e819f3ca4bdd509ceecb6aa4a49591828032af6c79a22b2fc3ff005b35890f5c91250daf1cbafed6b07ce076aecebf747ad0257cdc78612524a8a47fafe6a6b4f2cd8a32e3bd012f200c242b24a7f7a7b89915f90d895cccaad287c5bb9c41a8fa5da43a75a6f5740d4b619b73d4e86d09b2cd86b2234473ba83883fa81f7a7fd32e98a754d8126e1690cbee347714a3bf1e4574f6bdd0f68d5d393798f258825f51f51a795bd24fbe3deb3a6b4a3167023c57f7b8a237bada768c7daa4cbbd18fd300c3a6ef3facc8be87e849b6202dd70b7391d4558696a1b494d741b76f30d3e9019da01e45406988898a9429ddee2d3ffc45ab2afc510add75d925607d1c704d20b58131e9d8ea3cb2ba1b98da547233823f7a6baea202d97594648e47dcf8acb2e843fb800297bcc84cc82b413956322a346d19b0ac982563bbe988905efe22a099ab0a6d6b5b5bf82318fc571df553a4427eb272e82dee4f4b4e15b2f725242bec7f4f38e057544d6d6ca9c42518dc7c79a0ad536e99728fe9add5b60647d2714f29ce15a80445b7f1beeb796e7cfef884d3834edde0cf0bc3b253e92d1b7f4e2ab78d2d0ea014e414fbd74c7c4df4fca3451d4684bceaa1c8cad45592124e2b95e1a9290403d8d39c5c9f71498aefc2f061096c3b95292a07b1c5183410adc7c9c507e9c524bb93ef452d2ca95807bd097beda58f013c2ad49ab524fcd20807b8ff005aecaf876d12c5d188eeca610a0a01477d7185b5d5479285139e457757c2a6adb3dd5a6a22a4b6cbb1da3f42ce324525f51666551c731c6f984e3aaad84ceb2d19d34d1abb714cab1c694958c292e360fe706b8abe32ba79a7f41eb76dfd26d7cbc779943ce213c6c5f638c57645cf5222cf6ef55b95e9a76ff4b9b7c7dab887e27f5cc0bc5e1b8c97fd6716e14a95bf3f49ae4bc1727979d9698d6edbbee6831acaec6bddbafb082fa06f77398d36dc99f21c423fa54e1c55897dbf985647405f05046339c71558e874b6d343d2390304914f75c5c8b76f5b61c237706be9a5c2c7a30755a0f899c276f3d9905a55c5b976725640cb849f7c66aa2ebf5d3e62f688a97090950efef56ce95516e2392323700ae7ed5cebd5ab9aa6eac78727613fb555f031c2d9e5a11572d712fa060d47cbae04e3393562e93b0b8a6838a6f85762680b4dc7548b834da870aabb032a816c8cd303eac0ce2ac5b18e3dc00443edb657d1b8ea269a94e33b929e3dea06f9672da548740241ede68ce2cb970ad4b5ef515149e3f6a07bbcb9c5d529cdca2a391c5694f2ed63f8913d770a2a4f30656b7fb7a22beb1cee3cd0e804ab8f7c513eafdff339528ee032450d44056fa107fa943fd69858e6c1b1d41557c0772dbb42c5a747cb7b3b55e91c63ee9aad2124c8b8b6ead472b73920f826af1d3ba1266a7d34dc065dc29f01181f8a25b77c1bea2721226a25606724ff00f629ee27a573722b4c8f1fa49ff987d769da89d17f0ffa7f4e5a34745b861b53bb10a52c2bb1abcdc52255a03d1dc24638c77ed5c9d60e9ef53f4e59976fb53ee3ecb652768ef84f7ae89e904bba48b5b706f6dfa4e2461495f7a51eb7cda30abff4f4401c0fb4bb63bed17c655b7fd5ee69ed50f85720e40f26a48bae5ea12262c6c2be4678a1eeb39b4da3a951edeead3951de73d891cd4c5e2fd6e8505b5ef484a5091f4f600fb551f84cf1843dd23b9b27f71c86f8954f54f53dba0b0e40294a9e39fdab9d6e972425c7164602893c76a3bea85cdabb5f8ae2a83832413f6a1e916cb73f6e01d427d43c54f959af9769b1fa0628cda76e4240c74a1ffad03bf9af345c4f01469d26cb356e2db8ed1c24f03352168d27a8ae9391060db1c7df572109e78ff4a16cbd17a301ab16d0de4772320b12244bc11c7dea46e61e66329a6d24150a7f262ced397355aef36f5c5928092b6963ea467b67f6e7f151d7cbdc58e9c2900e46334bcb7b8df44b0d34278fd6dd1830dd99e95288741209c9a5eed68620a50a8e8f1cfe6a5acaa6ee3242dbce0fb51649d1889b0b734addc64f7a39724560078a2de3ded72b4f6256b1f6a160ac1144b6e585104781e6a2ae16b5c19a595a4e12702a76c9056b520e0638ef59bac162ed611c5d6f8f61a9be64a27d575a4a1470054a5b2d45c23e9073db34bc7d382e521052f7a61b1b88cf07152cdb1299495c68c5e2d029047bd02967b7dcb037176d8db7f8845a622a61ab1809563bf6a77a9242a7c6530b3b5238009e0fde806d9a8aeeab83bfc423a98083b473e2996abbfdc5f790cc7757b38ed47ab065f230aaaa38c0a95ea11e9db22ae328c1648214af06ba13a6dd3666dad32e293eca567cd503d2fbcc2812374c57f3164609f15d4da2afedce8ed867ea094e738a370402dd4b162e32db483a96559e2b31da436100148e2a79a610b20fda876dcfa9cc289edcd10c471448fc538f6bcbe641935f87c47cdc3491919a45c8a5b5671c53c61c29c1229c3de9ada2b5270315bfe9162b36b29919e90233de956594e0f1827b53572406d676ab8f6a51b983009cd7862299330622665b285fd3cf02a3d70dbefb69dbd2b9cf7150d3351438ee7a6e282147dcd4765095893d153b74047e965091da927c271c1a646ee1e482de483e6b64b8a74807340bf88f8850a994fd536c64d6e9ef8aca5047b56e13517ccd8b6e6ed8c6295a4d031834a0351b8d8903199039add23906b51dfb52891405aa7ed23336ad92924d60249a5100f140b2f477223364a0fda95426b080734ba53f6a5ce240c753c94d2c8466bc8467b0a5d08c507641d9e6812078ace052a1b27c0acecfbd0f212f3e517fb30cc74025b0079e2816ff00160c7b80584271bb273dbbd5c5a8521a84762002558e0d00b7a2e45db321e6ca8151fed5dc4d067273f891511506e694c64ad38c8fff00147b6ad0b667ade14b8c851579c0a8067440b72fd669b29239c54c439cfdbdbc65cc0f07b0a43cb63653d7bc76d3093e37b28dfdc1b827ac7a60cc66dd996f8e81c1fa427ed5465c99546b8bacadb29283835d3efea76d6ca98920907dfdaa80d7cc46fe3ee3ac207f30e78a878bcce45d7d8cd3d0fbcd332ac7fdd4c858ee7d3d8d3d8c14544806928111c7939427b77cd3c69463b8138ec69eaa9d7913154692d5209dbb558f1814f20da96b643a48cab8fb8a945c865e61236a4a8f078a77b52c45494900aabd6796c32fda4d5a13f33a0b447c62a343e861a72368d5c8bc41b72a0c194b9004664ed280e96fb9525249ee791dab98be65a53a010b5abb173b67bf8ffe63495c92a5a94e27c7b1e4d47a1f29202ce31cf1476472d66528a9874244f8e14ec4969ad92d85a424520d2b91935aa66a1d670a24e3814985152b6a7c52dbbb6ea6abf4c7ad1413c9a58250e388651f5294401fbd31536a090a1443a123265ea6b636a482152d9c83edbc546abf57708a3ea7ee747dcf5449e97c3b7d8f48d80c7f55a69fb93e94e56cee48c007c1f27da8ba15daeb3aca9d59a7ee7250b3f5282945c049efb924e2a3f554d871a74871f94c3443ae0dae2c614060639ee300d14749ef3a7ef36895633e921e093fcbe0023dc7bd39ae8abc37f79654a47b70534cf55e26b2bac8d0dd4bb3c33126650cb81ad894abb76f04fb8aa93ab7d299dd3ad42969b4a9cb6cacb915e3c601e761fb81560f50ac70ec5775cc7da57cb2b72ca929fa9247b1a27957fb7f593a353a021a448bee9b6fd55297ff00124c749c0747dd2700ff00de94725584d6bef36bf8ef1abdc139ad864e4020f029e470942c120f0734fd36a71094afd356095241c77c79fc522e465b6ae477a542bfc4446cfb45e430cceb6391dc4e7e92539fc556d39c7032b67600b6dcde0fb28558f15d09510ace01c502eaa86a87717120101efa87e2b7d4d41d88e97295260b3242b0a4824e7f15e54a0c45b75f0f26d320103dd048ef5136a93ea477185e700f03ed4e9a4ae55ba6465630a68a88c64652091c5108245603f10aba877e5ea386cb36680e3b0db6d2a3248da9dc47207bd4474f7745616a583f5a8f27ed52b1354893a4536c8b03d590b46093c0427b703de9ad91b544650ca918c12a57e696e731d18f3815d5dd4b7ac32038d3290ae720e2a7ef4b12672719e00273f8a15d31fa1b7303803153ccc853eea8afba97b07ed547ccd6cceb386a7db12e2d26c88da29a4e001f51fc9a0f6d95bd7452d58385123145deba60e938b18f0adb9e3ee287ec587a683b49515719fcd21662afd439a9daee5c1d25b7965e0e2bfa5a57f622ae4e9ec44087203801082471f9aafb43c54b31d4e81b37a0007c1f7ab6342466d7695adbeee2cf7a6d8cfe72abc857edecc5a4c18fdf60273919e6a1a4db9952941202547c81814592a11dbdc544488983c77a69b2a36223d83f302aeba52daf236b8b5ab077781cff006ad21d863b41288cdf6e0516bb6e43bfac7e6978d6e8cc10508e49f35a1b5bef30102f6233b5d996db5b969a71219f4bf48c63bd4d21a4a5ae0722a2a795294781f7a82cdfc99b27d46466ecac956696042938c7078a4d5b4139229546d29eddab4ac6cc3140104352b65977d64a7e8271c77cd40cab7fcd8ed80a4f7a33d451d2e4350039c1233426c4c5343d3747e93471f890f41a543d6dd291e774db50405b4161c86e3809ec1490540ff8af99d153e9a96851ec303f39ff00c1afaa5d689886343de49046d84e838f3f4915f2c64365b7dc56402547ff00bff14e78d66f120c559e002089396274b6e673e68b213992093e682ed8bda80aec68aed3f5241272689b90796e4d87692bdc244ad3f42d39e28d744eb5b9699968956e92b65606094f155b096a69c0839e4e0d4b437943002bf570315e4a6bc9535b8d893359e2db06740dc7e24f52c883fc3de7405ecda1c2a27231551ce7ee97fb8bb779b21c528927eafd22b6363953596d4946eca7f7a946a1bb6f84e34fe373839fb63b5095f0f898177b94a00d23390ce74c7a867a26e0cc76511c2c952c023db22b1ace5b8fa3d329fd6a02a034bc828706e5e36f15357643f31f414a73c55b99dd78d6663dc658fe1e3b115b7b7f256079d3c6107fd2b94f54cb32b51cd737124ba40cfb66ba8b564a55af49bdbf29250471f8ae4a96e87ae0fc839e5c2a19fcd28e3543206fbcaa722e7dd261369360a65b6f9c908f1572d9eeb19e28616ca54509f3550e939080a092466ac2b2a8a5d2f251938e3ef56dba9a8e279112b6994eb9215612dd751244c444662fd271922a16fd798ad2094b20ab69078e45367e5b8fc8f5ca0a704fed5171ed774d5d7845a2da8538e3abf4c6d149f0a8ac037b0fa563acabae256a53d98137f929972dc77667776a8fb04312ee8cb6842776f1fb735d71a67e096e776b5a27ddcc8694be302a3ee3f08376d1d7944984a75e607eb251e2ab791ebbe105e68461b86d1c1e53286317e9ec0971d50586020aca8103b78aeb7b0db26af4ba93247a643792a1f8aa2fa6fa31e91ade05a50d91e927711b6bb22658e2d9b4e2a1ba9402b6303239ddb6bb0f13ead5bb88409d90362351c78a8056f983dd2bd3f0665be4bb2d1bd6090164703ec69e37a1dd5487a4c751614851c049c6e154aa7aacf680d7922dd2a7293064a52e7a409201ab234975f6c7a86ebfc2db5a02b1df8181fdea81470b93ea2e49b90c86d83f68ce9adab1a1393fe2295727fabcd194da9bf960520f823b66986aab93874f219448fe6ed18c79e2aeff0089ad070a6a8eaf8890b7d29f07f5715cefa72c57bb9dc92bb92b0c0e02393c55ba8f4863dda4f1d6e46f458a7c84ae951d4d2dc329254b51272479a8490e84c80853a94a54b03938039ae8dbc681b72e26ff00971903920735426bfd20edb1d3250e7f290545409ee2927a83d0f9381579a38d418d2ca7c9a5ab1fa3b6f87a0ee5aa9abab8d3f0227cd80e35943a92704057be7b503683ea143d21a91e9170b43d2e33c92952632f638da80e14827b7ff7c502bfd49d4712c68d3ead4731c8084ed3194f650a19cf23f3e2a091ad11eb9416c9dca27724738c76ae75fe8f77992db935dc9e3d74f80d6e58bd71ea5b7d42d5a7518b52e0c58b09882ca1eda5d712d8c071653dd58aa92e1706aea7d1612491e7152f3fe6af1b165a5290460fd852060b76e09fe4147df3de8aae94c6e8fcc0a8b1f27fc4574e4976d6b05c614a4f15645bf55c44c54a06e413c609aaf1c929f452a19e39a9db6b6d4a85bd78e139e685cb4aec1b31d6023d6ff41d99293d9b6caf525385054ace39a4614c8ad2bd36943da982a3ee494364fda9bc4b6ce4bca594af1e38a86b5545e8c9b245c967905ee10b536e097bfdd5d573ec78c559ba075059adec98d75292b73bef0319aa9e1aa436e7d4149c7bd7ae52a547712e216527b8fb9ac327ba3a8c7133edc1fefda7607da1cebbbbda9992ebf6f69909503fd3e7ed42b6c966ea0a5e427fb540bab9d2d39754a249ec7b54959d0ec778295f4a7c815258a52bd0325c5e41b90c9f73402c916d26d7252ea01090706ba53a1fa9a14c6931f795280031baa8f5c3852ed21f2b485a46413ef517a1b584fd3f73ff00707b7b81478c819e6b6e372854fbb25b1c8c703f067d00b74967036e064628861c86b850583c5729696ea9eb19135097e010d0c655ef574daf52cb71942d4923290a38f7ab457c9e338266d91c5d96286fccb395726d9195280150d79d50dc564ab7e073e684ddbc4a907eb5109a637373e723142b2a201fdea3b398ad3a483d1c3a071ee09336ed5b1a7c8da970124f1f554e26f0d01824823c1ae1aebb6b5ea1688bb3736d0c3b1a1b6adc178385639a6ba47e34a72e1b70eff07738800175181c671ef5bd592f70f25817219dc6e2e47b371f19db771d61063ac30e484a16ae024919a8b54345cde4c8739da73f9ae744eb78fad63b572b549716b0428edeff008abf3a7f2e44fb634b7d2b4a92800858c1a5b6e458cfe2d1b22d2b5fb9490442c8cc869296c018a91680ef8f14d8252369c8f6a72d9013835bac5f6379f7171c9c56c91f7ad0119c60f6a5508fbf6adc1831ea653e2964815aa40c56e8e07e6b57ee42d3609f6ad929ac2696401ed43309131d4f212696437594a47b52cda281b57ed07679aa11c8a709456528fb52a94d2ab46a0eef32da29648fb57900528063c52f7220aef3211c66bdb456e9ed5b63f350132124cf9b126d4996007120a6964db9a8ec96d96b6a6a57614a40029abcb2158cd77c20ce5d222434d83b4b79fb9a86b842414150481ed448e3614738a8eb93410c13c561957c7e2609d4acf55030d953a39c249c0154b6a39264dc43846339ab875e4828416d07255918aaaaf96c2d30894e270a2714a2e401b604d0b6c4676695e9809d99dc7c52b315893838cf14cadab0d3adfb679a5a795392d4eb790950c735303b50208e429dc59b2b493b054c7a84db92951cab3dcd404652d27249c66a5db5fa9141fbf15ab1d7537aedea6aca10f494344646467352976d39119b7179284efc6720d4330bdb272735293662dc8c50144823b1353e304d1dcc58e77046371216c63b1a9a661a520383924547b9156874ba0706a5187d2869393e2a375d3481db530f36701200353da0d2636a7b5b8b000129a3cffeb1508cc963792a34e5bba08b2da94c1ff82e25c4fec73ff6ad1ba5ea6f4390e25bba8d4ad5fa99d8f7157a4cc65becafc02e870e01fb118a7bd1f173b76a96185ad636aca40dc54929cf8a7d6282993ad5f94a652a897569371420f2924a003fe7347960b2c2877d665371d2800f240db819a6b8b506abc89ee5be962e8043bd69a0cdf6d24905c2b689001fa8122a9ed0702e9a1b51c6bb3009f915a9b92de321f60f0b6ce7c1eff9ae9555fedf22da170c80fc7641295004fda8363b767bc439b7563d27263ce00eb286f840cffde85728db578e110bd454cacf56e8762cb76b934c7ffb34c49976f07ca090ada3ee12540fdc5567774211909038c83f635d8fa9edba72e1f0fd7a71c88d22f16c6d122dd28925c504fd4b6c7f722b8aee17044d1eb367859c9c7be3bd2974d1ea52b32bf6ed2048d5b8948c6ec64e2867584d8f296da9b1971b0127f1534f8dfbfeaf7c50e3f2ed3bd697dc05693ede7da863a064687f32012eae33a0a4e01e4d4a5aa4a9a96d170e50ea82543c104d44cedaf3bb9927693e3da9dc77f6a9a2950496d4082a1ec6a5533361dc29d1b7fb85aecd70b34562dee3897cb65262a9c7f04ff49ec07df3fb548c56de710d07414bab5720f1cf8a88d3d74bbd9eed744d95953aa9690bf48019edc9c9ed469628522408f327270e29cca8286704734ab9070a0cb0703596b61869c49416d8239036fef8a21b7432bb9b7192384bbea1cd4069857cc4f4e79d8b5138f6ab2349597e76738f805413e6a899b60d933ace0a6ab1b92d7d9db62b2c05e3091814e744415cb9ed90063207ef9a88bfc651b988c956768fdaac8e96d87794c85a1490820f23be292821da1d690a92d48ed356ab6b2d34afa5b46493dfb73471a1ae0b8d6b6544f0a5122abbbcbca532509c80afa003fda8c2c254d456182084b6807f7a6d88be27b95bcd4168963a25892904a473c52522115720015176b97b401bbb54eb3210ea70aef4e534d2b96d7e064718647b52263ac28f038a9f432850ed4d6e0188ad1796a480904d6cd48f9831277a8d19da9012b5015157c7198cac2140a943b7bd33b85ed49f556d11b5009a1f76e6e5ddc2f124147d23141de40109a6bee4a075b738561271c66956569ed826a1e4c86a0b224cb7021b4292852cf604f6153309052a093f565215c7b1a82a68532e84467301f41006783c503de2c8fc3754f03c2f9c7b55bb174e22433f35eaa529ee46686352c76196d4d294140679fb51ea09d40cfcce66ebecb5b3d3dbc94920aa2afbfdf35f372ed1d4995c8c7fe46735f437e27a7371b433ac36482fbadb58f704f3fe2b84b53424a662ca53f4a8714fb097c06e05995f92ee41b076b6909f079a27b0be07d04f7ed5031d851c2427edcd49c34299793b4f231c54f7762438db1d185c9b689090ac807be4d4be9bb4b8f4f65b7ca94d8f2077a63677fd729697c903b518592288d21b7fd4200ee2b4c57f168532efb12ccd396f8d190946d4a8848c653cd69a9ed71e4c6cb4c02e03939e29edb9f8eb8c8702d20ed07293cd47df6e41b61450b3c03cfbd4b90ad6386105b34207dbd2f2ae220328fad47000ab9ed5d26bec9b4b574315cc103dea8dd27356e6b66dfc95a378c81f9aef0b26ae850349868329282c0c6ec707154af567a8f338b5af1aaffc8c6bc729b50b7da714f5c966d3a75f8cb24293b9247df15ca0a2b2b39f1ff9cd74c7c4c5d04a7a4252afa5d78a8015ce0e344fe94f26afdc3966c642ff003a955e49c35c40923a7df287c14a88c900e6addd377280c2506639f494e38c77aaab4e5b96ebc9053ce45115fad92d98e85345680078abb622d575652c955bf69702b2c4be5e34eb3117f2ee212b58e0e455aff069a72d77fd58b9efa12e143a79ee0571d4854a3c38eab8ed93e6ae9f860eb031d38d54da673fe9c7797bb72bb77aa77accd94f0f6d1840827f12d1c4ff00732d5ec3d4faeccd9da6a065b424a1b4f09c76e2837593308417829007079fbe29b694eb3e9dd43634ca89738ea0b6d39c2c50f6b6d636b7a1484b32db5f05580a072715f15fb594dc82d40303e5a27fde742c2aec16eecfdbf6809d206d33facef36df023b4491e7bf15d1fd4663d283f58070d123fb572f7c2ddf2dcbeab5ddfba3812e49490d927b60f02bad3a8a88d7286151cfa9b592703cf15f70fa2f00e3635555c0e8ac0f3dfc335140eb5381f54b0cea2d7ed82e381b6c25b70f7ec706ae58da034eda20a1e8ac36999b9b525e07078c1e6b9ce63b731ac66b76d75d4acc8712a015db0aab0cea8bf4086d4512d6894e252e92efd47691c575ce27031f1078563e4c698811988224cf57ba865bb6ff02437eb14272a715d86076aa7f486b461d9cb4baa465b1bb6fefe2ad89da29cd43a4e54b7e425c99250a2dab6f63835c8f7137bd237f91166050f4944295f8343fa8336de1359148da88af942f8cde5f6970eb3ea536c34e210bd89c76dd5cdbd46d7afdd5f534cbaaf4f3cf35aeaad532672dcdee709fbf7aae66ba643ca255f7ae7991c96772f7fbf6b697f12a3c9f39bfa2bf99a3f21e71c2e29c38a28d35694dc5a1bb959f2284b0a52d2829e07390451c6889a9892db6d6a185118fef40e7b1aea3edc4f804d96eed3d196758b4e310edd8909c9033fb50aeaf6c38e96da47d2907b0a3e5bc4c5dc15f4ed0491ed4ded966b65e1d5152d3c9c2b71c715cbdb2eefd41f70fde754c6c64b31c257d6fef2a369878652addb714d9cbecb80f08a9715b68f358c4816857a31ca7255818aadef711c49f5ca4a4afb7e2acf85e192002257338e4e236ab6ec42cb3ea764b8932540247268aa2ea18729f4b7192923154e4395b5610e1c8ed53ccdc9709af5239215e0f8a22de355bf6cdb17d4b60005a372c4977b8024a583b42d5ede2a79ad3465b0994f72829c83e2a918975751344c9077ac1cf278a3373ac4a8b66fe171a304b9904b8579e3da863c7b276b1a6273f8b90c4646b52724bccc6bba2dcd9490ae33ed4f1e83214425af342da06ed6fb9dc1cb8dea5b6da5273951e49fb5486a1d7b6d8afadb88b0bdb94a543818a82fc7771a03b8c316dc3a94de1b40498bbdfd165b6fc8956e795c6d1dce688fa4fd26bddf1e6afcb1b10e1dd8524918cd53f6976e9adf53c36196d454569c04f391915f423a7ba7d564d2d0a2b8de1c43682ae282ba838c9dfccb1f0b96394b7dcd7d0bf1fcc4f4fe918f02221b5b692a09033b79a2962180923ed814a8471c715ba1652403505570d68cb7596b38d09e4b0903eac6296430c84e4a476a45c700f349b92d284e37d4cba27a83f8b1d68caebaf36eb14bd0f3bf8bb2de1285142881949da6be6db8e351e53a1a236a1c50ede37715d8df183ae971ecb1ecb164a90b95f5389edc76ae2b75e0493804e307fbd5af8b1f4f7393ff0050b2e872b5afee1f7975f46ba90c695bab267384c4253bb72b001cf8afa0bd3fd4563d4b6a66e365752e36a4004839c1039af949064a43696c1fa71db15d71f083d49442f98d3f7198108dc54d851fed5be7e38d79a8907a439e767fd2587a9da0b9080e25a18dc71da9f32091c8ef4356096ddda71710b4ad0838c83c5182190afd38e050483e912ff73043a9a003b8f6a511e6b211838ad8276d6c46a0de5364d6e919c56a80734b252335a9f890b1d4f250a3c52eda48efef58481ed4ba119a12c6d41dda6c8c7b538691da934a69c3692314158ddee0aed374a7c52c9462b46f9576a7484669759a3b833bcd10919ed4aedfb56e96eb7f4cfb52e758333f73448159c0add29f15bedfcd0e56685a7ced75784f38e6a2a43a90b3935bce961b4e7776a875bca90bca55c66bbfd8be339803b92697118c9e4545dcd7b8103b52c5c5368e4e699cb702d1926a076004dc2ec4af354dae44998463213f5038e281b555b9c4403bd3fa0f9ab5eed2d237fd20f81411aa83526def0d83239ef4b2c3e5232a44a9ed6dfa9312d8c707cd192b4548542371f506d4a3d429cf8a1eb0c3dd7252b0308576346170b8ce4c2f9365c094148492478f3fb5138f6d6834df301bc6c75032432182401e69ec300c2093c119ac4ab55dde712e2edf21b6578daf29a3b0e7efdaa49ab548b7c648969c6f4950e076a8ed07b6d7535a581e87cc826d43d75127b77a72e12519c1c5376909f9d50f04f6a347f4ea17664ca424021255fe2b5c752dd88430fcc0e572838cf6f34ccbe7380a38e7c5481da0ab3903918a61f28af454be3824d6cff49ee69edf9fc44db7805e48ce69f3252a5a7090467b78a8a8e8756f7047daad8e8ae95b66a2d42ddb2ecb486df4e52a576cfb549454f73844fbcd0815f72d7e89bf1ef1a6adafadc43922da830dece372539c81564bec2a390e3280719ed4213b4cd83a61758b22c529e102e6b52149717fad6382a08206003e68e2d6fa6480db8a4a92b036abc107da98595361b7b4e7b961c0c926bdfda6b648cf5c75559d0e4a75969cdec484a07eb4ab807f23345765d1ac59e5cab9194a68a5cf45c464ec58cf7a56c71598af21e4a52148255923b0c5466baea2c4b4c9720d8945c90ac38b0b4829493c0f3df34b2e624ee5b38fb1affa124cf546f0987d34bec7d38da02e2c60f60e30a4ad450b03f622b809bbd2a2baa8ae029082538cfe7fee6bad7505fae9a87a5faca55c4067d2b721a42d09c6e2a77b8c570ecf79c6ae2e0dc414a8a7be73f7a5d6bf7a95ce6f18d366dbe61b459c87492a57639fcd34bad8ed57325f4214d3b8ee9579f7a1d8d3df0120b9c66a423dc5609dea2454406cc45dc646d2ec1486d6e7a9b4939fb57bd01fa8d3e95250b4838e6a383ca52c8c8c1adce84ca8f292edc977e7d97a32cb6eec082a49c13f6aba6c504c8b032e8c7aa82e05907b902a96b323d4525d51480da812a3e00abc341a932f45cd5b2e85bac48709201eca4e47fa522e50e94cb7fa740f7b51f74fd94a9f5b8467ff00ad5f1d32b405599530e32b52bfb551bd2e6fd72ee492a07691f719cd749e878c21e9e61a18cab24e3f35cfb907eb53a8633055025761b54ed56b8a805452a2950f6e6ba074b5b1a81012842402509aa5fa736f175d7d7475c3811895f3f9e2afab7601d98c76fed42630dea6736ddaf51b3ccfcedc18880775057e003e68ca0b5b1239e0600143fa6a32a54e95705a308fd2d6ef6ce0d153481bb09a709d095ebaddc7d1cb891948001a7f1e5adb2371f34c5b2a08e48ed5b257819f6a26bb18459628632711764b632a5540dd6e4bb9491110b3e9abb7e6b2e381493ef8f14b592df957aee9ca93950e28bf70b0823a0dee61db285415b18054e2703fb55756f90e5a2e2edba700952564e15c022adb91202391ed50975b2d9af831728895ab180b49daa1fbd0ce9e424d45810f701b55eaab6dbadca90e5b9ab8b4c7d4a8ea38dc4739fda8695d60b633152fc475d712139296d0a57a7ff49e3c5584e74ef4da372db65e24f70b7370ff0035a0b644b246532c466d0cabba762403f73c562baa4ed7a982ba73aa0fea0614a8d295b5270413b48fda95bc6a353ed8683bea28f071e2862fd11f44c764db2dc9612a51dcb6900155230d8792d7acfe41f3ef47560c0ee23e44a43e279d5bf02d70812a0e4852c81ec94f19fdeb95354db4a929da015679c7b5748f5e6f4999d418b690e27fdc630f511e0295e6a8bd6b1dc8d706d5b76079016907ce4e29ed3b0924f64595791814bb684406a427236ab0afcf8ad5b69c8cb0f06f70f7344f0e16fb74a4046f0b054907c1c535896f5bd1021640520124ff00a56ce7620694ea3880c3cf2512a00cb807d49a2285a862c5298f71525a70f1851c546d8e1aa3cc4a54e04e71b79ee6a7352e946ef1092b7e2a50e019f547231f7a829ffb826f6a1542442485778896d25b97b8293c7a6bc9fdbef5e997288e31fcd9b25b07ff00de359cfef54b3f1e44073d24cd52109384942b6d4bc1ba3cec6f41c9ab700f2544ff00de9d0ac68195f7b9b6419646939b6e4df1b53002ca563ea3f9ae917f52b26c6961a7060b6323ef8ae5ae9ed9664dbc21d8e16a4e41edc1e6af092c4885094b7814ed4763f8aa5f3bc7d3c86756ae7e23bc1bcd38a4ce77ebb4d54dba222a0ff593c7e6ab98d637deda362b9ec7147fad1e6a7eab5a960290de7bfbd6d1e447494b494209c718ae958584b550a7f8944cdcdfacebe623a5ac288890e388e71dcd4fcf86d4a865a5a73e2b464e10083de9f3652b676a81cfe28caecf6cf5005facf919515fecf29992e16da51403f48150663c86f0d10b49ce473daaf35d885c406da677a967818ab1fa7df0f0c5f9a171b945d88046728f1e697733c8e261631baf6d08e78ca6ec8b425627355935beb5b104c7b66a09aca49036ef3b6ba9ba4173bc5c2c4f49ba4d79f75c4614a5a8f391f7a3677e17b483b1c2e3b69f5129ce360c8fbd36bae9f8fa2ecce448c950d8a00718ed5cd78fe5781e5b915a92a05b7f89d178bc1cac7bd5ac3b58ae8196ab46bb657100696a230afbe6bb72d125fba587d592379f4c0e3cf15c0fa667309d40c4c75c4b6138ca9671ce6bb5f43ea9b6a74db456fa482d02140f1c0afa3d301130d2da57bea35e42b16d8c5076089c6a5c8f66ea1dd17706c86db98e678e0655e3de8e60c38dad757a24468c446662b4d05630329ef485d6db61bdf515c8c5d4e5c92a51e3209ce6ba32d9a32c565b535292c34821b19294819e29ee3e5ae3543dc5ecfc4f639f64f911f339eb5eced45a4e63b67b132b7129402807b007bd72b756ef452d3aa98da0cc90b2a74903208aeb1eb0dc27c6912eff006b8e9742105180afe9ae02ea2ea07ef37b972944a7728e139edcd2df55dc8d862bb3e62bf5464ad78fa3f303ae97071e70b64e09cf6a49b84bf92f5dc4f24d6d12309b29390724d495db119a6e2038cd73857158d0f89cc0a7b8de44446cda5e6df1a5ad8094edec48c52719b9366b9258789dedba13f9c1ab6ba6d67697680e2d00a95d8e683ba9166760ddfe60206d539bb2284c8716a958e5703dba85cb2c8b5dd9a7b4e0714a4ee52718f3daa1e04871a78a83870324e0e2856c571598c182e1c63b5494c9c2046f5964e08ae7f978212f3fccb861721ba940fb48dbbcb7ae5734b6564212ac1069c6abb23a2cc898120fa69cf07ed4369bec44cddca1939cf1462a9abbada16d3442804f6cfda8d5f2c6f1f1f89e365595e4ac7b954a141c788ce08352a8716a6437df152cd5a63b6eadc798039a24b5d82db2990b2903cd3fa6ef7144a6e5629c763b95d4c2e363e949e6a2dd428a8a95ee01ab26f965868696a8c90421273fda85b4f59a3de2f2d427c9c2d58c0f3cd4c596b058c1a8adb2dc569f790b1e53c8425b6b7f39ce29fc16275de4a21c7696b5af81dcf35d0164e9459ade8dce43df948c7d39e4fe68f348f46a04598d5d9508349490b194fb1cd23c8e76aac1d2cbf617a232dfc4b39d1f9127be1d3a2d0b4ec162f974612b92b008dc8e527bf9ae8c46d4a004a47031519636196aded21829d891c63f15268048c62aa991c835edb26754c3c0ab8fa45358f89ba371f148c856ced5abf3111d395a80fb13de87eff7f4c46c3a80307be0d4959f35fa7e618abe3f537c4909b72663a32eb9b7ede6847506bfb65b18797eb0fa10a25457ec2a1756ea344a846434efd691838ae54ea86bf9cc3cf5ada9055ea950273e2ac1c5e11b0ede54fd47ea31c7278d7053addafe46b6d4cebfea294db07d26f2afbd57edd9274960bacb59cf2739a751597274f4a14ac9715cd5bb64d3a866d841693c367bf938ab2d6053d4e436addce641b5cca5e0b2ea1f536b2014771467a3751bda7eecdce616a410520907ef4397c6ff0087df2420800127b561b77090527bf34680968d3fc458c7fd3aff00243d89f437a4bd4f43ba79b90d6d756be49cf6e2ae2d2bab265dd5b56ce07b8ae09f87dbedca44bfe0aca96ae410073e6bb93a6b6d991e28765a46ee383de80befaa96f6d5675ce17232b3f185cc478cb2994952415773cd29b72700565848d8938a592804f6a5ecfdc35980266896e954a6b64a2944a2b52c35dc859e61005386d22b54b47ed4bb69c505630d41dde6c847229c349cd6ada3245386938340d846a09634d90d8cd38423deb54a69540340bc15da6e94d6fb33dab09a5120d0cda3072d301bc567656dfb56707daa02a26a5a7cbabe5c5869b20a8739ed51312e692d28e4607f7a09bbea96e74a01a3b13db19a598bb34dc6ff008809efdebb865652eb42737a9762153975233fdc734c655e06cda55cfda84e7ea66d9041db83df9a8a5de0b8b0b4a8149e4734a2db881bdc27c401b847326a5e4abf9833cd08dea6fa6d3c92490a069e19ec9472b0147ef513736d331a525a5824f1de855cc1bd182bbec403f524332dc5b4e2d214acf152512eee3721953ea2a425c495eee4633cd369d064b0f2b724ed15ab6cab6ef38e39c51b4daa5c583ed16d9b6ea7625dfa97d349fd21976db4488b3a5c98488d12134ce151dddc373ab240e00cf6cd733dc2eafcfb938c3c52131d212004d696cbe2adb6d530da54568ca52700771cfe691d3b66bbeaaba3ff002082b77f52c1e00fcd35cae42ccd029550089ae3d6292493225a413752df827bd5a51903fd9ee49203678fda80ef565b9e99ba88b748c1a78a52e839e0b67b287d8f6fcd15c2bb34ab3a1b52892a1c015163d4f5ed5fe614cc0980b2a3ad4fb800c00a34b18de9422081df9a9353685bae600393c0a6172928690a69480927b50b70faa4b51f11dc858db597d240c609ee28bacb3d70fd09711c5b2ea3942924820d0c458ff32b6c762a38ed9ae8fe8ffc29de3a8da586a646a2876f65d290c7d05c52c1ec48192904f1934d78ca2dbcf8d5f3f300c9c84ab7e502276a4ba5f90895739f2253a9dc12e2dcc9483d80f6ab03a61d4142a437a76eaf9055811d6a579ff949355a4cb24fd397bb9e9bb8a92655ae63911f29f2a42b1e3ee45445ec18cfb611b838394a907041a4fcae5d95649169ee5cb88a172b141513b4665ea45bad5324c5614f388648421032a276f18a00fe0129b8ed5d2e21cf9975477059e49ce467f1559e82f882b869e8bfc2f554676e4c2701b792adaeb607b0f3566c8f88ae91dc2de8917272eb35c6c9508ca486f69c719503c8a88e72ebca37c2c83c65bb7127de40d3bd2dbfdd2e91cae3bcca13b163e9f492090ae7dd5dab81e72d72273d2f03f9aa2a00761f578fdaba0faddf136f6bdd349d19a6ad68b6db4ed4bf85ee2b4a4f09fc573eedca8ab3c6e381ff004e293a58ef6963f100e6325735bc84d9a510066940fed56335a2b000e299bc4a57c1346acaebaf898f244c2404a49a458904b8524fef4cca94acfbd2d1127d4055c83c565b5aee68bbdf509a24b4310e414aca54a41da47838abafe1fdf44fb3ea3b63f23d77da6da7c0078c0e0d502b560068e024f7fc55b1f0c9352df50ddb494e05d2038c819eeb1c8269472401a89961e12df6b246e59dd306d71aecb6d49c7f3d4083f735d27601b2c5ebf601453f8c550567b73d6dbccb90a491e93a4e07b03cd5ed639adb96c762b6a0a4e03a9fbf15cd3388dea75ac4db203213a2d1d723526a778672db8118f3c9ab827bea8ccfa2d1c3aeed4271ec7835557441f6e2eaed596f51c29d2dc9413ed9ed570dae0a2e772331d49f4e3f0de7deb5c4f9104e40903a93d6868c280d453ffc340e7dc9a938e73e69b3682e771da9e4764279a6c14caf9623e62dbd5c015b8571826b4c0aca5292ac5495c8898b36d6704549c75969bc24638e69824ecc6ded9addc981ac64f7f6a254efe20ce418f1d4a5d1824e69abb1949e478a68abbb0c92b79f4213eea38151771ea4696b502254f6dc50fe968926a5092108e4f424d85a9270a381f7a8fbc80f3001008f6cd57d79ebd5a18caadb67f4c73fcc75ce4fdf19a09b8fc42cd7dc2c869808cf748add6b24e849bf4edf27a96c4d811c5b16a4246ee70078a0a9eb6d9506493b947155c5efaf5767637cb30a69b055fa81038a84b0eb2bdea4bcb3979c71a41fadc48ca073ef4c71f8f66fa8cc595051bdca27a81797277583504b7d60a532bd11c7f4a78c540f52a3aca59901392cab69fb248e3f6a79aa12899acee92d2e0517a5be0e3b139e292d42b13a06e753953ad86d5ffa879a38129f4c394f955a90f63485432b38c14903f359b0464fcc3d11e483eb20ecfcd6d6c61c6ede8084fe9ce697889cbed3bc85058c63f35827c86848d542c9272c01f8e953636383b78e454be8dbb38f386d529095290ada92e1e2a65988d0861c072481433a6d842751b8e2d20824e013e6a2ad4abf721bf456106a9e9b69f9f14be56d4290f6487168dc8ff15582b484db23cea16e30f321594b8d9c050ab8f555e98b75a0a9edaa4a47093d80c5552f6a9b1dc16409ad4739c1dddaac150da6e55af015e5d5d0616c8923d4b825bcede02bb8fbd14f59353d82db09c319690ac78fc550166d631ac292b66f0d3be4142b9fc50c751ba84f5e994a12fa97b8f3cd53ece16f6e53f564fd23ed18b65d6b85e3f790b7ab999976912db58c2d47b5338f745b12c2f793503f3ca57638a6ab96e25cdd9cf35794cc3a087e2521a9f75cb4b6adf796dc61216a4e71e2a5a2dc5a5f6555451af25b40c0c1c63bd3db7ea55b323d371d241a996cf2ea4898fa97f68c9b0dabab5f31828e339ae9ab0eb9d336ab12580eb485edfd3bb926b85ec9a896ec96d292a057d88551aaee57109320bcb25206d009aadfa93854e6691513a31ff159430df644ed6d3921c9d6c76734bdc87178ce7c1f1407aea3fcf38e4348fa94ae39aaf7a69d76f9689fc1645b9e0523856d51248a38b43f71d7dac98b7e9f82a9aeba9de50df84e7049f6ae75e90f4d64d3ea65a994f80fbff1f99d438acda2e405c8ff00f69ccfd6e95a9741ae1488f25686df71691827ba698e87f892d72d44105fbcb81a03091bf802adff008ece9dea5d35a42c932efa7a4c169990e36b7d6014296b04a5208279e3ff00cd70b3731e84e1014afa7be0fbd7d21ce6764e12fb3856fd3f912b1cf678c3cef7e87da11f69d5dd1fea3ddae3d628ff0035705bad3a54ae559faababbe20baa1acf4ae88b6bda518f51c7c04baac92529f2715f3a3a1b7675fea15b96a5a907d4c67f715f4a750b301fe9ff00ab29b4bea443251e79da7deac3c164599d803f5076cb1ff08ebc8e33393d8ee51307a88eaf41dc6f17d74bce32c2be951fd4a20f61e6b8db514a4ca9521d28016b5ad6769e3939145dabb53dd15266db16f38d476de5a4349ec79f355fbdb9c74927393e6907a83975cdd54076bd4a2fa9393179f675d892fa4e0890e87144fd03348de415dd4b7dc0e39a9ed1f1c222ad5b79ce2a22484b9a8361e72aff00bd55ac88ab4dacbaba7f1bd3b432909e7683515d54b5fa96d2f2519283b89a9cd28fb7120b695292004015b6a94b570b6be8da15c1f3f6a08fccb42a0fd281299b43855b5484f20e314f2f65c9d152ca41ca7bd35b734e42bb3b1949c0c9c66a4a429c8b2bd508051c6ecd2ec9c70ff56a054d850151035db614b856411e3b514e9479e6406520a93d95f8adb5036cbd6f0f44090e60920546d866bf033ea9fd5c62837abdd4d6bb126c5b462ddee3192b79616b69d537c77a75a6ee2d46650dba9c93fe298cdb8ee8e420e493e292b75bee8b6d32dadaa6f3cd158b51a868c1394beabc9287e64b6aab9c54c0532c8092b073ee78a69d12811ee1ad63890a096c28139f6cd272ecf36e482823040ef4d6cc5ed1f736e632acaf23ce3cd4d6a79a91fc45fc6de30f212d6fb19f42e2e94b15cad6d7c9c642b63606e03c814e5bb62d368723a91852014818f18aa37a75f11b698f15ab75c10946082a595d5b2d75a74439190f372c28a87e9400a24ff7ae6b9f8b914b9041d19f42713c9d1968ac8c37af8921a3af919085daa6c80d4969cc042cf2a04f7146ad292a4e50a06b92fa9bad6e7a86f9155a122bf165a1c23d6d846e1f7ab2b4c6add7768b436752b0ac6d490eafcd138582d681fcc2eecea99c81f6960eb34bca86a7982414649e6aa44eb36a44876db317850ca4051a3f7b5945ba5bfd37804ee072479ae6deab5d5ad3f703708eb485927001ef4daae2f229b3af88bb3f97c6140607e210751755274fdb9fd8ea42dc492819f38e2b972fb7576e939725f5ee5951a96d4daaae7a8e495cc7d450301033da85dd18511dce79c55b70a96ac7d538e7a83945ceb7c6bf8845a0ad62e178485209093dff007abddab6066116928c8091deab0e9b34dc501f56dc9c77ab6a25c63bb94ab009031cd62f24b461c0d4a89b339efaa16e112e85dd853b8d0edbf6b8064e78ab33ad315a5fa6f3691df9355b4264b4d17120e08ef45d0da00195fe6a91ef92a3e6743fc26cb891fa828872190a0f0090719c57d0c836d4b5b1f67805230057cfaf845851a6ebe616a00a90ae4935f4861c4f4da4a30308007f8a0b3805b7ca742f4d5de1c6281168cd94a02558cd2e96f07b8af240dd923f14a80734b8bf7b8c19c93b984a2944a7fc56e9452886f0735a336c4819a6a949e296427b715ba1bcf8a5db6b24714236e0cefa9e6d34bb68e738add0c9fb52c86e85b20ad64d528e294423deb74b7814a21ba0ec83979aa5b3f6adc248ef4a2538adc2335078ee425e2212335be0529b2b3e99fb56190cd0b89f0506a0295a547c77a5ff00da8dc9294af181530d748354bbcaa1a853b63a337a49dce34b19ef9aeb878cc9f96065142ebe203cbbcbd21c214ae0d65bbb4800241c0038a3a1d25b8efd8b64803de9ea3a4ee21aca9b008f7351af17693f50ea675b95e2eeaf8482aad5178788212483e3d8d4b6abd34eda161b4a73c13c1c8a8d811bd74252b4f3f8a1ecc3149ec486c2a26ab94a9ed94ad2770e2b7b6b08f9a4b0f9052a2327d854e46b6b505953ce3238e4e6855db9aff8a29d686d0858c7f7acd16225a07da2eb7b3d43cd61a661d92c30dc6d6152a43c4ad0939c378ee7db349f4ff550d3135d93e936ea1fc25c42ce38a889fa9d371b59b721909538101c709c92527231510d210d23255ce7cd3dcbb943ad940838961eb3be46d65295759a18438194b2db6df64252381fb1e692b1e9e9126cea90392d0205002ca8ff00c370f27c1e2ad9e9ddce2fc918b2482820642b9cfed44609fd5dc45875b91bb7b5def7016d966bd4abd2a1c6812a4b8b5e12db4d95289cf81dcfed4496ee88753357dcddb6c1d31219799485ad12c7a2424f9fab19aed3e9cea5e8ae88b60d49739566662b50c853eb5a4bc5e2384a71f50e7ed42bd48f8c3e95daafd06169fb6b9a8a1b3094264964805c754b05090a5104803839c536ff00a7f12bbbcef6ea46bc95ae0aa8952db7e13d9b769f9970b85ea4b5778719e92e320619425b4939513d812303df3519a37e27b5874bb4eb560b0336f79684a5719525adea89f4f604637e3b8cf63431d4cf893ea16bebb6a1760dc1eb55a6f071fc39a525410c8007a6a577502903f049aa99892f49772e249fe903b70338fcf8ac6667e1e0af8627cccd38d664b6ae969e9f725dfa4bb729cefaf2e7485bef39e56b59ca967f3e7f1507a95c41bc486d27686f0919f7a30d236e106d1f38e24a4b6c2801e794d00dc5c57cc487547953873e6b977236b64da5cfcceafc452b898aa9a8c2603e9e47271dea12428e769ec3bf1ffd6a7dc4ef401df35173a311c84e3de8647d744cdf329f714903b914b4823031deb403c7b53966238f3e1a40c9576a7ae5924b6065be4fb1a24582568e1dae7e244b80eded4d17851efcd4f2ed2f16fd5092523b9f6a445a1e59c210559ff9466a4fd4aa091b62b13ad48409c1276f6a7b6e6f7a892081e0914f1bd397075dd823b8d9278de08a27b6e934b6f438935ed897080b23b8c9a86dcf555dcf55c7d963eb5079b88e4d790c30cfa8b571b4558fd3ab25cf496a1b66a6014cbb11f4b8723ba320915d11d3fe89694b5599173850d2f1537ea38f389dc78ef8cd6f3b4421f8267b2d0421e5290841473b4773559cbe7aa606b32d981c0bd445a64aaedadaef52d4de0b3392990d2bd8293ca4fdf3449a3a529a656d485e0367d03ffa3c545da5978db21baf02a5a0140c8e463b5386ff00dd5f5e060384707be6a959972bb6c4bce2b1450a6276fb92f4af51db9a8290c4e4165c23c83c0ae9bb0466e3c1410412e8de47b719ae66bf5b157261a7da6c9763fd591deaf2e98ea837dd368f992132231f4dc07b94818a930dbea1b83f22094d8876809fe9f34e9b4109e69843790a5649e335281c6f67069fefa959d93f3133c579070a26b55ac0f7acb4a04e4561184c37c455d74368055e68075df502369c8eb740debe43694e72b57803f7a31984ba76648cf1c50dddb42337a43a994d85a5cfd240e51f7144d3dc81546fb9cef7eeaef506f37345a6d9629413296b4341482ade40f14f2d5a5b512dc5275d45bd41717f520458c5608efce3b51e5cb46de6c33199715c793e9ab732b49c96c8f6e28b21f50ba833a5c696e2a0ca7a224a50bf96d8a000e3201c13f7a67585024ac6c03c6a1ffbc1ed31a5fa70961c5cdb65ea44b680fe5cc88a0afb118c8a9b9163d3eb656887a064a370dc87243294a703c9f3fe29d4dea36ae861c5c8d2280e2fb14ba4fe4e7ef42f73eaceb5b884466ad316306ce0a96b2b563f1597e86c45ed8b9ce7bdff00f328dea4dbe77fb70d5b242212223437b4db4c048fbe543bd19d9576eb3e89b9dd598cdc74c261c5385290324038ff0034adc74c3d35d55fae4f87dd5671c6319ee2ab6eac6ab76d1d3ebad8e180855cde6d90a078e07d54650f69d1fb469663fb74807e650f6ab9264a9721d582b53c1c59f725441ff38a9a7ca64ab6a41dbc119a198f114d32b6dae00daacfdb34476a5664369510404d496b492afda049087083711f42520950e2a30b25800900149ed461161a5f69c753848e01a83bcb6db5250d01c380e0d7b1c1669ec801177086cef25d808f553d927241a8eb5da9c46a242dbe520ee27c77a7d19b4b16e424280514e4549db5698d6a7a63db43a01c1fda8964fac010077fed12605f566786a0bd1c2f0a08278eddab9ea3ad4f48254ac82a3dc558dd47bcc9b83b21a6d64b84f29cf64fff007ed559212b694941fd5c934f71ebfa654f258f96e4c25e2df09d98fb0ac292e49e14a18a8f4b847724d3af5be8052706b4b506cc0dad2dd1f88de4b65a240f14d90e6466949927f273ec29ab6e8d8783c9e2831f3dc177df53752f2ac026948cb5fab8001578fb568149efb39a6ecbef353b7210482454c8c773c1f4752d2d0f6679721b90eb9918ec6ac3b8a0c580b782c003b64f7355f69eb9a9c8eca58c25600c8cd19cc75132da5a78e0a704f3dea2b9dbe2155b01d99d31f08dd3dd37d509afd943cc890c4653ef3847d481bb69c7b9e7357bbba3f4dfc1feb8b5ebad477a5c9d2f7a52ad721e5c7daa84f11bd19c7749c6339af9f9d0aeb4eb1e80eb94eb0d3286252836b8ef4593cb4fb6aee0fb1fbd59df115f19f7febeda2d5a6e6e978b64b7c090652d2cbe5c5b8ee300e4d55f1aacec2e4ff5550241e8ff0088cd791247b6ada1f065fdff00b463af5d20ea1fc3cbfa3f456a5897bbc4ab94390c37110545b436a2a5acab181c1c1e7b66be52aac12a6485294853791d8f1cd5a775bdb41bda00254064638073ce31ee3cd0bcb77d670a9a4edcd5c723356d5f6eadebf981e49aeb5f053b9ae8b69ed3976666369fe636bdc08ae8597f1337dff66bf80ae39042366ecf8c62b9fe1294cac3aea9448a427dc029e254e6051fc5f2d95880a21e8c370b98bf8fac8a8f462ba82e8bb84b7e5387eb79657c7dea210d296378c62b1ea07dfda09567b54838d86184a31f52aa66f2b4f9b7c989aeb5f25bdc7f930a74d252c5a9d708c10722862dea12751977be17e7f34508288f66290402a4f207e2862c81027a9e1c7d479350bd675094217425902eff002cda4038000e29ff00f1c4bcc94eec050aaf674e783a319291ede69c337e8e94a5250a0471caa836ac911a2e57406fa9adf086ee7f32dabce78a906de6a743505f7231503769897c85a41158b74f5211b0d7bc405d1827bfa79e9debc251032a413c63c5345bfb5b2b053b88f3520f4cf557e9a8039a4dd84cadbc80324506c801ea6b639b3e2216653b265e0b6549ed567dbad6cb305b414821437707b1aae236611decab6e053b56adb9c6400650291c01594506065483dcb09f6e3418ea90a6c25201e6aacd4d718f265a8b0e9ca73c53d91ac6e5251e87ac0a08c14d065d16e09aa7813f577152aa027b9a3b023524edd2e5214a4877e83e2ba9fe1799d3b767146730d38fa30005f3935c80263cc80a4273f6a2cd1bd49bfe9c055669c61b99e78ef4b393c07caa8a55d18ffd35ca53c6e58b2e27c676ff0054510acb3989b09b69a4a57901200c50ede7a95027597e55d7925494ed564f38c735ca9a83abbaf6fe811e65c92e25272319c9351f1e5ea9b810b912de2823f481c56fc4f1a69a42dffb84b2721eae41733610e8fcce829dd5ed3768b7bac0921c7b0a4a5015939c5535769b74d6f72326529698e951fa7fe9a8e6a230d2817d19709e4a866880cb4b107210941da40238f14cca229d4496f297650f17f8825738f1601536d10b29fef5011d4a7e610947738a7b7a9854f2c8c649ef4dad790f150c127deb3a88dbc7dd12d5d276f52610ce014807ed53ab91e99c36a0481ce0d0443bbafd00ca14a4f033b4d38626ad4e84ef209fbd0560d9966c6cb5a94011af50e52e5dbfd373b83e6872d50d2f59564eddc819c9a9cd527310b6b1b944120d0dd925acc5911f3c84f6fc54f5a90040332c5b2c04cb2fe1bb54a2c1d48b7b8be1b75d095107dcd7d53b3c944d86d3e850525c4a483f915f1734f5d6559eeed4d67095c7712b49fc57d61f875d62358f4f6df3d4ea56b0801583ce7141f25bdec47de9aca0f8a69fb832d54b42b70d7de9440ec314aa11b8f1498bc765c8dc4d08fb52a86cfb52c960fb52c96715a96903db346dba70db55b36818ed4b213503b415ecdcf211e2944b6478ad909e69500138a198ee0ccf3094d2894f19c56c948f6adf00761516b721668984734aa5359033e0d28948f6ad3c4c8d9e69b7f359dbf8a5767dabdb0ffcb5ef13222e07cce129da3e3216549888481ec2a0ee1a6a121254a4b63f1562ea194cc22470492703ef55a6a0932a4ad44052139afa72e42cbd4ab91bf890732d1086406d27f7a14d50625b61ac8693fa4f23f152cfa64152f73848f6c9a17bd4695355f2e5076938c77a56e8df1207acca4b594b5c974b8868909279a61a75a69f6d4fbf81b4f6ab17556945980a53081b86723cd05e94b03ef4ff0094920a4027355bcec1b6e6d0825b593185f253aeb6e34d34ad89ec4507a2295b8bc7eace4d5d579b03306dee14a52770e38e6ab5b5460ababecb9c649ee2843c51c61b6fbc8455d480529c8ce0490a3cf814e92dbefb05612715237e8c962484a5ba7f678e1d8fe9140fa8543e0c1bc6466b1065971c69cd8aec7cd1669aba08b9fafbf1df150d2ad4a6df5839049e2a4add607dc8fea2144e39a2e95f13b1f3077ac83d465757f74fdc8046dc148f19ce73f9a641b20ed5718038f739ef4acc4bcd5c425e4f6207ed4bca4a152328e4148edef5adf7dacda663354007da466dd8e91c027c81de8cb4469f6674a69d9283b5b39e7fa8f8a6d6ed3edcd01e527206338ab6349e9462cf09a9b246021257857f7029765582b4ebe4c7bc4619cabc13f0269a89e16db5376e694038f2772c0ee00ed5555c828b8b48e49347777f5e4c9933646e2144807d878a10722add90a38c827c5572f3e3d93f33a252bee01a1d088c1614402e2780290b9b23b0039a9d4464b4d273c1a8a969f51e2948ed432127b99bf48bd48cb0465bd71c2503f960f3e3347cd69b71fdb947f31406004fbd34e9f69bf9b904a93f42d7952bd8679ab32698967866425b587d630d0501c01e4d0f6dc4198c5a948d912b1d4d122c56059e136971c182e287724fb516685d10866d067cf6f6127e92539a6ba374d39a96f6fce749f41a5e4acf63cf22ac2bbcb69a71880c04a508c0091d8e3de85b6f6fb193a515ab12040bbad9c38ea1f281b0a825042719e71415a955f2b7b31d9564b4907f156dcc434bb85a22920365c71d50fb0191fe6aa5bd212edce74c4824a96a09fb0ce2bc84b8d182e4003ea59d0fd16ea73573d0afdae4bdfef490a65b4eee7eb384d5dd3ad90fe521474a7865b481c79239ae21e915c176abd21c5f2932028a4fb02315dcba766b57e85164b4404846e58f39c71557e5f13c0f92c75c7e4ed0068cd9b331e8a50956128278c5425e2de1a59f4d1923b1ab1d70426371b79fb50fdc61e564140355872cbf31d07523507ec61a53ea6dc27eb1822a6ec2b91a56f5b99c7cb3e4123f26a1e44654291eb36d920f715350a63531b0950095a4719a371adf883dcbb5d196c5b65b6fa5121a394a93938ec2a5da94080318fcd56da6af863854292bfa14700f914651ddc246d742938c834f2bbcb0d4416d5e24c9871d07cd612f1038351c9789c6554e1bdc48e4512362067b8f1b49528288cf9a9065584646538f6a422252aefed4e168291c76a9918efa90b2131abecb0e03bda04f3c9e686265a234670a9a052159276f068a5ec841e3c1a8c92d29ce71cd1c9615f99856643b81772bb3b1c16ca0ac278055c9c7b504cbb8b264a9c2a6412ae53565cdb2b9294a4a91c1ee71e2a1ddd0900e5c7508c93df6f26884bc1e8c615e681f2257d3ae6b968f946100273918f7aa5fe20adedda2d9a7582d905f5baf127df8ff00c8ae9f7f4ddba09fe5b2926b98be2d1e08bee9982d938f96756078195240ff002299536823420d6651b9f5a946c97fd39afc7c641687f7a7b687144951cf6c545bcadf7d9630480d247ef8a9d891cb4de3183b739a91f4c249513e50eaca853b6a5a8f60a143d766c39728edac1c6c2acfb0a2cd32106c9e9ff52ce6867563cdc3b904e47fc0d831ef45e25677b9a65b8224b467633e1b868295fd3efe2a2ded45104f45b1b750964b81b5827c138343cddf3f85db675d1b50df19252de7c922ab67ef72e74ff5e2a8faab25647de9a9c4f73e3e6572ece09f49f89d7b7fe99f4d247496f372b8b109bb8c488daa0adb58de17dcfe6b90a75862a5d2a6c7009009ef45d70d437cb86984b4e171b5b4dfa6e0c9fac7e280dfb8c9392add91c6df38a829e3f2f1d897dea0393975589a591f7189f2e14509ec0f34daded3b21c015db229cbf715b9fca5a7fbd337a5ad9214d7d3f8a91ddb7dc505f51e5c6dfe824294a1834da34465c6c9c8c8e69bbf3254d400e2fb76ac30a5b69dbce73935119a06d99859436f1048c0a5999b0c12767206338a6ee92a5856cf3cd494185156c15ad29cd6be607c48bff28fac579f959636118ee73db146ec5e1131852cf63c0aad51194a945b6460e78c558b64b638dc56d2e6de53cd6ff29e4449bcc6b4231b9ad659529200cf639a8c68b8e24ac9c048e78a9fd4886d88413b473ed4251a4a015b693fdcd4b592cbe2934c7b116e1ee0ea3c75c6dc46124288f7a64b93e9af6848c8ed484d66437979bdc9cfb54625f92a5a92b528e7ce2b1ec3236de33cfba8bdbfb2215da41b8cc4b0948c9158d5b696e0b69da30b239a81833e6415a5d657b548f35a4fbdcdb8be04970ab1ef53d4ba6ea68ac8b5789f98f6c9094b70387903ed5b5c9d2a97b1247d0694b6dc8468ea181c8238a895c9cc85a944924ff8a6ea478c08827b124a7df149603656718ed51f0a50420ace41393c1a8e96e879cc104014bb206c18cd0d7da117e679588844dc90fc6214e24100f734940b55c6e1bdc8ea3b01c5404a7d4da484a8f6edef535a7f5139123fa296c007bf34b2eb1bdbdac2a960cdf518ee7439d099d9210718e09a8a2fada070ae6a42eb7c725b7b771fc540254ebef6d00f7c56896304db4daf750c3c64a4794a0adee1a936a525d400163f7a815c479290a5135e42948ecbadbc763724a5c0ecc9c765b0df0e3a9150d35ef5547d320a739cd22f8de429ce6b4538820348e335851a9adac0998120b2ade0f34bb2b6a43816e9071e0f9a613a3bcdb61c50fa4d358f31c6d5846073dab7d13f102f20219426a33d96511d00ed3e285eeea0c4a5b49053938e0548c79af1643acab62fcd42cc5a9c78b8b56e56ee6a4ad0ef6660befe26f1e5b8cb8978ac929c7145f68d632100327600071c541a2d8cbd0d0eb7ca8d4738cbb1944951383d854e068cdeb7359ee584f4b5cc425edc093ec29b5d6e0fa2200558038a1681a81c8cde36938ec0aa92b85f5f9ea2973e9481e2a22858f50c6cb509d7ccd64c853aa564f7f34a5b5d5077041f6a4215b65dcdd433110a5ad440c7e6ad0d31d26bfbc96bd7867ebc1047ff008a8ae6150f2264981879399678d6bbdc174de13e9b68622af238240ff5a7322e494252a49585a87fcb5d11a57a296e6622be6ad3bdd20654b3dbdfc558da53e1eb4cc82a937286da5b29c80b48db4a1b94f71bc11772e75fa532428676d4e26b8cf53cca56bdd903b28f350f6e94db735c017fa81c8aec9ea97c25337d69527453a03e9493e9a1276f6edc0ae38d53a5af5a32f926cf7988e332185edfac60abee3ed4d31ef5234df32bdca71b91867c9bb13c9505bcbdb8c13835df7f007aa0bb637ec4eb84fa793b55e2be7c45716a592320639f7ae8af83cea6b1a3ba8888b7174223cdda8c9576390056f9b48b2ad813de9ecb15e4789e819f541a6f3850c1c0a72d36334d2cf3a35c6131323b89521e405023ce6a51081f6aa7b1f16225c6d7f133096e940d9c78ad928c73c52c94823c56be7056b37346dba592d1fb565b48f714e023033519d983b3cd10df23b5281bc1cd6c8029409c9eddaa30bb9033ee6a94e4e056e1b20e78ad9b41ce714aecedc578aea44cd341c8fd35b253f6a552d8adf601c567c0eb7a911788a804a7349fa8e7b0acca50434564e076a8bfe311bfe73fe2a44c6b2c1b59ef7157f74e49bac0125d538b055c9a1ab85a7293b91c03566dc6121bdd848e471437708cada46d4f35f4bba75b95c2752ac996b48528142464d415c2dcca32a0935635c2da54559480685ae76c56d383da965abf89a93b9556aa298e0a423b772298582c6d38b12db6c156093457abad2436b5a959e3b53de9fd89b9d01c709da539c03f6a0e91bb3c5848197ca026a88a11156d293ca6a8db8bee5a2fee9480a2a3c0f15d17ae9844379e69407209cd73c6b24a13786dd50c051ee6a2e5540aa40ca507c4d242ddb949438e802a66de8430b4a72076a1c8b312141684f08233ff009a9b9b336464c86c03b7838f041c5558b8adfc8c1d54b99b5e1092f85a7383c7ef465a42dc1eb6951c723cd03aa6fcc3095a80ab13483e1567516fba527bfe299e11163f627adaf62016a786daa7abd309077115190e238fbedb6da77a94a038f1cd39d4a979cbd2bd35a8615ce28ffa75a2e4dd1a5492c289571bb1f481e49340720e2b72bf791e2506e6ebe239d25a7038af93e382953db89c247dcd1a3e157478c48a0b711a4842d47b150ed8fb57988b0a334bb45b9c29436acbb20f759ff949a424dcdbb7c45466880bce703b1aaa65dedf79d2388c2550154766406a369a64fcbb47291c1fbd0da62a524b9b703f153cfb8a90b2ea803934ca4ed4b4538c678a40eece7e65b1aa4c7a820fb41eb94820843409c77c537856e973e421a61a56f73b71dbef520965b0fee3f564d1b5821b11a3a1408dea07248e707c0a290145ee57322d2ede224f699b2c3d3f694b4a49529237bae2bc9f6a8ab807afcb0d85a93eaab6647f4a7b53e9d256f471102c2503956d3dc53cb04544560c9753c0ed9f6a5d6925e33a500ac49289120e9ab1a62c6e0b78ca87f5135036f7d772bb15bca1e9b79e6b5bedd5d90bf482486f70e4d6b6f60c48ae29041dc77135a32822648f189ce98dbda89a4b2e652c32e91f9da6811f6416d7900a96a3feb5356d91eaea590c37f56e6d583ec715052e42dbb8476d43095bceabf6c703fbd4d58fc45d79e8c52c8830ee6ca93c617ce3edcd75a74aef5e9da18580a59d8524eef27b5726b6f25ab836e646371273ec6ba43a56f2deb1b5e9e32169c7f7a5bc957e43b8561b6a746425faf1db52dbee9cd33ba5bfb3a1b27cfd3da9ce9f753260b5b7f521201152aa5b6016948c83feb554bf1f62344bfb80f2edcdc94120104780286e6312a0bdeab7bf03c63bd598e5bc32a53c94641e78a60ed9d13811b139342ad654c27df04770398b925e1b9394947ea078344d63d5c8044293210081f4f351770d24fb7f5b0bdaa07271d89f143970b65d500b89427724f05206699d5b5ee05778b4b8d9bbb2e04250b4a9479e0d4b429e850da40c9e2b9ee1eb2b85995b25858da792a1e28a2d1d488ee9c1791b863faa982585845ac9a32f586e815220a48e48ed5565b35cc67f6a52fa338e7268b2dda863ca4828790481e0d1356fef232042671b4ad38029b2e267c0a45ab8a48037d3c62634701c3de8f5d110671a8d571db6d215b6a26e41250529c67c54e4d95183448576a169b3925c3f5248fb1a9153b90eff001076e295b6e296e1571c802b91be291f127a87668a1614a62103807b6e58c0aeaed4b726a3b6b7549cec193cf15c43d4abda752f541d9f1d7b9b6f2841ce4613cffad33a5483335efcb66024705cbaca7304ef7108491e79a2e9b1551a185679c8143961466fcd46711f4f2e807bf278a3abbc742dd8ed718cee23dea563a8c2a929a75fda186ce427673513af2095154c0afd093dea42ddc3a94a0f618a5b5034675b55947041033dfb53ae2c82e14c5bc9792d6584a5350cf08b5350d0705e25c23df14cfa769665de50971b4a8257b55914d75b29c8b2229200da9523f1cd3ae98b6e337e48521587145ced579e2511b2d54fc4a16558fa978aec16a75bc1613f5246401deab8d7d60b4b1911d80874f0368ef56ca41f4cf0061228035b30db3ba6b9ced3c67deaedea2c3a528f254fb4582e27adca25e86e467fd3701ce4e49af3f15259de2a76f4b665b8a75252314ca2b4cad1b5c50c66b92dd482db92ada40ee4163d31ba92f5d45cd890726a426464b2f94e46d27c54ae9eb75ba4c8dcf389073c67de85baad2ec4dd6cd991f06d2fca4f63cf9a72e407e0a1485a95b7b7028cdc660b53d9870f0a4a80dc7ef571d9ba7b6976c424cd8edb85490ac914d380e02ce6188489f96e62be300671f33985a9098ef6e19cf8a2eb35e9c5b4919c94fb9ab46e1d38d25290bf96f4cbe73848038355d5dac2c5bee061c104a4e41c7fcd4c796f4bd9c7d1f3b82e17a96bcb3a51a8c755dd0bd0c200ca877c50432a74bea50562ac51a02ff7e616dc669d4023b9150b3ba53abadce28349dfb4672052ee3f86ce2be4a8636ab97c20dab1c6cc1c764cb707a5ea6476ad52dadbc29669dcad3ba82daa52a7435908e4abc0a8d9734fa64290014f6c1f35be4e1de83fbab1925d4bf7518e1c5a7046472314d1e1939ed81494296979c287319f14b3c3278228315f889bf9efb9aa5e506b602735aa0af3c83cf735b3490b56d14fa3c3507762c76c1e7b579ad2a353de5d466e4575c49c20e13e6a62dd6a724420eb6d9efb7f7ade46df454848183c7144fa16e36e6e3fca4d0da4fa830567ef4bf26f2a849136a4867ee41ffeee752dca3aa4c380e389482781504e582f905c53722dcfa0a4e0fd26bafb476bcd1106dc98cea2305206092a1cff009a89d517ed1f3c38e5b6130eb8bcf20d56d3d4d6259ecb5675f9965ff43a2da7dd0fdce638ba6eed386d622b8a38f63c565eb45c6cca1f351f6abc66ae1b1cb7a45dde86a683093fa703c53fd4b608ab89f312194af6f9d9c8fbd6ff00f50f8da36bd4893884d6c19424bbbfa60a1e8e41c79f34d189897145648427daa5b5ab9197700d309010011db9a195b78fd24d58d6e1720b3e371364d6697f1064c02975780411597ade14e25c0b03cf14ca195256013e2a73d30580ee7b607ef5aec48c13aee46ce98531fe59e4e40ec6a0c2d25c3b00a989ac9904a31daa39a84b4ba40a2ab5f2ee44df99b2262d0dfa7cd35714b249cfde9d3cc16c1c8f14d1671537c4f2fe64fd8e43a9c36ae72335272a136b654e21b2a5540dae4fa406eefd8515c1bac2f93743e53b943091f7ad7c8421143981ee3259732b46ddc7814ba5a68903090a353712d3fc48971e0a6d009da48ef5296dd32c2e5240255823c54aa7c47523f64b59e22486840cc096dca91192b5023823c66ba7fa6fae2c2cbcd3f7a65a6529484a13b0119f73557688d0bfc49d4075b4a700019e062aca6ba60c06b72e48425238079155ce541bc7876274cf4dd6d89daeb52e591abb4b5de384dae44442d49c65006e1f7a1bb8ab503290b8d31e96852be94278c0a0cb4686b8b0a4bf0d0b2d03fa8271daba17a6b60b4ca82d2e5381d780c2924f2297e1f21571e42b104cb5dfe5929a20898e99ea86e3db96c5e2398ebdb8fa93f51ae29f8e091639bd4283fc29a6f7fa4af5569eca27b57d11b8696b52e2a9498e9414f1b87b57cf9f8a0d2311ceaf5b2d71565df53ea57db9a9297bb2b2fcc7c451cad75fe84a094cbfd2ed476dd369d4d262a8442520fd18d99ec68710fbd6694dcc86f96de65416958ee0839aefdd67a1d95f438dad0da94b1142cfd3dd411c57cfbb9283329d8eb49ca1d29e7f38ab38075e0d39ee7e22e1549753d19df9f0aff1650e7c587a3b55be1994d00da1c5abf5d76641d451a430990cba952158c107bd7c6ce9058a7dd75c5b042538541ddca209c8c11ed5f50f47373e3db63b2eb8bfa1094907f150370a966d8473c7f2ed94a15d7fde5b89bc20e08e456c9be20ab6a41a1686a251b771a92621ad7823b9a05b8daea3a31d1f123e21331343a90ae053832c253952c545438ab0de306b32d975b6f773f8a87f468e7420ee164b3535a51e1c1c53a6df24f0a1cd0734fad2e84e0839a25b6a56e6d24f8f359b38f555d882b85d49569c52b8c53d423201349458c7b9c53a2360c52ab29d401dbbd098290139a6ce381272b50029479d013939c5056aed5ccdb23adb6dc1ea00719a228c46c82154485ad5a94b344b59eab6e0c7532cc8014ace2ab2ff006be5ff00fccd0f6a4d452a7bca5bae7bd0efceafdeaf9c7f008957d63b95fc8cb7b9b6a7a861746f048c76fb50d4d4a8a95f4f005583ace1a1b71b534ac15a79c0a0694d8192546ba316f21d4295431d182f787e2c6090ead29ddc7240a199e84bc85a9b00a41efef50bd6812a1c03704ad412c9ddc139e39a4f44de1175d3a5592a52529564d22b3dd376b5d4656558e956f63706b5a34b301d5249ce6a1fa5d7a9111c722c94fd05479cf8a2ad4611212a640ce72318a065493699c1969b008c92079a35314efce569f2d52cf08dbaaef27d5538d9192af06a82d763d40d3812494e471ef5726b97dfb8a73b0f041e3c5543ad61ad31f7fd43dce0f1fdb9a599e07448dcd6e7f25d09d29a3fe1a7a7127a63fed0dcc381f3697ee2edcbd7212c043648dc3b6091803b9fb572b42f989704ad6e15850dc93db39cf3fd866ad9e97746bad9d45d181166babe9b14b3b5b88e4b2d224e1590848e777e0e39f14113ad122ca9916a75210e44529a581e1693823fb66a2e616abf194d55f8ff00314e3792d84796e40b71dc43232558cd5abd3e845eb52b69aae2234b718702bc1c7357374822a576e71b5a73b810334b38fd0b00118b2b303062d9a0a5ea7d60dc3014da104add5a86129483ce4fe2ad8933a2b30ffd92d2890d3084ec913523b9eca19a677890a60ff06b22cb2a9470fba07d58ec467da966186ad96c44184d94ad47f9aa1cee27ce6abdce6478e4b00658f86e3f6808119c94a2145f9461a4ab8ca95e547de86e530e3ce29c29faf18a26f416a254bce01f351f71532d28213dcfb5552fbfcfa97bc6ac638ebe60e2db2cb256b18c1a809b25b694a5c97c2124f1938ff153d7f98a8910389c13bb8f7aafe258e7ea6d40db9b9c0da52a52b3c8e2bd452ac3720cecc641a127635c8c97da6a33082d647247d44e68d900b6ca370da70071519a7ac6cc6065bc80531c10951f2a1daa5171242de6b6654e387294f8fb57b21bc4457482e7ca3ad3701777b821a2498edffc457bd4e6a670404371e2e3681b48fb53ab2c4ff67ed6af599c38f1dd938ce6872e0ebd3dd91254afa410518fcf6a50edb3d4794ec8d46022bd2e600b706c23b78a9892e32cc45a5b713f4a76e3ce6b4699f48276a72766f3f9a86babfe8b4b5a7f52940e2b64209d1997107ecad488da994b0387545393ef519aae3bb1662547212da8a87e6a61e90a5dc9a9ac921b42c2d58ff3525aa2d02e9144d8e9dc95241cfb1fbd783857d7da41663f9aec4125616db4f67276e715d05f0ef746e51723bcee76a70127c550ed3694b010bcee6ce08228cba537d5d82fa95257804151f635eca41626c41a962ada9db3637970a4100e10a18fef44aa485a02c2864f3c504699ba357784cc96864ad09c93d81a378853e9a504720521b2a1f10df22a62ac0ca4a5672315e5dbf710e4750491c907cd28da403c918a7ad16b1c2b9140d94013716f5239c8cdc84ff39086dc03038fa4d42cdb26e5e63a50bf271e28bcb41f4e1583f91de91fe12d344b8951055e076adeb2010244f619575f34db6f20faf1d2559ef81555ea9d26a8ea0f417171dc513b8b6739fdaba56e76c6d609fa08c794f3559ea7b30255b520e339fa69ad083ee208f709cfafeb2d67a6dc2d97c4961b57f5000802a56cbf1431ed05b62f61d8c3701bf048efe714ff0057e9e6d2c3cb5213e476aa52f561121d74e0ed49c2463b5354a91be20bee19d79a37e22b47ea2690235f98de7c38e6d3fd8d58117a85164a12e265a14df7ca54391fdebe58df9972db3c2038a43a15805b2454b69dd5daced8ea5c6350cc084636a54e9205143035f50919bc13a9f4f24eb18ae2084c8ce79fd4687e7eb7871d2a71e7d084a739dc40ae1eb3f54ba88f12b73513c9693dfe9f152964d41a87565ed11265cde790d82a70e4818af1409265acd92e8eabf555f936f5c5b43807a990160f8c55011a1b86e5eb6e270850e0783ce4fdf346dac1295165868001a6c8fa7cf1e6a0ec8ca96990e94fe94280cfe2b74b3b84ad0164069186b9fad0b873b1b7360fc018ff005a33bc32a170213ffc2f14874eedadfccb121207a8ebaeac93f6a90baa8b73e4bea1c11c54175dde842513535b532b00b80851576c512370d322dabc81947d49fda9ce88b2c6bd5ba5b28c7af17ea6f1fd59ef4b456d71de5465a08dc4a7068bc0e47dab06e0d9948b2b2273cf516c1f30e3ca4379c28a907c023c54574afeb9e23c84ac3ccaf3927c03daae1ea3e9d4db995cb42498ce2bea57fc8a3ef55d68b650d5f87f2d214b5771ed9ae97c1647bd968c273ce4abf6813f8971ad3b1192301494d55fd5099ba298cd2fea2b1daae191137466c2464940aabb5669492fcc54a94b094050c73c62ba973b5b5d8de2bf894c1c8d61cca81ab63ab4eedea5951ed8a8f98caa3294819156b0d3acc688e143892acf141175b67cbc9521ec6c52b39ae617f18d52ecc22bcd17b7888172256f5ed564e38a5edee04b8925452370e452d7a891639f51a20e7838a6d092dba9213f8e690d8344a7e61eb5e813b961da531e4ad831c853bc10477e2aedb25c2e29b218b3b2846cc249eddab9ef4bca72cf3599451b9092323f7ab1350752fe7ade98b11012b48030011cfe7b55c3d31651c6a9b6d7d4a8f3d8b9198025637092c36f31ef6eca94effbbf277f814ab3a5a03d7172e8b1b9085ee240e319ef42b67bc4d990d3142810be55c9cf7f156ddaad4fb9a4168424faae038e39ed577c4b6be454fd3bd4a866d3671c0176d7da0edb75fdb9178fe091e3b7b11f415803f146ee408925b2e84b6a4a92159c773554da3a6b7b76e0ead6da9b25c24abdf9ab66d56e7e0db9b8b2092b6d3c93e698f11916b935db5680ebe227e57daa02bd3677fe6573d4bb4c466cf25488cd7293938e7b5728cc73738e139c6e571fbd762f529adf6390473942bfd0d71dc81b5d77eca3feb557f5652a8dd09d07d1996d914fd4772292f29323702462a6992b71a0a2724d4635156fbf94279cd1522da63400ea9593ed5cddbe93a33a030d8ea44c652932d0d8ff00987fad180434b6f7e464a6849e6f63c1c4706a6e1852994ab7ab24639a819773707c57b89294b6de52544633915a36db8e257b5401ee306b69e709e3b8159b6389c12b38e2a06a59ba123254fcccdb848f5bd2de725406734790205c6d684ca43bb93b7711934270d0ca9ede92320e689917d2d472d904f1819a4f998835b50371961e568f831ea4ed82fc5dbba36b7970103b79cd5d8f69e176b1a94ea40dede4607daa89d1df22e4f54c79694281ce0f9ae87b2dc9a72c679490947d273f6aa6f315b53e2c3e65c30025aa409c73afedff0021a865464927d259070287bd2e06477a31ea295b9ab6e4a383fcdefe3bd0b2812f252aabbf1ac5f0949fc4a87243c6f222d116d31b5c750149079f7a9f972e01b692d000a88038f350086d0a9286064824558ce58adcde9f2b723a8808de7dfb5107a1dc10112b78ae872414a86339c66b6404faca38ce0d26c1409ab6db38402768f35b27721d50f7347d47c566afdc749848951dd4848f536923fb50a3c8525d208e01c518da96b2f80de0958c62a1f50c010dfd98db93b95fbd6c581125f67cabf20647c62494a0672aed44f66b3af707e5b2a4a3b8dd43b67da99ac858042543bfe6ace5204940434dfd1b538fb50cc1ac6089f336a182b0dc5e1c43258ca480948c0005398459812521c5252723b9a736d603012d8e41e0d3f7348b772752f6fdaa1c8e29d6071f7b30530db322bac6d4770bac37298a2d088a210ac2720d745f4bf40cad40da244b9ae16f014524d525a46cec3119b8fbf72d38f19e6ba27a62fcc80d36d2c800e307b549cdf0dfa6c72fe4372d9e9fc97c9b5504b66268eb641b77ca351d24ede14a1f6a0b458a669fbcfccdbde50694bfa9207deac6b448f5d8daea8295ee4d30bcc24a9f0e369c01c9e6b9c6371dfa8b833cb8665cf8ea446536faf2602dc529584b7b8e6b8aee2d275efc4428b6bde88a42327b039fb66ba43ac9ab5ad1fa427cc5a901c4b0423eae544838c5732fc29b32aedab2e1aa2e214a53af38adcaec39e2aebc6e0a7b81544a97219afd2b7c19d7f36c0db9a5df8270a1e884007ff4d7cc2eb1e9d5e99ea1dd2ddb4a5b51ded0c7b9e6be965e7539b7dbdd538e0d8949cf3f6af9c9d7ad4c8d49afa6ca6d5f4b7fcb183dc834c73b00d1f5189f93cca2cc7157de5bdf05da785c2f8edd4a77168a92124678c57d00b45b262b6abe5d4067c7dc715c6fff00b3bac2b9f709521d49f482947fc57d168ed3119af4d0840000a89b2bdbafc4093f1b8af5d419a425aec4a4ed2fabbf8c54eb30986c65200c7bd377ee4db292940cafdea2ddba49cf7e334ada97bfea8c5aff001eb708cff293b880053391202f09183cf1518c4b5ba76ad4a39f1ed52902dea7d601f3585c534f6642d913d06d41f7838a479a2589010de08038acc28898e8da0d3c494a463de82c8b4fed1046b58cd9090914ddf7928054b50007bd273ae0dc2415bca007b556fac75f06f7331949f20e0d7b138f7cb600081dd92940db192fabb594682c7a7196371cf6354a6a3bf3f3e42dc714a209ad2eb7b7a53856eb99efe6872549512464f35d078cf4fa51a661dcafdf98d927a3d46739f52d4412783914d7d43ef5bbf9512734df07deaccb8c00d01070daea5d17a53cfbdb64676a0eded4297282779c20ed27bfdaacad5767583ebb2838ee6abebb5d5b840a249080139caab7a2c1608e5c6a559d55b1b5374ec869c4e460f7fc5057486d306569d7030f1f513b811bbd8d1cf50f5de9d1677da54c6b70192323b573774c3aa3134c4d9cdaa7a435eb2f0951f73e2a7175083eb8b336bb9b454cb96f96d6edaf12a4ee279c91c5511a9ee8e5bef0fca79432544247802acd6ba830f51beeb6dcaf572091f576aa4fac6dcb857249e0a54ae369ef4364debe1bae44b8fb3e6d1f3d71b9ea06f6428270481b824d406b2b049876752a51297527918e7f6ab9ba5cc407349fcc169216027393cd577d5bbac25893199e547383ed8a12fc75f63de63a9a071b20cb13e1b7e209fd33a323e934e9b66e0fda3d45c1752eed4859edbd38f7c76aa4f5f40b8da3505cdbbb3254f4875721c708c6e2e65581f64e6a0ba51a851a7efedcd93bd2ca17977673c67be3cd5d5adedb66d7d0a32ac2b5c9723875d7a52860b9b8e529fd87142a20ccc6f6ff0011516f6eed8949d8a2bd7043d1db41cace13ef57768a88d592188c8565e2807f06846c7a715690e4a71182ce7b8ef8a2ad2a87141529f594ad4a384fdaaa994cdc737c4b2e053fa861275d084bab7d606f576351ee4e42144e3b7de94ba3e0123343f3a40424f273dea8fc9e53645bbfbcbf6254b8c9d08f665e90846d4919271dea296f070bb21cc9001033ef43377bb149da9cee07b793530d3c855b029693b958279a893009afcd8cc0e43cadf09117d9697488e1be48e3f34ff4c45c464061ac3ce2b6951e02527b9343c64392e7b9c02527031e28ce0ecb6db9986d2c15be92a2bf23ed522008bd417236ef1ddc1a0990f458c821969b0a48f727b9a25b3dad732f914841086593bfdb819cd40db10d494fcca9d2a516c24a4773cd581628896ec8bb82cfa6e388f964ab3fd4783fd8529c8b76488754a00123755cb418e12d841284e318e40ed501a76234b5baebe4a9076a423c139a757093eac775f2bc8002139ee7079a4ec2851936e8de1616f2f1f6e68461a5dc674fcc79122092ab8109c7a43291f6ce282afedf0558206ee0f8ab074d34e48d4322da93b8c98ef003dc8e681afd19e5b1358c1dec38e11fb66a0a2cf27d4db20055d891fa6e0fad0ddca77052b39fb134516f65a4326149c04e723351da502635ae1b8bc7a5242d19f3bd3c9145b3ecea4c46a634d9fa93b82bdb1ef43e5bb236e498c15d746055e74a88d25521293b17c823b734d2dd10469ed2b27238200ef565db1a66e8c7cb3c909748e147cd0fea0d353ad53532434af4c281381e2b099e597c668f8815b625d3d19bb496566dcfaca90a0928cf8abdd8c1612e1f6ae7ad0092dbacca411fa13c8abcad52512196f6b895607201ed503b06320bd7c75258ba4723b56ec4afab07de903fa6910762f209a8d97ca084ea10c77028020d397569d82a2223a768e69c3ef6d40faabd5d3dee68cf10b8bc929e15da866e5190fa55f4851c1a919f2f29231daa164cb500483800678a3d46840d88dcac3a876e4b10a46d472a040c7e2a9dfe08e3aea7f9676ec2b566af3d64cb970416f9216a07f6a0c458c46746f6ce3d220d4f5da54f73ca373917aab19b85a954d37c1033c7bd634bc2f9b656a7870de393d8d4bf59edaa5ea9cb49395120d3fb25b150ec51d873875d04a891e29e25dbafe60e959f7353782ca5f2b8ed8da024807ef8a35e994172dd127dd9f402a52bd34295e450b4284a8f196fa73b939273f6ab0d49fe17a262210dfd6f9deafdc6452fb2ef231aa291a8da53827a5c79446492303da97d356a121b4b001def21c527f00543db5fdcc2d609395803fbd58ba560a5a9485368054c24a123f239a8c395ecc210083da02025bb8c66523b87c1fcf34b5eed2b724bac251950483f9e6887a7d09b7352498e524168ba40f638cd664496a35f1912f01b73f94bcf7e558cd34e0711795ce5c56ffca4963fb6bb1227434d7b4fcdf592ac63e920f9a229de94c74c9671f59ddc7bd0fde2daf5ba63eded502159c7b0ee29d69cb87aae7cbafb9ed9ac7a9384b384e41a9fb0980eb6a497bbd9625f6c126148649448494a88fe8563015fb77ae7b8366b859b582e14d4e171df2dabff004ff4a87d8d75240652d12952728712460f624d569d40b4371f50449e1a4a53280654bdbc92939e6ac7e91cd66ca45fe651bd474014391f88470980ec56801fd03bd0cebdb0bf36dae7a3c601236a79e051a5bd85a5965013c6c4f352498ad4957a2eb594e3078afa57f4e32a9f0fb913e6eccceb316d2c4fc4e4dbac6bbc38ee079d5a15bbe9ce7b5086a176e6c369f5d048381b88f7aebfd53d398179297031829e7f4f155bf573a708916f69ab64556e6120ab09f6aa2f33e93c9086d46f88cb87f56d4f68a88ee7378b5ca98c170a0906a3931df86a504804a55db353f3a55c2d8a55bc3652428a08239a3dd21a0e0cfb2aae973da1053bd6a23f48f3fbd5271b8bb731cd29f23e65db2395ab16b17587a32bdb35cbd7c3721ac0cfbd77874c63f410f4826c8d56f58fd1fe16e38d8dedaa47cc9410809e73bb76303b570db31e1a67ca698502db4e29285038e2b785e82df5b0da3095719fc76aa8f398976538c75720a9fb473c56650bfdc65dee3bb2eb091659bf5287a609f1c14ee200fcf6ae90d05d4db2dea0b30dc71a429081c64649ae4ebf873e69484240079c01e68b7a61a3b55eaa9819d3c851793c8fab6838fbf615d2fd33cd7fa4d6b55e7600f989f9ff004f53cf6d5068fda764a5c88a4256d29b50201ca0734397fbf316e752daf042cedcf919aa62ff00abfa83d3c9274eea286b8725b4a5442c8276785646460d68d6be56a37196dfcff2c85294477c5748c6f5160e4203591397647f4ff95c6b4b583c87da1ef5056d9d3ae3b9fd4851c7db15c773521329de3fac8ff35d29d41d70997687234747096b60c8fb5735cd2a2e297fd454a26aa9ea6cbaf24ed3b974f49f0d91c629f7c78ee6f6f90c47595293c9a9c6a51951d43d3041ed83da834a96a740dd8e68b74c7d4da9b5f23cd50edc6f749612f22cd08c5d42d320257823352f1404360abb537bb252d4a050918a45d92b0d6127c52df6cab6a6ccfb59bdc940e4a7b547b2b71078ec6960f07084acf2695530400a038a86d62bb330a3ca6919c928909092402476a294b7b9b4ad47fa7b50c0756d380eda9985724380216ac103141106d938608665bd41f2724b2849ca4d59360eaa08f6b722485a40282073cf6aa6ae88f4e5a9e6ce7269aaa63c13b413cf141e4f16991a0c232c5e42ca3b06115c54e4d9b2ee2b772979c246738c543a0a5c92ada41db4dd57a7db8c585025201f349db95bde2e648dd4c31e914d62b5fb41722f37bf998496c865c9487144601147776ba332ad5f221c4a14846de3c8c50219258437e99ef81c53af51c3ea38413f4f9ad6d4d7722504fc419da19b96d078dc7fd6a4a7462d35eb0c7033512bde657a839e49a7b74bc6f8a964003800d109b2b3c67acd724b32db504f39ff00bd2fae3f9b31b59fea403c50e44736484a82bb1a95bd4a5c8536b59cfd205684193f9815f8c8e8e12d3c8707822ad7b12d1222b652a192071551ac9e36fbf6ab3347bdfc86b23b0144e354cc7e93a98a4807b854db4a6961c29e29e474dd6e1210c425ad09c8071ed53d0ed289686c8483b80ff356b68fe9c06e2353d4ca4858cfe8a6391436052d917dde240ea5938bc26e52d5a6b5ebef34d05a55e84965c96f6e53891deae7b6a930196f68ec2985b74c7ca328756d83b40c7d3c0a88bcdf551642596d6060e3154be1791e43d4b9dec5ae594753abe46171fe9ac1f7147d72d0b1dfdc4ab2a59c63b511a67a26b5b923903919aa7ac17d52c80b50e71452cea3f944ee69c02ba1d9e9ef63a459cfdb9d5c972cedd417eb7d8204db2ca997b900478ccee4a7030af38aaffe1fecb1edda7e4dc5a6d286e43cbd83b71e2a2fe233a90bb9aa1e948eb2a32d684ab6f71f551ae88889b4e9a8d1779094341441181db9a3b88e2992c2cd13f29c9d6ea0277a913d6fd55fecfe949520ba1076a80e7b9c1c57015d64bf75b9beea46f71e749e3c9278ae85f8a4d7ad4d96de9a8af05a10a057b49ef547e83b5ff19d51021a50acbab071f85541cb59ef5c29595a7636bef73e84fc0dd897a5748a263ccfa6a904a8e7b9c8aeae5dd14e00129efe7354ff0049ec4dd9749c0881212434d9efcd59d194da51cac1e2b4bf8f503a12e186cfec806488deb392ace696699de704734dd97db38da7c73527082090afbd0471ca8fa443169f2ee3c836e1904fb7b510436d0d8012066a3d879b400a246052337545b2de32ebe904781de82bb1eeb0f8a8306c87af1c6d8c222b4b68dce2c245415ef56c1b7b6a421d0a5004500ea1ea28716a6e238ada3b7355f5d3504d94ea96a7c9cf8a6383e99b2d219e56b2b985f8ae186a7d7726495348794903c5004e9a5e5a9c529454af7a69265baefd4a3c8e69aadd2464f9ab9e1f10b8dfb40889efb2e3f59997d65409e2a3de5fbd2ee38403cd327954e171cfde67cc01a111755de90dc6b671549ee15b8a3533e73af66b4db8da92a191e735ce9f12d219d3da3ae57361212b6a3a940a7bf19ae83973e3201497920fe6b947e33351466f405c590f005d636000f2772aabd84ac013f6d47cefaea7015d3555e6f6ec97254f7f04e000be319a8171b7524ba975439041a70d043683f502481feb9ad72a5707b1aa167f2573dacaadf060cd1ff4ff0054ccb6ea765a90fabd3571cf6ef56cf53598d7e850e7ef4ed082a511e0e38aa226a1c8efb72193f523bd14b9aba44cb37c929442881e7b114662f3056835bfc983b377a10e6c5aca45a6da2d8c29286c8c151342faa4b73597e607b7ad4159e7ed430e5d2516b6173b0f14d9570794d94152b041e2861ca58e9edd87a913a7dc46fa61fd931d0bca4a09c1edcd597a735e3fa7d9723a1416cad252415f83deaaef53d2595212067be293725baac80a51fb7bd4b573071c7d1206c41610674741d496891688cfdc561b5cf07e5e391c93d8134e9890dc6643007d406f18ef8355d348419da38a9416daa2a9249ec16140628b5b7bd4bbfa0da8a92a6011fb1ed55fe57956caecf5a96fe27156b00c737094ae544d0fcc96487015729078f34fb50c94c26fd6754360ef55dc8d402e3704bcc28048ca4a73ed55a406fb4b47d9992284d7e623225aa4de5495b9f4a4ec241a27b7c9539685b45cc960f27dfdaabb79b5fcfaa6273e92d7bc107b1edcd1169b9ae3865305590b19a6bb2078efa89b19f76ec99bb7292c1708561c539807f7a30766ad12d51528cb50db48dff750e684635bd2ecd714e83fc93ea0cf6247352d0277ccdbaf0e38ae7d64631df18a12d7e8811a01bb07e2156917d6eb90f08514bca0df1e493c55d12add1a25abe5242d6db51373eb38e3d4526aafe8e5b1376bb58611e501f6df273d929ca89fec93fe2acbd7d383761525057be73c1d48279f4fb0cff6a437b69e1e3b3a12b80853c85328565b4a89fc8ce734f7483e8764bd7057e88a85b63fb533b8b86dd0996c2415bc0927c8cd25687556eb44928ece2959fb9c56bb2cba10ea8eb527b4d5c936ed5d02e6e287a2d3a52bcf9428e0ff008cd46750eda6d9a8266c5abe56424948f649e41fef5a20fcec16df6923727248a944dc5ad4f676e03c10f49840b4e288e4b7e3fb50680a3ee1772a94ee08b0958d28b28ceeb74bf98007b2c60d595a42e6c5d6ddfc3e46d52820639f04503586329722ed655277373a22c367ff00f2a55b80fec299696b9bf6b98d95a948c39b559f1ce2a5b6b16a13f78b05c69b00fb4b33f84bb0565c28c282b03db1448ec48d75b721d51c0793b559e7045395329bb69d4dc18c29c5e5247fd691914d74cbc897a7262319721baadc3cf079c5579c956d0fb470afe63737d2e1564902df232a53277209ec526adab13ecb7b1f657fcb7073f9aaa27a14fc68f728e49527859f200a27d0da8be69830dc52700e41a96b7d7c982debe43a96db4b0b40c2b3915aba0a79a616c7b701b49231dea415f58ed4529dc5efd0d47115d4ecc13cd6d256424804e453569202b938a5dc525415f50e7b510bf3077121e4870eecf9a8e90d8033dfed52f256124e79fc546ccc14e53446c41fc60ccb8ca93271800035157e88d33196e2460e081451162971f2a2ae09c50f6ad6c36c2c64e326b473f713645ee72aebab4266eaf5ad48dc9693bce69869d1125cd7e0cedfb5b736b653ff00df6a37bf474b975b8b89009052d6477fbd0ae9db72635e49753921e50c7920d1b5dc7c353735f81f29352aca86dc69840c25fc707cfb54fea7534cd9e1b0b213d909f6c246154fae10921d8afa904140c27dbf34d75e460e40b796c9294973b8f7e4d0fe63ca1759f2020ed861846d657fa544aff3ed564f4c14a9eead4bc6e04239fb1e4ff6a0bb6b0969961f5725231449d2db9b2ceab7adeb484f20f2700126b7b2c1a93b2f8fc42ad016ac75226b69e0043ab20fe2843a82c3916ec971a04ef4a94907c1cd595a724350f5bcf9076852d952538f6c5571aea7a57330482a6d3c63c1dd5161e65b877add49d3033c83dde8c86b56a5973e5b69baa8a88584ad47b94f619fc54a351cc5bda50dabe9715b411db9a14434a4baa79232543071f7a32b2b2dcf75a94e2d594b89494fdb814db94e6327946f7324eccf1415f50fec2975e64b2f01b9b1904f9a63afb4fc6b9d8d6e6d3eac573d66f1f619c54d47861a90cfa60838db522f441218710b4e428702bdc2e68c2c94b1be37107278e726a6ac7dc409b66551182538fa00c679e2a6e30da4109efc536446f947c21c69402558ed4f93e994156703fcd7d5bc0fa831792a552a61bd4f977d57c16671ced63a120c6b75bb41800b5265fa6ac52101fb1dd63bc1721a74ac118cf8a10eaa5b24dce2ecb7baa4bd8ca700f3f6aae6db63d5d6561e945c93fca0578e70ac738a6b95cb7e9dc52f5961f99cf0713fa8436a5be2db88754ba5b657ef0bb8407b625c5764f60aaafe7ea6366b34ed34db80fd3b12acf39a717bff006f6fae3a552dd8ed959c279e7ffad5797bb34fb548d93d6a716a3f5289ef9aa3f31c825219f16a2a4fde747e0f06cb2b5af32e0faf81104cd4b2367a64a944ee51fbd10e9c69b794a70a47ba6a22df683386d602b79e36e39356269fd21223c3529f4941db9e455071b08e4dde644e894db5a003ed012e4da5eba969407271568f44b5e47e9c5e3e7e4db9d9cc11b4a10bda47e3c55717fb73912ea5601001efef53f604b6eec0082ae38cf9adf2b0dcb7b7f02364b5e9d5a92ccead6b55758f5237a8e65b5315a623a6232c92145281db900649a14896a8d05054da025407b54dc183f4240460639cd693a36d4a94a20000d4b8b8e306b0149858ce6c8fdfa813ab1e508ce8c718f02aa397c92aff00a8d5bba9861974949c638e3bd54f2db256bc8eca34556e6e27b81e4b02372208cace05583a5930516d2e385217b4ff007a0429095918fed441667bfddb67fad66db0575930463a116b9bed3ceaca15d8e299a324849e73da95b825b64ee48c9577ad21a77bc09e45264b3dc6f89303b48aa2dae2dd43a941c122a4a4b3e8b013b79c51859ac087e125c52738009a657ab4b28696949e527bf8a65670ecf579c4b7729ecd9e1b80ee82e6e48e38a4e3a16d655c9fbd484796c47945b2def39c63144af58532608740f4c919000a569c7f8187d59258027ef03492eab079a6b21a03902895db3162138f2f7704f8a800cee52b2a3c1a82cabc1b51ad4c08914fe70a183da9edac0cf6f15e98ca020e319c1adaca9ff780950c8ad517b92192cf216a92c04671c76a92714ad8e2727947fda9a3f39119c47f2c12922963736d04baa6538230450f78fb092542414729f54838e33de9a5c529ddb862959321b32dd71a4a8051e07814d5cdeb254a3c1a913f689a1fdd106c90e0012335233c28a1bf3f4f7a61fa5608efe2a4a3b2a90e210a2761207ef5b79003b9b0d1916e2d38c77c55b5d3eb6b771b5ee6d7b56df81e68275369e6adcc4790c28fa6f27c8feaab0ba2a52b94622b185e01a67c30aafb7ebf8990a7ed2d4e9f5b2e129f432b694ada73d8e3835d35a7101c82cc40c0494240c1a89d09a46db6cb6b735bdbb969048c039ab234cd850f853fe9f04f15cebd77cea7ea1b195ba13aff00a3b1170a916b8ecc8abf5c98b2d9d6b504ef524800f8e2a969972f9d9ab7149e326acaeb204c2d91d0a3dbb554ac20a49593dce6ba8ff4a785c75c2199adb34ad7afb9cb1dbd853d42181314c60a7b54a3b752861656bfd292491f8a828c429200c9e2b49ed4b7223a8610a52d40e001f6aeb76e15657c984e61fa8b1880a655cfdb55ab7a9edc95a8adb8677703c8356b6b6d4cc696d2cfc853bb436d1481bb9ceda6da1f464eb530fdd24445071d5ee2a239c5541d50bc5c75c6b08da16d6e12d21d1eaa93e0e6abd919b858a0a2b02dfc43971b21c02c0ea54b22c72f56b973d5d39d77d1495ac1c9edcfbd4cfc3a591177ea0475ec250c383071e370ab6fad3a2a3f4e3a55f20d2ff9af368dca000c9239a82f847b311257727063693c91de91e1e3d59f9abedf7f998756c5eda772596ea223086b29fe5b6948c0f1522f6a15a53942c607deabe6e5293921ce4d2c2628800a955786e15093d494f3ce13c561e41d52e2179708c13ef534ceb94b29c24a49fcd558996a1c0a504974ff005d47fe81537da0adcf6427ed32c59daf65b876b6a5a41e38550eced412e42895485fd47fe6a1df59ccf2aaf2964f24d4b5709451f022d7cfbb20eec68fde98b52bf51513ee692538a3c94d340e0ce73cd6deb93c6e1cd1070947c4d12cd199715bb39a494b18c735852b93cd22a5135a8c6d184abec4d5c24f9a66f28834e1c27914dd7ce41ef532d226de51ab8ace71ed4973f6a5d63ed49fa6af6af7b3a982fe3266f1d54bb3dbc34f8ce08c0c922b993e21f574dbc44f95992890b58fe5acf38aad352f5fb5c5f37b1165b505839003030bc7dd540532f773b83a5d9d31e90a51c95bae151ae619dea2a4d6d55035b965b6d087c44d5c1b567007dab50b50ef49fa9b893582bc0ce6a86c4b1d9f982f9ec4d5c5a8ab919c56bbc8ede7ed5a38e281cfbd69ea9ac0244846f7b3160a04724526e0f6229152979e0d68a52b1fa85677b9219abaac1c669b9594ab2064f81ef59528e4e4d20e39b0e7dab0499807b971699f4ae9a69898d3c90bb0cb6dc58eff00c957f57e33feb539264aed5a8d1804214dee413db628719fc9aaaba6facd3a5af9eb4b1eac390c18f29ac6429b3c76f380011f7abaae5a7e54dd36c5cedae266b0c237352127256dfeac1c720a690e6b15dee5af8921fa911d408ae396b3b01217b4823ef555c1b44b6ae0b71824a023247919ae82816a4ea8b0b51d4529742769047638a6763e8bb4d4c5cebb3ab7d4b012a61a3842803c0a0b1b292b3adc69c860be478f8ca5a3c12eb41290eadc48c29b4a091de9dd86398f71f4dc42921c50410473c9ae97b7f4d23b5c43b1b11da1829cb6727f7a89d61d2f8adb1fc4511fd17593bbe918048e7fb54efc9560f883074e30d6db94dcf43714cd42776f4b2a2800724e38a87d3024adc90870101d524907ec31cd3ed46eb89bb3f83b57808029c69d6c3eee1c4900a4e4a7b9ad7dcf21e46127e96025edf0f9665b8b91352d8f520449090368e0293b47fa9a5f594c45c6e410c0dd1d8088edfd824139fef525d170edb747eacbc04ed5a9a2c36a1e0919143ae475084324e5b6d2091e79393fe6905d66ecd46b5d5d068377fdb26eed3080484201091f6ef48de5b72df698f14270b90a5b98fb63cd237f94f998dc78c8dafbeb4fa8a1fd0907b0fcd15eafb1192d5a5c6d2ac88c339f39e2b64b3c7e66fa27e2446936946338928df9fe9cf8f350ae09b63d52f3ec2888ee8c84eefa73ed44319c4e9e718f5c2929748041f3cd3dd516032da6a7c5c252405a804f8f715a93f5ee4c4929a88478889ae47d596c1965f7085247f42fb280fb1a15ba44761bb39084fd5b4ad09f73df144bd37982325db34f5011a53ca4a01ffe1b9e08fc9a4f59c07ed3a88b6a6f285b616377b78a9aa70ada3f780de875b965f4aae26e1a6d719c09ddb43a307385e30aff0015ad88ff00099f748653844bdea1f9273503d289ac5be6c784a184bdbb7127b03de8a752443114ecc4e7734ac71e41ed48f313569204331ecda6a6d6096901c82bc290b51042bef5216f846df312e328091bb240f6cd435a992eb8a71180ac023f3460cc271486dcf64f3428e8c90924436b2dc42d8424fd240a238af05a7ea23b66816d87604f3822a71a98e2140eee28cad8412c4fbc9979f085929cf14d9f9a40e077a48c96d68dc4e4d35715bc9c67ed45a981bc555237e4a95da915e5631e0f15a25b5f3c1e69cb4c9db8c54a6411b84161048c67bd056b179c547c247f564d1c4be13b4f614317a881c6d4169cf35a39d4dd3b3a9454181f317591b924faf23781e78a926a07fb3d7691222dada965d05cc38d6fd831df8a96b15bca6f85b51212a5ad41447602ad68ed6b8d11a7ee7ae6cb6665708b0582f39112ea0150c0e4f6353d449925eda004a8a67a775b042bca1280a711b5494600042b938f6a88bc405dcac8871b3cc670958fb114f6cd2d13b4e4b6dc096dc325d7169c638393dbc734f2c4d36edbc9d996e50295e7c1ec2b561a333513a83acc449b6b0e24601c67dfbd42e9db9b3135fba8de129780c1f650ed45f7560da4aa1380276b44a7dbdea9b625b8eeb06d48271eb0e7ff009aa65acbac96ebbc35b9d088b8a58bfaa437d9c688c9f040e6aa8d437754bd472632140a3b77ec73cd1a4a9a965e71f27e96d1919fc60d535125999abdc5a4e52e295d8e6a34a76773097f8b802587a5a38b8bcfc75e384e53443a6b745bc8878e16ea719f1cd30d0b176dd5ce38f4cd3e98930af28712afa8281e3f359b35ad093d8e4cb797f4b8ca827b1ffb5484768ad3ca483dc1a8b8b213284129ce1c4e49fda88e30c2d2d003dab644057b8bac3b322e6da50ea0a949ca8f39a1d9b6b7590a08511ed5632e185378c0e6a2a6db124138a6781cb64f1d606a588300cbe3b1b914f6ae5041943ea7d68ad332f37782e3c9276a08ed4923ab3a55fb6a952821a284a8edcf7e3b51cebbd1f1af305697500b89c949c76e38ae72bb680bc07a4460c13959da71e2bb37a7fd7b9d9405014334e03eb6fe9e61605872d58aaee0cebdeafa67de5c36863d361076a4278fde81d77e37e9887668dc12afa9553333424943f25a793b568249cf143b060b90ee7e8941212b00a40efcd4f9f7e75f77f7fadfda45c653835d63d8ec810ce24b829b94430e29fa06c5a8a7009aba349c78f7f8be91090400368ef4090245a1d84c471192cab392a5f07b55c7d14d270ee328cb62424a078cf914f78be3bea1d8dc5fca734bc7e235edf02046aee91caba7d71a3b89c7620544d97a3d7186fa1d7779048ee9c115d7d70d376b65a52d69fa401ce7cd41b16cb4adf4b6dbdc8cf039ab2ffa25191db7cca227f564d959150d812968fa2a5b6d0486490918cf9a12bdb2d427cb2fac23ebda3df357eebbb8d9b49d99e9f21694b68428952940678f15c3baabaa0fea3d55fca70331d2e9036f919ef557f5260e3e06390a46cce85e86f54dfea1b3dcf13e23adcbe754f4db4b2ba6375d452662589b1e225f8ca2f0fe6bcacfd1815c9d3377cc2d1c79ab1ef97b5c8b57a48754e03c9cb84a72477c55712ced5e4f7c9cd513870fe6de66753e49eb5ac05123c27f9873de896cd6f0b88e2c0c9c50d123d529cf7abdba17d3d56b30843ed90d125255ef569c3c06e48fb35ca9735cad5c5e11c9bfa512a89109c77280338e29a5b905370433b31c8e73f7aec9d4bf0ff6485695a9864075b4fea08ee71c5734eabd28ab3ea4650db25b4a9452329ee7350e67a5eee318587b06577d3feb6c1e698d347da5a560b7c4634e094a393b39191ed40b739f19f2eb291f5952876a3ed22c899675409aa4b4129e091f6aaff5a4581659a0437c2d449271560ce1ec71e8cbd6c4535e40b79075ecf7d482b6e9d2bbba1e71a56dce4f14692d809865b4a40006056fa68266c00f94f29c726b338b8bdc86d04e0f6c52a381bc616fc932c785c9586ff6ecf81072e094fc8a9b5a8049c8a1455b91b9452f03e71521aae7cc43823065481f7f228662c87fe60a159e7b7354dc9a89732eb4da1875317260a5054071dabd6347f34acf8a5eea82dc05b8b24e29b4474330cbc9ff0094d0a2b35f6613bf21337074ae5633d8d6f2492ceecf7c53065c2fbfbdcf7a92949cb29c50d60fbc2ea07522d4ac2f9f279add69dc0048ce690948567208c54a45682a38239e39a913b1a9030d191ae27041231839abff00a47d35b4eb2b01764809746424a7b82079aa225304679ababe1ff55bb6f9ff0020a7486cac1093d88ed8a5dcdd772e317a0e888c38c6ac5c059033a9da6eeda56e8ab2ca5a9d65b565bc73f8a34f870b3a66eaa8cc49492959c2b0338e6ba075d74cac5d41b27cc069b4ba5190ea07d4158e2847e1d342ccb26b192dc96ced8ce29285281fabc0f1de90709ea40943adc74ea0c796f1a0de19074675133608d6d6e3a22bc4a4a13c6de051d5b5b544801d403fa739edcd43fc9868a10b700c049e451747f485afd37968295208ff0015f3dfa83d4f7e66737ba7af29d130ec14e38ad6739755ae0e4bbc290a77d4da704e78a14b45ba4dc1f4b4d3654547c78a2dea2d8dd56a76cc66b2c3cbfa940e71cd59fa2f44d96d715335e284a8b60e4fbd7d7de95f5f70fc0fa5ebb53fee01ff00bce75caf0d91c8671663f4c13b274ae73cd21f7dcda08ce334590345d9ed677486c150193bbb66a5e5ea3b74265677a0a5ac84e78e7f6aab35875490dc694e21dda96c28647e2b9eff00f52fd45eb0cd38b437855bf98da9e0f8fe32af75d76636eba75374fe81d372d11cb0a96a49434d83ce4838ff003545fc3ce8ebb5c2e7275ede6195092e29c4eef0339045018ff683addd464b4a2eae130fe0e41238577aee5d1fa7ac5a334b2233ac2121a69209c63c73f8ae99e9be3f1f02d166539b1e57792cd7cb5f1ac7889c67f177a9a4cb930ac287d452e281d9c82003ed567fc3ae9b55a347372568c29fdb824738f354bf5ba742d73d6b661c40437197b481f51fd5e2babb4a5acd9f4e42824fd4da078c7045757f4fe355664364a2e84a6f236d884ab9dc9a4a463200ac8ce471586b248a50e135712044a2cdf7364851e722940a22b40370c9ef58ce3cd681661ac8a6e35b151ed9a4b7a7fe6159ce6bc544d03e8cdcab1fd42b5f5b1fd35aedac1428f8ac788fc4945866deb64f9af641c9a4f183cd614a39e2b5358693a5da9973de9ba8f24e296564d26a4e7b5645204905b115802b4c7dcd2cb41fb56bb7f15a9a809bb3ee7cdb4edc9c8e6b7ad070aadff6af988823e63d040137ec3f2315a2c1c771c56cb5000524b5e411589b03355281183deb42463bd68a2738ac649ac19bcd54a3cd26a5903bd6cb38cd204927158dea6409aac9278a6ee6ecee3c0cd38c1511b467356d747be1feefd457d12ee8d3b16d8d72a594e379f6150db90948f2630bc7c26ca60a92acb3582f57e989876486fc992b20250d272467ce7b5754744fa59ae749301dbbc8ff0073909faa02bea033df24fbd5dba07a37a6345c16e1592d886f81ea3aa4e56a3ef9ab1e0e9d65ac6594938ef8cd54b92e7ab705144ba719c21c6fa8994dc9d0cd47756ec18e19dc37148ed533a3d9614e25a991d2858384e53df156d3d6061f4281da0918fd18a18b8692f967bd7641de0fd27c1aa8b6558a772d2510a49f87a7e138c21cc0e476c50bf52b4f44458243c060049ff4a2fb24a488c88efab0a4f18a19eab4a5274fb8da0821791fe3cd4f56497ef717b55f54e1cd69a52e463bda963b24c76e598c55ff0051191fb54369cbc466fd20e2f054420fd8aabaaec9a323ea6e88dce21423d592ebd210adbca5633b4d71a18abb75d5982a6d6168742549239c8563fbf9ab3615beea1dc43c89355db5f89d99a1a2067a48f61402a5ce7978f25084f9fde8610c6eb4b320ab879b5e7ed8a34d36d887a29369de957cb5b03ae7d3d9c5f38fed43b7a8a20e8e62420606d273f626abf659ac9223fc63e54032bab1c35dc6e2f4c7d2a2af576f238c03e2ad6bc456e32a017b1b5b8e9ff1cd0674f151ae32cb453f438f240c8e793477d484a638294ac272d86d3f8ec7fd6a6b18fb8144c0601099437512f8ede6eaa447514b6c286d03db3569e8dc6a1d14c3cbc1758fe4af9ee315504b60352a4294ea54e1041479c66ae0e85844d8b71b1e465d867d21e7d4209c8a677541690d06c7b8b3e8c1772164494a141a415a9c491ee3b0fce6a6756bff00ed069bb25f96d25329083124849f29ec4d004fd4efc6bb3b05c3f446756dad3e49cd4fd8efad5d74e5da18195b0d09df4fdbf563f615aad67c43cd6db7c98ac56d2fbd12e28750701bc55c57e7c5cf4d2a6048dcfb29571ee07154959a5b72e434e0753b08239ee703bfe2adfd3ceb72ecdfc39e514e1ae3752bce057b8451f319e9c92dafb1ce07fa51bc4b833f4b648ce2ab7b495daef4a8412a2977714ab1c51847b74d71d4c94281450017a04c209d43388fa02929c0e79a988ea6dc180914350197829257ce078a9a86b03c9cd4abfc481cec47fb3048e2b28412a03ef5a215f580a39cd3d8a84b848f6a3501d4018cf34ca4a873e6a410ca023b526cc7fabf49a916d847a6723902a60245adc1b969dcf148a8cba442e32b4a53c91c1a9e7d82b78948f34a0b77ac85210db8b563002467358d6cea78b041e5295b3c32fead62d61484b8e2f67f3384f271c93e2ad4eac47d41a574a1d12ddfd2f5bdc690e2db8b2016d6a3cfe4e3da87b5cd92c164b5377192cba9bcfae3e91e119feaa8b993d536d41c69c2b46cee7040e3b56cade0753609ef306fb4a82ca0c7b9ce86afd041237793443a75d432ff00f0c7884b725071ff0042876a868b116edfde59dc1a42f2b57807353172713023b929e09fa524e7b700547e45db4218de28235d7d35b98cbd15ac19b19bc0f1b938aa874cda95fc7512640e1e75213fbf7fed4fb5aeae7a6dc19760ab1f34901b39c10738c1a34e97d80df2ea896a642949695f46ce1b5e7e934dab5f0ae27baef37d089eb470da2c8f3c792a4abbfb77aa8fa72b7275e4108212a70e4e33df9a3feb8ea9b7c43274d654b755c020763ed50fd12b5a5eb845692de77293b958ede2bdedfb74f94cd76f9dda596b68d84862738a51fa929e479c535bbe1cb99e0fd4ae292b0dd52febeba456960b4d34a09e7b10296f49e95a9234309dc73b978f6cd2e3d82631366e5a1a610150a329593b138a33b73285ba0f9a1fd390d288e86f18c0c628becd109789da401ef44a1fa604ec4b47be90da06298496b7e53c77a977d21038f151e504a8e7c9ad40d9dcca120f7072e56e656d9cff00a553f396db57b936c90da0a865685918abce7b5b505231cd515d466971f522264718584851c7b55b7d27c81c1ce5b3ed2adeb0e3072fc73d1f7f9139c3aaf71b85aefce391be969e567273db34e7a4f6fb55f6e2b93734a4ed19fab824d4eeaeb7b578665aa6b816b4f08e0517749fa6d6ff00e15fc45d7421c57e9000ff0035def0b16ce43345e34508dcf9b797ceab8be34e3dbb561d6e13dbfa4da7b50c90f85b68433c6339248e78a84d5f7d7ba1525bba4346f899c25215c2cd66ff00a8a7e8bb92cc4908710d92a23b78aa4baefd4f95ada3458296034dc5492a20e727c9a65cc66e271d4358a34f2b9c0f1d9dcddd5e364fd78e7e7f31f6b8f8b7d77a8df53715f5408a78f4d93c91f7a17b5fc466b2b5be1d626bceab9cfa8aaac223024b894fad92a3c669d4db72208438a5a4a947b0ae63ff0053722f6f987d09dba9f457078740a69a142c3fea075cf59750edcd5bee2b4c78ed03b8363f5557919a4a47a8924af35a38eac84b7d82b8a9cb7dbdb65a4adf511bbf141f239799c8a795877a8f38ce3b0b8bd538ea144928b214ec02159181da984db5dc1b67e6a44090cb2ae43ab69413cfdf15e55c130a56d4e14ca704fdc79c79ae92b9f567a543a2d73d3ea7c5caf1322a18891cb18f975950ca8938e00ff34bb1732dc37fa14b6e3acaaabb87893ad4e535303e67691e47ef5d4ff09fac2d515e16875c425c0a3c1f63c572f3a9517d7bb1824927d8516e8e85aaec3399be22d73db868580b7c32a0d8191c950ae83c3f22985723d9f486fcce7feade0bfd6b8cb7114ff89f4275b5fed902cca9321f4fa41254a5783c76ae22ead6b58974bbb4f5b9aca23b84eec7deba052983ae748c744ebaa8ba51b7217d8607047ef54febee9eda6d36994fa9f46d467628919271562f53599869d63ebc3f338a7a178ec3e132cd591b366f52274d6b254a6bd1702b7ad1b4103ed439aa2df29cb9a1585a82f904f6228fba2da2205ee3fcdc951516f3fb8ab5ae3d38b34853292c8fe52709e3c1f7a554f0b97ca6100e7a96ce479dc3e1f906f01f32b6d116670d9524b0a1b88e7145ba674747b85ea1c295bb121c0938efc9c71f7a2e87606add184565b0109edf9a8f5372224a129a2b4ada56525270463da9b8e34d78c28fb8121c5e645b7fbe4746117c457c34e85d33d2c6f5edb185c19ad4c662865d7028490b4ee52d3e700673c0e6b85dc7102428848ca14471ed9c57517557526a2bad848b95d25cc11d27d34bce1294718e07e3cd725b529e72e0a69690012727f7ae79ca71d6e23795877b33ad715c8559b5a941f126ae6a4c98a1a4f65819a613a2fcadad280a1927c7b53f763b8d2db1ea6edc33c547dfdd28690c7391cd29c8d15dc7c083f123e2057a894923b8a9592e252d241350f1559753dea4278d884039c9a564c311b423392428629ed99f403e92d63078a8f582a07f1586f281f4f06a4aba3206dee4ecd8c563f97839ed8a34e9cc3951a62643095ab6e09294e48a0ab73fea3412e9c91daba0fe1c2fba3ed6ebc353ad080b3b4052322a6bee4aaa62e362118959b1c283a96b74ff0058d95313e5ae7706db74e006d6ac1cd5ebd3985a72ded9ba25b42cbc7703807354d5e34f74b2f9284e872a0870f23d3776e3f3532e6ac8ba66d2966db250e25a410901591c0af9dfd566bc8b58e102a4ce81c72945d5877a9755d35542932cb61b4b613c6e20629d47d42c3e94c7339908fbabc573769cd5b7cbdcb71e765a1b6c6eca55dff61e68b63e96d59a8120b3732c03fa0a500135cf6de11ebead6f98d9b27bfa65bfa825e92896f1265bf1b0de57bf03b8e7f3552dcf5e6a3d473956ad176c73e506429e701493f8efc53773a35abee0e0fe2d7279e6d0728485f07f38a33d3162b9e9425288adfd29c0ca0927f7a6b85e1c7d20359e7fc4c35c0f6446b0b41eac976553d35c5a4a87d609f71e2aaad7fa5ae21b1a72dc14f3f355b4949c94678c9abb6fdabb55883f2edc64213c824507db2741b13ee5c6682f4974e7739e0fb0abe7a2e9e43372fcd74162de432556bd18bf49fa4d6ee9d5a112a4349f9a75256e288e79a5fa97a9da816698b0b4a590dee0a27b714caf3d6280db6b8e70164600ee3154775b7a90cc8d1b3598f200755f481f7fb57d75e96e0e8c3a8e4e5377afbce63cbe7b583daa86a56bd21b7ffb63d56997d74294d079402b1c000f35d7e8b8464213b9d184fd232476c62b913e1f679b3c37e5af85bca5904f1c9a2d85ac6ff227af73eb2dfa8a18cf8cd5f788b68ae8debb32af922cb0f8b4e9645c228007a832539ee3b52ed4965ce10e24fdb35cff002eff007321875331692192957352168d5d362256f89bea908384e792ac714ec146f8809a9d25ec0e700118f3cd29e97b28d561a4f5ecc7539b9a000b56120726ac9837787330db2ea14b09c9c1ac595b20f2d753424afcc5bd157fcdfe2b212452e003c0c56149c738a83cb73c2c0623b4fbd7bce32695c8f635809c9ce2b3b9b0b751229cf8a4d439c629d6cfb524e37835ed8dcc8b4c4540815a8492334a149c8ad17c702a4f9930b668a18f35a647b56eb4a87915a6d359d7e610b66c4f9b8119556e518f6ac1e066935ac8e73dabe592db967236661e58031ce6902acf35e5ac2ce4d22bc83c1ac4dc0226e4f24d6bbc035a157da93513826bc66e0cd9c7539c60d2790a34985655cd48586d52efb78876782d29c7e63c9690903c9207fdea1b1c56a5da4d4d46d70a259bf0ff00d217ba8fa91a765b0afe1b05414eac1c0273dabbff004d68f8165b6b312dd1d2d32ca02366320e3cfe686ba23d3185a174942b4b2ca10f06d2e3eadb82b52bdcfdaadf8b6f652d80078ff35ccf9ae65eeb7c10f4274ce238e4c5ac330ecc89896d09038a926e38c8dbc63dea4998490318a597092840294f3496b2cc76d1ad8c01ea4796b29fab07f6a6ef4769d494b890463183524e32a48e7cd3731f77d5f7a396b04411ec2a77b82f26c2eb6e9761a9432724508ebd82b4db14dc8dc7724ffa55b2867ea19cf1ed423af2217a3147a59dd902b63485f8917be18ea0df4aaced2744b10f68d8b0e6efdc9ae42eaf68672c7d7316e663ee8f364b721b007052a2377f619aedbe99472de996db236a9b716d907c1cd523f13b656acb3a26b9f40fa915871842cf7057c023ee28fc2b5ab2408b33955bb32374b6a112ec3a8eece3e16c190dc3423b6d4a78a929d0dd97d2e6dd09c9710b4a47e326aabd2efc887d08997049fe6c8bc04e73dfe83927f7abb2c0b4dcba491dc4feb65b240fbe285c9429679ff30ec5b355ea515d31bcb8ddfd7151d98713bbf3da8ffae172719b1b92a2957a8dfd00fe48cd56ba5e1aad1aca5b41382fff00346ef71f57fda8e35aba6e90645b9c50529f8a14de7caf39a2fc77729333af2a88065496e8ee2a2bb7194b2a90e23d4567c0f02ac3e83de1c8dac18295293b1d6918ff00a49c1ff5a10bd4610ed33e51212932845688ff00a5393fb537e8d5f037ace116f9f55e6f2147fea14e2d42f5684071cfb6fdc75d4dd3d36c9ad6f7216d2d3184e7d4dab6f70a208ad7a4b76653a9588d278664b6b8c5240fa8287635d4ef59ac7a89d71573871df6e4a4e4119fab3ff8aae6ff00d0b836dbdc7bee9895e894381d2c94e000076142adc113c4cf152f612252c990bb54a461ddc90fa99fc00bc8abc6db254ee9a6e7c7776bc121f4a93df779155b6aed01738770525072db8b0e71e39e68cb40cb71ad37f20fa4add6814942bfab1ed43e685b501118632907b84d0253178d97169a4b0b79bfe636939e479fb668834fdd1a0972238b0548f19a01b26a5705cdd82fc46627cb276fd278573446c2594bff003d1d5c2c72695329090b3a30eadd2cad6a400327b7353d0a3acfd6a1c9a18d3f1e43c95c9663b8e061bf55c0919294d195be5c790d04b272b4e0918ac523706b46a38622ef56ec6303cd49c2863f7ad195b611cf7a97b5b6dbc538e49f634c40d08bac23730cc15a483e334ecc2c209c9c62a51b61b1f4a4e48f14e2dd6b9d77b82ad701adef0cf7ed522d65bb909750764c0e9484b232319cf73da8aad96cbe68588ceb49505b763bc9d8c215f52493db23ef5a4297a674cbd3eddab627cccd7094b2db4776c3e370e3cd40c8bd5dae40b53a7baf34951f49add84213e004f6a91142f66096b35c7c57e20d75158775bbcfdd64c56d87dd1fa5be1231daa819578b8e9898ed924254e34f93b07b1abeb545ebe42239bb09090739aa4ae5220ccb8aee93140fa472907b1a1ee61bd88d30d485d18ac1b530b4b4d2d250e4821d7fec0556bd7dd5698d15cb6d9e4a50b4242783e31ce68b3516b06f4fdb1eb94a7bd171c49013c6718e07ef5c95ab3594cbf5e9f9ab70ad2e294903ed4671f86d73796a05c8670a878ee4cdaa549bc22d895ee5965f2a249c646781fdeba93a5576956ed3d72d477048f50b7e83381b70318e2b9934786508617bb049fa36f2726af8d497a8f61d1b1ad287804fa654559c654534cf2468845117e33123dc694af50263b7ad56e3e56a51714a51e739e7b55a9d2f4c6b0599f9aeab0bd8769f6e2a9b2f0339121d582e157d23c9e6ac0bc5d536ad3288deae14fa41e3bf22b5b176a124b8ce03b3c57415c9d77a8cb792eed44a5290a19e0827157068e605cf5b49583911fe818fb573e68e53addcda94cac839ce7cf7aea0e8d5ac3c1cb8ecfe63ce6edc7c8fbd03751e03e21555a5d499655ba388fc01ce40e68b6ded86990a2082698db6d4a79e0b7123681f554d96c0c0c7e9181f8a8d468684f7912632918269b140c938a7ef348e48a68e271c8ac01af9992d22a7a7292781f9aa7f54456e76a47470a4b71b71ab8a727283938cf9f635535d94b8f75bb29bc2dd4440a48e31de8dc32438220b92c0afd5f13937a9522e502fee468ad92da9c3e4f7cd58bd329bac9fb606a1b492dedc8c0ed8a8ed72d448ee9bb4e64ad61449424679a96e987542c16f8c634a75a614a529237718afa1fd17940a8f71f5d4f9bffa8f87affb54f96e237cb30d40ebac5c6786e4ad580d83f513f8a10ea6fc3c5fad9a7c5ea0ad721929dcb4ec394f1f8ab2d8b05aafba99abe479a30a5858215c77aea2b059edb7bd34d419296e425c400b0790702ad19dc6519885ef1bfc19c7f37d697fa57dab69ed7ff2046b53e3fbf164db242a3bc8536e21447358f5dd75490adc402339afa47aff00e0db476ac92fcd86dfc9bce127f97823fb509e99f809b1c2b82245cee0ec969073b163005524fa3d85de55d83c0ce9f89fd6bf4e5d87e56b157d7c7f33864c092e1414b2ac71ce3fcd74e746fa0fa7b54d845c2f616e95270005e304f915d297cf84fd132b4fbd6cb7c34b2f847f2de0919040f35cf3afb477527a456c72031777136ffa8a1d6b23271c0a7981c3e2f1a5adb079f5127ff5168f5728c4e2f23dab41fbfdff00c4a4b5a6806acda92e702d07d58b09e521b56779cf9e684dc8ea655b7764a7b280efee3bd7427470da26c079fbfa9b77f9ab75f2b4e54b18e7f7aa6f59c7b7b37e9c8b524a23faeaf48118e09a56fc4326f3175e0df0274ee3f9e5bf580fb6b107d4df982e870890544038fb66bba74bf5aba387a3775d38990edca7ceb2bd022dad3130532d6309714af007be6b85520a1f3c8ef5d39f0c5a5adb78612e4a65254de4856de4fd8d0afe985f50b2d6ce5541df5f30fe5fd4e3d3384d96cbe5d48ed15d2fd588b28910eeb2e390918429448ce39fdb8e284ba85a5b5b0648b8bce3c86c91c9e0fdebb35db4c580d7a11db48401d82682f545862c9617ea476d7c13850ae9567a7f1c600a6a63f48fbcf9fb0bd7b664f21efb560063f8fb4e4de9a7531fd0b24c57c29602b0477c55cf07aed6498b41909285286307815485d2c89b4ebb7597db4b6d3ce9da318039ab064685b5cf603e83f514823c522e2aecea41a10ec097ee770b8acd0997903f70f912d787d48d3939094a2734827bf229d2ef56996a4fa329b3bc7bd738dc345cc86b52a24c5b401f0687245ff53591783356bf4c948c9f15265f2ef436b2160f85e9cc761ffda3ff00b197df51cc65d91f723ba1794ab201e7b572a3711c1356bc1c95103edcd134eea85d6544540755851c8c935116c59795959ff88acd52b98cdaf9020573a270181660a6ad31d34b77682e6063819cd415e5e3225ec1c91c62ad9bfdbad16dd1899895252fb980011cd532a2b5cc7144f75673f6aad65d4d41f16969a6c160fa62f15203a0123f352179da975940ff0093353da7b47ff13604f4bbb42464a7deb6d4da65e61099485052129c714a3cc6fb8486fc40e2a15e07e938ad5f4290a29ed8ad13bbb935203a99dee3fb4b8a54c4a49e08e28ae14d9109614d38a03cf38c5064073d1968593da8be3a0293fcc07040a3295f714a99e0cca7624b8d57352a4a7d6c11e7ed5227a9d72891bd04bca38edce6812e27d37c9655803dea29f92b5704fda91bfa6eacbc8d141dc2866da83b69608eb76af844aa1496d04762539a9bb37c53753ed8f075b9cdaf1c60a8e08fc553ab4e703c9a4d4829ec334f2efe9b637b605a80eff3354e6ed43a0675769df8ddd5ad212cdd21320e402b6d47247e28aa3fc5ccd9e77e1433e3bd7195aa3bcfbc1294948c8c9356258ed21080a2fe78e6a99c9ff4eb8ac6ecaebfc47187ca64e49f159d0f3fe27ae529bf4447493e38a14bbf5a2f9724ec01294139c0140288eca3054e03e3bd384259000041fdaa0e3788c5e358355b11bb6164650fa9a4c0d4b72b838a754e11eff5556bd4ab9aa74c8b0db7d6bc9fac6ee37678a3392eb709a538950031ce3b557101bfe2da972e8dc9f5309cfe6aff0089cce87b6c4c479bc1b21037d99686935260d9da6d940dc003c7bd4eb116ebea2551e3a8a17e51f7a8a80db719b4a503180053dff6b2f16bc2598a87424829e6af1c2fabb8ea40aaf62b01c9f4ce4952f59f9964d83a7b73be307e6f7b580369e6a72dbd1a90cb6b2fcde49fa405557f69eba6a88aaf4ff85008000077f34616debecd504fcd5addfbfd42af557a9f897ffb770ff732af77a7f9504f88846c74cae31e0ee6a590ea09c24f9a60d45bbe9a9497248778567233c9cf14ed8ebd5a0241930dc4abb703ff00ad397faa7a32f11c890e14288ecb1da9a6373d80c746d523fcc5d6f0bcafc1acff00c43ad2d7e4dd23a43a405818fbd4f9403e2a95b46bab242ba6f8afe1a247255c55b765d4b6bbab2871896caf239014339ad2dc8c677dd0e0eff06077f1b9940f2b10ff00c47de8fdab553447f4d3d43cc399085851c761deb7547ca4ab91f6351fbbf6317f9107464706ce7b568e36734ffd1e7149bade0918ad83ecc903c8e5239fc524e24ffca69ea9b20f229271be7cd4caf250d192f9f15a60fb53a5a00cf1496dfb54e18493dcd4f9a2e39c629152c9f35e5924f1492b35f2bcbc4d944524e127b564e4f9a454be7f359137dee6093dab5271dc56e479cf7a4d7c578cf0f99e0127ec0d5f3f083a2d3a8ba8a8bdcc614a8d696cbd9c7ff115c0aa112412126bbe7e0bb49a2d5d3b379718c3f787cb8491cfa69ec47ef48b9fccfd2e213f9962f4fe27ea7241fb09d2d658090c2308c71cfbfda8863444ed03148d9e2610924f18ed53686024702b9097363f91fbce94ff0040f11f68ddb65281c8ad9433e38a701a39c715b08f9f6a614c0dda47bec25401c535f4003b70339a96f44951484f15810939caa99d43701b9a45060e7849a85d4b6f0f46cf91cd16165209da7fbd3797010fb452e007f144f86fe6042cd340ad2719509f9d10a006dd712e273d81aafbe27ac28bc74d2e48dbb96c243cd8f6db93ff006ab6df86583b91c60e4fed431af6da9bf58a54028de5d8ab688f72526b745f0ee696b0b2718465989d0e85114a48f5eee5407b8083cd5a3d1dbb873404d8529c056c85613fb71546ea3ba1b568862cf217b3e494bc67fe6dc413fdaa6fa3bac8869c6d4bcb52585abf2a48e051b6631b6b0da90ae4846f006382a755af52c25b49697f4ef1df38c63fcd4aead65c8d19b9a9252e45c240f230ae73417adae170d3daa2dda81b23d04ad2a71293c281555a575ba59b51dc66a62a902348650eb49e39c81c7f7a82d46521b50fc7bc30604cab3a953bd4d216d115b1f538e3eadbe4918c9a11e8e87256af81299002197d4e1f6da84ffe68cafae21b6176f7a325d622fd05b3dca01cd42e924db74e5b2e7a8222b0cb115696d3ece399181f7e69bd2de758062fb2cd584ee581a53a9f758b7e4c3f980ea1e905284acf03eac0157dc45ea1b8c70a9886d297103604a7b03e722b897e70ef44a61ff4fb2bd41dd2a2739ae97e8875e61ded96b496a54263cf65188ef02007523c1e7b9a86fc3257626d4e6af968c96d736b5b090e9395a783c505dadd36fbeb44abe850e478e6ae2d630dbb8465388467760f6aaa6ed677d2efac96c8283907f14a5b6bf4c7b4581a48dfb4f2a4c90fc08ffce9612124279c9381fbd23698d75b15ed362bf7a8ca9c4ee421ee09fb8a3db2b0cdd74dc0904e54f35b5652705247dfc56912d52265e1b6af0813d8747a2d3b24e16c6781f57803de85bba1a1252c24b44ba4ad3d05c91150e9905a0decc7d0b07fe63e29b58f564317153bea2507f4a93b8f04f7e3dab69494d856ee9bbe20171b056db8dbe1d0b6ff00fa530890a36adb97c8830adea8ada949b81752da8b607d4928f3c50f4f90305b1f63b964dade9f7a5a3e46338a8feba63b8f84e5b6d4464655dbf6ef561bda76dda6aed0ad77ed576e881f692e05257bb3b8fd877fb1ae75d269bcb8a72cc8bc4d6622df0b534c3c52d3ab4f01cc0f3f7aba2c5a3e0c982845c2387ca500254a19513ee493de9cd2363b11364a93f0616cebce9ad27a8da7622ddd48c109da96c61a19efb8d62e6fdc6eea55c60497ad216b2b4371ce0a53edbbde87a35bdbb739e9476ca120e080ae0d4fa6e6cc78fb5679da47353923e2435d2dd1683b3a234da96eb8b52de3fa9d59fad5f93e6926bd0690a71c56000493495ca629f90a524129073c542ea2bb9836f2903ea58238f6c50ec631ae91f6805d4dd511243a61c4415058233ed55fc780b92b05492402081f7a999a837096e2f193bb0062b3aa5f674269295a8ae1869c4b6a2da4e33bb6923fcd40959b5c28127761421339a7af9aa36de1cb2477429119385af3ca89f1fb55181f5a82b69e0938a9cd517976f376953df737ae4baa5a8f3db3c534d393e2d9a726e12ade99a908527d3f1b8f6abd60e38c7a81d4a1e6de722d2042cd1d74765dc223410969115230079f72688b5eeaf70c46d84b9ea02bee4f038c547688d3570b85aee9a8203001095ba96d209c0009c76ed417757de72235eb2b2a70ac907c1ad1aa47b3cb52616b257e24c7fa45f7ae7a89a4c870a86e079f033443d42bb3abbd376c65d3b1809071da87f452531ee0ecbec1b46727c534b9dc5d9b7d72470adcb3fdaa3b290cfb93576944967e9092cfaad4742b2ea82702bb6ba276b69cd231e521215b9452563b6477ae0bd26eff000c82eea09aa08d808467bf1d8d7667c1beaf5ea8e9e4c65e7015c09c5013ff004a8673416553f4ee178f91f612fb6996e3b6027393deb0bc1ed5bab9c8cf6a6ce2f00e6926f518a91137083cd337c80aefc52ce38003fde984b5a94dafd3242b69c1039ce2b61f54f39d0dc14bf5fa441bddb202f688f3c2c151ff009c76aad6fab989b8de96dec0f2d84a52143fa42b069e0d44f5e2f2fe9dbcb21ab8daa5fccc75e71ea360e78cd45751a4ae2de9c4c390940523d553a7901248c0a7387501dc4f93775a80536dcd4f98c31736c169e7129511db938352ba53e1dec72ae6a932d283196fa9232a23391e302a32eefc892dc25b8ca997db214ac7d25593c1c55836ed513d0d5afe5237a6809214bce429c1e6bb57a09e8b18d367cea707feacb67d38a2dc16d7e4c19eaa74519d0f6817bd3178910ca7050da9cceffc0f6af74c35ff00572d6db3199b47f1469b20fd190a22b6d5e35475075540b74592b5c76c246d4f9c1e78ae9be9c6858ba66cf1da7908327602a3b6aee72fdbb08653e227cfdcaf34b8bc6251c9aadd6377a23b03fcc0fb4f5a644450675758275ad7c6e5b8d95231f9028f2cbaf74cdf503e4ae2c3a48e0058047e41e68c4e9d6ee8d165c8cdba9563e95a0107ed4317ae81e9db99323f822e23fdfd682b2d2bfc7143b66e1b9d38d19456e3b17387b95d2e9bfc7d4a3fda3d5cc60a4293b559ed8355675d348ab52e9d5c18ec879f79586d3b784e7cd485dfa2bacaceb2fe9cd79359d9ca18b8325d46476055edfb544c699d52d32efadacb4ebb72611da4dbc85a0a7df6f7145e38a9bbadc107ed3185c55bc7642e5e25aaccbde8ed5b7fe0fcc61d0bf85eb5dbede117e612a7de0a2a0a4f6cf6c571f7c546888ba03ab578d371508f4a2ed5a36f64ee19aef5b6f5bb4f3201725aa03e84e0b7232823fbd70c7c566a2b46a9ea148bb5b27a64a96c203ce039dea1c52fcec7c94ac96e907da768fe9c7339bc8f2ccb9d5b0723b3f69cf8eab0b2a15d8ff0a51902c41c18dc504d71d3c06e233e6ba67e1d7a9561d316af97ba4e6d921bc6575afa69aaaee624eba9d2ff00a918b9393c21a7197c8ff13a92ead2908e076ef8141b7794d24389714120823eae33c5026abf88886e8722d8214a9ae938496d2424d57936e5d61d6ae6625a97058741c297edfeb5713c8d5526947919c3b85f46e6f88b72c8ac7e58e8c85eb745b63729bba32e27d6695c8047350b0faa10235ad0cefdcfb69036a4668a9bf878d63a81a322f13df2ae4a81071fb669be95e8e5bad7ab5566bc94ec50050543ea247ed556b2be42cb8d958f10675fc2c8e1ce20c5badf7193f12bfb96b7bfde1c28b7c0788ee0ec38a63fec7eb1bf380bcd1485f3c0aeb08bd34d37691b5a8192903f51e0d624daa146003315b4638e138a8df82bb24f964bee7abf56e251f4e1d7fef3952e7d289b6f84a952f705206559141901c705c9a8e140042b68fef5d43d428c836793f4e0e08e4fdab959b0a1792b40384acffad56b97c0a30597d91fe65db81e46fe4d58db0db5cca7a4daa2424655b80381e2810b4b8e4852467efe68f2704c8881eeea4b5b413d8714133d47728e49c71cd26e5bc58798962e3c94255a4a582f33a33a1a61c52507829cf14ff526a194e2d30d390809c9e7b9a1b8323d2712e6470456f3257cc3a16a56481835512818ee38e846cf385d576e6b5008adb6e4e456e94e12546b60353d1b9c8742b3da8b235d23ae3a52a5ed38039a145f2aad90b527c82051943f81dcf420b806ca77a560e6a0d670bc1f7cf1595cb79690838c0ac3292e2f1e49a634e62ad8a40fbcd5d7c8454a92a20806958e96c92a714001ef5996c184c871e294e46473506e487de59433b8fe2ae7c8739536285afb6d409286f3846e5e22c00034b4934a35d4290c7f2d964703148583a6fa87511f523c5736719528600156469ff87e94f252262d209c6723c554d384cfe5ff00f13a31ee38baaeea12bb73a8776dd80803db834bb1d47bb3630b00fe4574158be1af4e39b4ce0dafdfe93ff9a283f0b3a0e4a029a4b01407239045582bfe98e5d958fac2ff009870cacf07a9cb923a89367c731be5800bf34dac1a8516a9266bc095673b7156175a3a4963e9f478ee5bdd056f2c84a41393f8a5fa73f0ed70d7d69fe2489521bdc9e363648ff3423fa033c5e68e881f7907eab32eb35f2448663a9f0c8016d287bfd26a422ebeb34856e714538f706895ff00839d521b2a897059e4e37347ff00351533e13f5f4549f49c4b87dcb6a1ff006a8727fa6bc92ec2007fde37af3f3d146d091178dabf4fb983f3ad83f9a906b52d9943e99c83f82281677c3a752e1151f926dd03b61c23fed50eff0047fa970b2156591c0cfd0a2695d9e81e5507fd93bfe24dfeb7915feeabff00696cc7bc41789f4a5023c73526c4a8ee8090e249fdaa817f4a7506dfc1b75cd041f092aff4a445c35ada5454f226236f70eb6b1ff6a517fa5b95a01f2ad87fcc9abf52aa9fee57a1fe2748252bc05a10163db22a458b8c8b71dec3ce34a48cfd2b2315cdf6feaaea384bff0078524b6076f3fda8b60f5962cc4a9a9a421400191c1a5431f92c271e2cca64cfce6064ec3a83fe44bbe1f5d350e9c5e5e7fe69841e52bfd58fb1ab67407c43699d4ca4c5972531de501f43879ae3697a8da9abf51afad0a191f5546fcfc869c4b8cc85b6acf0527047b574ee03d5397585ab3b4cbffbce7dcc71b8f96c5aa004fa6502742b8b61e8ce05a54320822957238dc48278ae27e9475faefa626c78177965c86ac2415727bf9aec6d25aaed7ab202265be4a55ea2012135d29192dac5d41dafff0012817e3598ee548f88e9c6140e7069171ac1cd4bbf1f6819ce4f8a66eb2467e935bd76861b901b35235c6c1f1497a54f54d90794d6be9fda890d3c1c99f2d14466b45115959e4d22a26be609d1e6c5431482fdfdab6c906b551ef5ef2d4d80982be0524b5722b7f029159c9e3bd781d9d4cfc08bc28eece96cc48e82a5bea4a1207b938afabdd1ed36de9ad1d66b1b3da1c36d1db9f04ffad7cdde806985eaceab582d61bcb4dc93217ffa5041e7fb57d57d370832d253b318ec7fe9e315cffd6194420a84e85e92c6f14f70884f6f6414a54063152a1036d3580901206314f0f6e08aa252bb965b9f5d1898460e6b0af606b65280069339269bd4917b3ee2884a47249cd61601ed580ac522f38acf14caa1a825a773552769ee2b55fd42b50a27b9ac2958192688813091efb1bd58073cf9a88996d2e12a008078e2a6d677138ad549fabbf18c9cd4806c891b1d09f313afecaacdabafba6dc00220cc5009f242b9cfe39a08e9f6a755a652580a2101636fdb26acff008d5b62ad1d6db92821413718d1e41511dcec39c7ef5444790a6087118dc8fa87ed56dc4a55a995cc8bd92ddcb3f5eeab66ea82d34809721a12da813c2b3dcd69a3b58a9d430c97b6bb1810819fd43da84eeb6fb9b96f8d777e316d37241f4893c2d23cfe285987e65ba47ccb64a54838383583868e08224a998d59f2dcba97795bf772a5b43f9a4056eec067934cf5bb2e47b77ca5bca7e55c5053a96f053ee0d08c5d7515d8ada2e31372d380a5a55dd3e7352f07535a3784868ae2bca4850dd92919e4f26a25c4357da4dfac161ecc8182ec96b30dd2a4ed39e53fdabc9972a3dc10a69e5475a140a169385039e08346baddbb54f2caecb2237aef200ca4e13f49031ef9a03b8bab4203729b4a569183c8e0fb511580df499a39d0f206745f4cbe2123df184e99d5efa589a801b624957fc40380957e6ac494db6e3c7b94af807208208ee2b86da71a4bc1f6d7b4a3cf91572f4c7ad2bb64966c37f7b7b2f2806a439c9467819cd0593c783d810fc3cf6520133a4ba57254f5be45a5c3ff00ecaea90493db9cd1cc08dea0794fb41495a8276a8647f6f6a1fd0f678ccc5f5e0becc94cc59743adf3bf23fd451aaa1bad213b41c819ed48acc7ef463f5bc30d8304356c086cc9872a2c36db71c252e6cf6dc2a0858614b9295bf0597169390a29393460fdaa5cf9654ea0ec47e9a76cd9034a0a08eddea118fa3342de53da66cbf2ee32a00252d8ca5291802adcd3ef04b49428f38a06b5305a6f27bd12db9c73d440071da8a41e23507b17c8498722971f505003779a6536de4139e478a94438a382aff1597bf9a82923c715b91b134523e208c98be9eec24f63415aa90b7961bc118f7ab2264709512a56050ddca130a4ad4e24120f04f91f6a8593aea14ade3022cb618f1f75c65ed4b493924fdab937e2a3aac8d4576ff64ecef8f93844fa8b4abfe21ffe95747c4575761e8cb33b62b32c2a74805230a1f402319efe2b8567ca7674c764c8714ebae2d4a2a3dc934e78bc0f260ed10f2d9de2be0a622801c2a5380956404ab3d87bd14d9d16a9f68b6e96b75b8ff1897247a8facf73bb815ee97c9d1d135546775cc85b36e4b6a215e99292e7f4827b63352d69b0df2e5ab6e7a83494453eddb9f54b656d2784a7be791db029fdefe23c5620a10b10c64f4d93af3a3d6e75b88e30b88f23d27378050a0b182904739e7daaaab83eb931cc85610a512a00729c93935687503ab972d65608da52e7a65b872e3ac216fa1630e2bb0c8c500eafd3172d292d16bb80c38a690f148e46d5722a1a0127b93646c0895925966d735c20e5cfa538a6509971f9e852b29460926946ff00956e0da540139269bfcfa58694d25473dc54ded127e269ee80a01849a9af805b98b4c758520005583dfed5d19f009aa92cea2bde9575d0944c61121b4fbad039ae3f724a9c24939ff5cd5cdf09fa88e9eeb5d808386e52d7149cf7de38ff005ac64e37f64991d19056d004fa6bb95ba9b3cbc0c66962b383b8615e698ca7307cd53ac4d31968acf90dc49c701cf34c9f792942967b00735a489052a3c9a6dea7a830ae726b41d1ea4b60fa6571ab91a47504a54ab75e230bbc24a9294a55b5cedd8fbd035ea4ab51372223086c3ef065256a3fa0363ebfd89ab8a5e9ad2eebab946cd0cc8ce4b9b30acfdeab2be58556abd4f996e790dc38584a9b50c051577483ef4f315fe9d44378d1ee416a38edbb648174ddb9e94e86f246309476c7ef494fbda6c3a4e636a707ab1a424b1ef8239a467ca43ca663a64a511e2c8f4db493c151e4e2a551a313adafa34beec7cd2b7a15e144273e3c55e7d2b917d59416b3a26527d5d89465f196fbc36146ff00e229f0fbaadbbb6a9326643c36b036abca4e7c5762c3092da5631850183f6aaa3a51d2cb5e8eb7277c26c3e805b5653dce7be6ad76004018181c605759b8b788527667c17ea5cfc5e47946b7141f11d7fc42ed3de9ef4827c8e28fadec32ea005379fcd57fa70a14e24f0315635b32509205537953e2e675ff0040816d0a0eb5fe22cf58e1494ed722a159fb50fdcfa77697b2a8ec8654a39ca4639a346944a6bcea411ce692d59b752db5633a666fa6b8ce42b3fa8a437fb68ce7fd75d14b3de63adbb9d9624e4e0f76c05f6f715f35be2efa476fe9b6af8ed5a595b0c4f8e5e0d28938c2b079afb2b3d6d30da9c71a4ab00f715f32bff6954f8f73d6ba664c18e19698b6bcdac01fa895f7ab3e0f27919686a71b1f9954e1b85a3d3dcca0c5bca86dff006cf60fff00e4e089394b8402300f39aeb9f859e80e9bd676766f7788fea0753b86f2702b91a51c4a57b13dabe8b7c1590ee838a824edf48e07b734ef88408d638fb08fbfaabcbe5f13c01b7118ab13fed2cbb4f43744d913ba1db19052319091cd48b9a52d50527e5a030803b129c9a372ded4e076cd445dbe96d5dbcd36ab26d77fa8cf90ade573f2adddf6b13fc9ea005da1b684a9212903ec7154deb0b034e5f5bb8a4943ad9e08ec6ae3d433198c85975c09e09049e2b9efa83d434427c88643ab0be01c638a6d9399562d7bbcce8fe90c3cbc9b80ab7dc396ae6d3b152975c429eda02f9f6ed50176b8446d2a5add4607dea8fbe6bebf4b59744c2d273fa529c628625ebab9adddafc85293db1bbfcd53b27d5d4a314ae77ce3bd0792407b8f50fba91a8233b05e6d823041f3f6ae7f8b11b1254e129dcacf3f7cd11dfb51b8fc456e56720d08c59c4ab047393550e43956cd706748e338a4e35342123cea136e5212b1c9a0eb8f29501df3cd4e29e2a6f1b4e2a1a7a0eec1f2683e42df2ac011ae3d5a1e463361381cd28000aec39ac001238f159ce4e6910f88618a80056e900a7681dcd20558f14f184ee470390335e9e1239f052b2315aa49c52af13ea90a15a2863152afc4ccd4034b33b9042bb561033d85394b454904a79add46cf533adc8a9f2654a901ae5613db9ed467d3e81646e7a1fd449096c608cfe690d3fa5fe69d726bc83e9b7c9fbd6f319436e142301392003e2adfc3f19ed7ff00737762495e91b66747e9ed5da21b6530adea65bc018e01268c21dd74fbab4a7e610091918c572f68a84a917047d440e0d5a0cc02923695f6c706af35fa8171c6801d4b162646c74b2f8b6c8b3b8425b943711c73e689ed96f65c694fb6f20ed19c0ee6b9da0c99b0d40b4f3a9c7ef4f2ebd40d4962b795c39ae97160a4271f6a7d8fea4a2f4d6b463ec6caa90eec5dfda437566d72b5ff00542dba56180e2585842867f4ee500735f507a15f0d7d31d3fd3cb54476d25c9ab8e93208947be39e076ae10e8ef41b57ddd1ff00bc491716dd94f7f3021e6ce543be2ad793d61d6fa2de4c27a2b919e8c4a03b1de5a7231818c1a079da3239bc70b8367b6c3b3f6266f7fa7ce4a3d8afed933a2faa9d2bd2ba64c57ac0a723a9d277325456a03dcfb557aedb196538242b1ee9aad53f11d1ee2e21fd40ddc5f967e92a730e1c7db71c8fda9fc6eb5e979a7eb72547f1fcc6703fd684e3f0f2f1ab15dd61723eff0098ff0086e368c7a4265dc1c885ebb336f8204443a413f4fa49552bff00bb5bb4f8a668d0725f600cee6d848c8fc669c74f3abbd3e87a819766dc99536a3f5158c609ae89b7f5e3a6ab8fe9439ed946dc650b4ffa6697f27cb72583604c7a4b0fcf7ffe22ce6af6a1bc30e9f31f99c992b45e99495373f4d2a3a86721692923ed8c541cde98682ba85b2e5bc24281079c71ff00cc39ae83ea0def4a6abb925eb6ad410904a95c727dea7349f4d341dfa2ec9735994f947e92bfa93c771447fd40f8f8e2dca56efe47e26f62e22622dd92854fe009c35acfe13fa7f7f656a82c36d3e41da109d8ace38391deb9dba87f09d7fd32853f695bb2109cab614e781f7afa8da93a4ae5aa5b9f2a4bd1724b673ca5342f3346b6eb4a69c8e169ec414e78ac5afc5f2f57f746c1fe346787a678ce4945f4d9f33e3acd877cd39214c4d61e6969ec9582302a42db7e53bb5b7405295e4d7d1aea7fc36e99d5b6f782a1a1320a0fa6a08c10aae0eeacf466fdd33ba386447518dbc8438338c7f6aa867fa79b094df8c7683ed2b3cbfa4f2b090db51f25fe23242814a4a3eaf207156b746bac375d1b75621497898aea82482bedcd5016aba2db7425c2769f7344ed381c295a158ce0823be299fa7f95f69c7fe93f2273acdc5f717eb1dcfa85a4eff0b54da9bb843752bde8493b4e7f3522fc6e0f06b927e17baa6e44b9234bdc5d1e99e10a2aef5d8e9693223a5d46e505277050ed575c8514b0b13f6b7c4a365d4d45841902ec7239c1a47d03ed536f45c8a6bf2e7fe5aca5db1235b06a7c9459c93492bc528aee6b457bfb57cdc6752d6a264726b5577af289ce693249358d4c89a2d7856052256412735bace564d278c93ce2b049066e836c019d4bf02fa6152b545e3552da52840610c32ac7f52ce143fb57d0db334a2cb44e41c0ae57f82bd2c8b3f4d1998e36af5eeb25725648c7d38c035d696b6b6a138ce315c87d4995efe632fe2759e168f63117f3261a4ed40c52a09cd26dfe902b6dc01a518e08337bceccf2bfef5ad6eae6b43c7734e2afb4018cc28ed1f9a496a19e6b67969c601a66e38738cd1c9066ee6ea3c9c568b5f1de925386925b8706a712061a9bff00552852927b8c118a6e9571c9a508053c1c66a6491b006706ff00ed04b706b5be9fba91f5cbb7ad3fff000ab8ff0015c96ca941d2927ec0d76dff00ed0eb60547d277600fd2e3d1f77e46e15c423fe22ce7b55cb8cd3552ad9e3c5e17de35aa6eda76c36230836e58995b29773c2d2791fbd0d3bfce04a940e79c5352b51238ed5b8788fe9e6998ac0807b8488938d04125438fb565b5ba920b2b20e781f7addd0b5a79c5251d27d4d8ae7271deb6751e3f1301cf9439e8f5f2c117a89637f5ab4976cc6484490a1c242c6327ec0f27fef459f14da3b4fe8dd7ec2b4a4a4c8b75de3267b6967eb48ce4029c738e28c3a7dd2cd2bad3e1da55f2df19b37db74979b96fe7ea46065231ec4719a88f840b3e9dd41d5a8cceb19e99823437516f8f2ddde87978e1be7b018240a5c40dec43959997528061d51c91e7b1c79aced214549715f5790acfed8f15707c4ef4dacdd3eeaf4ab4d8a5a7e4ee2d8969647d258528fe9fb73dbc50e6a7e965cad5a2adfd44b4ca4dd74f4e4a774b4a42571ddce0b6b1f9fef44a78b7ee83b97abe212f48fe2235274c1e6a315ff10b5a960bb15dfe84f9d873df15dc3d2beb274dfab701b76c178422e0a00b96f7ced712477c0279af97a769e52385719cff00a539b5ddaed64988b8da674888fb0414bacbbb5c4e391f50ff004a13238f1676a2134724ea40267d755c1682ce138ee71edf914d9f6da4952328e38ef5c43d3ff8dfd7b6461981ab2d71751466d0101c27d290903fea1fa8fe71576e95f8bae956ac7531e6dca4d964af00b3351f4057b050cd25b78d7ae3da7914b07ccbde3210118152d0768503fb50b592f56dbd44136cd728d399233ba3bc9571f8ce4511407d2a4e013b878c507ec329ec43d6e565f9846ce368c9acade6d29ce704838f7a897aef1a0325c94f06db0092e2fe940fc9354ef527e2b7a4da150ec695a8d32e727290c434fa841f627200a9571dac3d0839bd2b3b265b572b834d652560abbe0d51fd6aebb693d050644755c587ee250432c36b0a39c79c1e2b97faadf19baa757a1db66938eab2402480b0afe73a0f9cf8ae7b993e75ce5b8ec992f3cf3ab3b94e3854b513df27da9951c613db88bb23951bd2193dadb5b5c757dea45de638a2b5ad452339c24d41c4d8a750b919d9bc6e2319c679c66a69ce9b6b98ba78ea9734f4a45abba64b88290afc679c7deaf8f84be9be8ad69175139a95a8f365b586e330e8fa9092397123b9c78a7202529e2b12316b9fc9a36eabff00ee96e5d1fb1ccd1088dea35b584210a1ea7a98fe66e1dcd44f473ab36be90ae65bb5ad824fc9dd309f9a53477360704807191cd57fa8ecf034275565c35b4b9506d5730eba8436a295361409052060703157cfc40eb8e956b5e9ac6bb58254376e4eec6a3309c25d60e3385247e2843b2766168c37d4a5ee96795d57d7177b868384b546420c9048db8403fa88e71fb50a6a89fa824ca117504875f91107a39713856d1ff8ab0f43dff5ef41277f14b8e915887736c21d6a4f75b25408293e0d03751f55b5abf50cbbec58262b4f11864e0ed3e6a6a77e5d48ee6fa4930525ca75b4008cf1da9b8529c4fa840dc39acef2eab62ab49aca9a40534be7b914c9445a5c99a30ea82895a4633e2897455e5564d4b68bab6e6d54394cbdb87fd2a19a1a6492ce560669cc324a89206318acdc3cab2b3d592ac0cfb1368b8b172b544b832bca643287524794a9231fe6939672aef559f41356ab5174ab4ecb4acacb7112c2ceee7724ff00e2ac471ddc82a27c551328057225cb14eeb0644dc9cf4cee2a18cd231dd0ea7209c138e0d476a999e93070ae4562d8fa830904e7701fe6864e8ee12e46b521f51da2f0ddc7fda0b5de14d140dae4677050a479e7df1412cdf24ead7e7b76bb4a6425e7f738face1b69c1c13c77fb71455d47b7c9b9c4105ab92d865c1b76b630b749e368ff004a92d3fa6e169bb2330220d8b4a32b501c927dfde9ae3b78c4992360ca5b54596f3685265ca98c4c0cac1290dedd84f7c7ede68d3a7f788903a9fa5ee4578614efa2b3e06e4ed3feb433d459d718f7b5c05c1518f2b94383de86e1bf32dcf21a4495ef8eb0e05157285e78ab97037ad590b634a5f378ff00adc3b71b7a2c08dcef075e8a64afd2c14a9594e083cd3b6d4148040239ec6b93b47f55f56a6fe8853247a8c85048c27923f3e6baeb47d92eda91a696c47524b8807904638aeb232e87abde0dd0f99f05731e97cfe3b96382aa5d989d01242cb27d17d20ac0e4559b64980b69e7208a069da26f364ff785b5b82464e2a5f4fdcd230d38adaa1dc523cff6f2d7cab3b9d03d29facf4fe48c4ce4287f0658b1dc49477a516526a1a2cf6f684eee4d3b33123049aac354419dc68e42bb2b03718df961319641f06be627fed0307f8b581c52b930dfec3feb35f4a350dc5b4c673711d8f6af9b3f1fca499ba78907223bc93fff001d5ab85ac8424ce7f9598b6faa71ab43f66ffe2709cc4112559238afa1ff00044f255a323b40f21a571fbd7cf75a42ee01246413820d7d5df83df877bb69fe98c4bb3f764bafa984bab67fe40ae40ed9a3f0f91a30dacaef3af21d4b8ff52f84cae6fd3e57114b11df52c47d6718fbd0edea5a10ca97bc707cd4f5d8aa138a60e770c839f155d6b3ba8896f716950dd851c7e0558b0aa0da61f13e39c4c4b1b2fdbb4763a328feb1eb691eaaa14477804e706a85babca97be43809e7cd1d6b10edc6eae2564ee5ace48ed83405a862ff000f5fa09709dc2aafea6cbb5b607c09f607f4eb83a29a11d4764415b9b8a295edf19c50bc975b6d7bdf2079a22904af20ff005134277e2439b309fdeb99fba6cbb6277afd28af181323ee52d0e8d88e46698b4908701ce3cd6d8dfcf03149be85950da460f14705222c6035261b5e5b009078f14cee080ac280c8c529110e04278edef4bc94a131d6e639093455a09ae6e87624406477c568b183c0a51959714412056568c2bb8a54c3532636709f4ca878a7b6c777c42a3df38a6ae81b768f34ac1fe530a428f73918ac4f089bb8323b79ad5e4e36e3deb394ade3cf9a59e691b3ef53291333d11bca8138ef4f5e250dfd20671c523000527b76a7123694e2a5aff7cc8201ee585637d85e965a1909de52777be7140d354a2e8500719cff009a2cd156f9772b3496d8493e9257dbec33422b4ad2ff00a6ac9214507f20d74a14baf1d5b81d19b7b8ac740cb1340c54068bc53f51c62ac18ef71b71e31419a199d9112578c119a2f6fd34ab215e692323b39965c3f1551b922d251b77abb8e69f58f46b9ad2f2c4169b538c21c0a5293f63922a24a94b4ed6ce2adce865f2cd634b8d4e4a43e5654544738356ef4f840e59c6f43ff7960e22aa2dca56bbf689d0da054d58add12ccb3e9b2d36949f603ef509d618da4ef096a15bc34f4b52495290bdb83f7351fa8b5b5911e846b5bc971e032bda7be7c5414e2d5ea099515b4a9e67248cf39f1f9ab263603fea0653ed47e25fefa71f27ebacf43ed222c7f0fb7ad4ae99105c521c57fc347aa16927c02476cd026b8d2578d11787ac17d80ec7951f6a8e412082320823b8ab3b4175caff00d38d4097255b5876de7e87e2b49c28ff00d4147cd599d5a5696ebe5898bdd8582cce8ad2be55c5feb27cb6ac77f6e692f23c96562e59551fdbfcce7bc858cb7155f89c8887dd1c3638ee4d2a99b29246d75c4ffe95114bce80ec09f220494292ec65142d2460a4d68db21439144539875e487e605b7d6b66398da96f913019b8c84fb61c57fe689f4ef53f564292c35fc6e4252163eaddf5f7ed9a0ff950a384924d4ee9fb03b2d63d36caf9191ffd69d6016c9622c1b5d7dc750bc2a6dbad504923f1f69dc5a04ea0bc68e45ccc87251535bff9a72718e6938d7c86952a3c98e12f12460d563d33ea85cb49dad1a65615253b76b633fa01f04d3ebd6a1960ff00146d900a95ce076aa85dc4642653f980149eb5f896cab8d7aac616e82fdb509af4ec75ee52528e7c0aa6fa9fd39b56beb6396f9b19a2a39da4a477c7bd152f56373180a2ac2cf18fbd4749bb38db6a2b42464120934eb1709eb1e2c360fda59b0f191aaf6cf60cf99bd64e984de9c6a87a1adb57cb95928578fc50e58ae856430e91cf6aed4f88ed230753699977153485c86415a081ec09ae12750ab7cd3dd0524f07f354ce7f8e6e1b256caff6b19c53d63c30e3b2894f896a692bd3b60bdc2bac7dd965e1fba4919cd7d24e966ab81a87484298e4a6d24b6904295e6be61e9f7d329a6c9503c0abbfa7fae75559ede20dbae6a6da0784a901407f9abed2f4e5f1aa2c3ad7de72bcec1398e557a9deafbf0d4afe5bcd9f6c287349ec4ffccdff00fc69ff00cd71f0eaef50e21e64c67d23c16f06bdff00bf4d75ff00f2b1bfb504a31474b688affe9acdacebe67202c63349abf49fc5656acf6a4d59039c735f3c99d001dc49678fda92ce39a517da9227c5647c4db4668a3f57e6b7b74555ce6b1059c95ca5a1b48f3951c01f9a45d510094f7c6451cf432c47517556c36c2925b1312eab8fe94609342e5d9ed52cff0088560d5ef5ea9fccfa61d1ed30ce9fd336cb6b2929116134ce31ed824ff7ab761230818278141ba5190dc64004e33c7be38c51b45c25009f35c372ed37e533ff0033b22562aa42c74de7159567239ad9053b6b570f1c1a2298b2d9e52f03f149b8e8da71ed49a8abde9159239269b523717d862497d65c2140d61c249cd654ea7da912f64e28dd6875201b33057c9ad14acf9a4de590ae01ad0ace3cd6e87f330c22c957de940bc8c0ef4c92e104d2eda8ab18a981d484ace5ff008fc421ee9bd91e50196aec9093e7ea457cfe71450f287debe85fc78462e749223e13ff0006eac2ff006db8af9e8e01ea295ff355c3856dd4255f945ee6a5f4f6acfa8a2338a4bd2c2fbfde95053db069f6a2352664bcbc6d1e78ad96d28b79db9c8e79c560b648c8c561125cc96f1fdebc46c7736df7b92d60d5daa6ccc4db75aaf3323469c9c4965a57d2ef18231f8f357c4cf87fb7593a2161eb3692bcbc8beb2d26e325d65de1b39ec3d8a71dbdb35cf56b615267b2d7abe9175d4a377fcb920668fa76a8ea574f6dd73e979bba9369b8001c8aea37276293c6c57719cfb505755aec432973f12f7f851d376ceb4dd7576a8ea9b8c6a19c88acc4ccc002f663be067181e45537d7dd0f3ba47ae1fd076bbf4876c17108b8b311523284a4acfd2a4f62a1838fdaacfba749b5efc34695b47583a7fa85c90f7ca215788ceb614d143841483ee31919a98f879d2b68f896d4babba81d4fb6c598e00d30db0825219512794791dfdbbd0a363ef096d1eb513d63f0d9d25d4dd1f8fd47d07764db5e66da243c10b2eb6eb894e549567f428915c84e3812095ed248e7e8238f1cf6cf157575b34feaee85ea6b8f4e6c9a9260d3f7a6be65314a814969471b76e78233deae8d4fd13d0979f867b4ceb1b9084eb6401344c411975e09254951ff00b1a9eab8afcc81a90df0271460a09fe9ca41c11c106b2992a5e1251ea11d810702ad2e87f4a60759353bf62ba6a966d6eb6c82ca4e12a7f9e529fbd4875ffa04c747255bd56cbc393a05c37001e18712b4f7fa478f6a20dd5bf4448051621d832b5d3daf755e9070c9d3b7a9b6d59e0965d5279f068918f885eb3b0e7a8d752efddc7d46515201fc51ff004dbe12ee9d47d0b1b5a5af59c16952d254dc70d1510338daaff955551cbd133acbadd5a2eeae36d3e898988a7b8d8095001471e39ad0d747e24a1ef1d6e3bd4fd65ea76ad6031a975adca6329fe85bc523f7dbde839d92f9517372c9c02b255cfe0935d4dd43f83285a5fa6d2759db75c266bb0d9f594da90036af70143fc506fc21e87d0bad7a84b89aedd69498ec0950e1bc46c90e7dcf9c63b5607b49fb44c30b9bef299b069b9baa653ac4276336b69b2e38b92f6c0123b819f38f6a23d0ba1f5bdd24a2f9a6f4d2ee8ddb5e2e3d846e6ced39c127b838ababe333a67a234cde6d0bd256d116e9354a2e438cd93fcac6010079f3465f0efd73e9c68ad0a9d0bab5aff67ae105254e38fb2ac4a1dff39fdab06ed8ea656a3bee006b4ebf6a2eab5a6dfd2a7f4bff00079d25e6234b5a15907ea08094a7c77e454df54fa0f74e86d858d73a0351dc59936e425b98a49ce718391e48cf8c50bc4e9d6b5eb36b3d43d45d041983163cd3219748d9c8fd3b060e4f00d7b5775db5f6a4d3ff00fba2d576b6917271d4447a77a842d690ac723c67de87f2f2309f1021f7c23ffb3dabe0eac9daa56c4ebf4f740712f00a756c639291efef8ce2a8fea6693b3e95eb2dce2e9a84ece870a636fa990d1201037281db9e3c72055afd59e807fee8b45c5d7fa26f93a15d6dcda0cc71a7b6eedd8cecf1e7f7a77f07d76d3d3e5ea591a9ae2c3da92e032832482a790afd6727835a9990351cf553acbd36ea1749d73d89517f897a6185415021d69dc6d18046702b9c750686d5161d391352dc2dcb62df3d216cb9ff00ef124e38f6fde8e3afda4220eaeceb3e8db39528b495299693b95eaf7576e063be2a5f5e75b2d5abfa52e683d456255b3505b50c30dabd3c25c093fe0fed5254c54ea7ac0186a50896882a581d8669a29c52dd2140e3da9790fad8231d943fd2936d49707a801c9ef4d93e22b23c4ea6af0e1380719add85a92a1b46493c0a68a53c97b055f4e6974ab690477ee2b63d8d4d09d11a9ddbf061a9d137404bb19712156f97bd09cf21b571feb5d0ee4b49490158e3cd7097c1eea9fe13ae5eb39730d4f8c518ff009949e47f9aed45ce4a90957bd53b92c70ae4cb4615c5900122355c90eb4528c654a18a776b515444281e703143b7b98b5c96d8db9dee0007db344b6a4202123394a539200cf3ed4b15764087337520b525c2459cc3b8cb6da752c2f691bb20027f50fb8acb5a855223ae51561a20af27b6050c6ae54e7755458d72b9c6fe14de5c71a40cad78e76e3be4f6a8d809bca2e0ea235adf4d95ec84add56149ff00e5f6a794500a4ad67e5354760c7d3ef764d6895c5b54c69d7d8ddb93fd4923bd01cd7233e992fedc3e85ec73fe538a32b67af1af0b6adda620b1107eb9a15b579f24d03dd62db6dd2678627a5ef596a5389c9e0d3ee3d4a30110d97fbcdb26696ad4ed59b584694e63d269c6dd560ff4e476afa9bd0dbe5a2e76385360bc879121a494af39e70322be433cb0274698a00ee6fb9ec4035dadf073d49547617a59e9bbbe5dc0f4704f649ee2adf8dbcba6cc507bf99c9bd41c50e0392afd43f6f2d375f00fde77bcdb7b331975b750141431f8aa4357c076c17a529950092738aba20dcd976dc99ce389dbb0138aa1fa83a8e2dcefeea19752b0d9c707cfb547e9daae6bdaa20e87cc5bfd60bf8f5e229ccacead24107efa3242d9a9ce7f98471524e6a746de1639aae449c1e38af192e6ee55c7e6ad2dc6a39f89c071fd73978d57b7e5bfe6125f2f8b90928f15c17f1f6e02bd3caf21a741ff00f8abb39d78a92495678ae2bf8f257a8ed8d19e52dba7fcd31a31d6a420469e89e4ade4fd554d961df47ff89c437070b727b919f23bd7d33f83df8aed79a9342c3d237562ddfeec8118ca6dadaeadb48c007dce2be62dd55b5f04fbe38aeb6f82a9ea6004a94301c2a39f6a0b07028cecb2b70debe27d27eb4cfcbc0f4fbb62bf893d4edad437453ab53ca5654a1c9fdea97eab5ed56e80fbe56025009233f6ab1aeb3f785024631df354b7599a5cfb548436aee9247ec2aded58c5c5257ed3e60f4d628cce414de7649ecca3350ea86dc926547746e3e3ef42d719ce5c3f9ee9caa9bbe1090e025456159e47de956424c7215b738cd71be6f3adbac653f13ed8f4e7178f83428afb1aea403ff4a80f20d08ea26d7ea1708e3ed45f701b54463b9a15d44eed425bc73de9062286796eb4ff0063507986dd75c0da464ab9ad8b121a590b6d40782697b7ba1994dbbc601e6a6664b88f35f51482051aee51a28600af52399753e804e4e477ad9d587582d93c5352b056761e2b575c21b2454a73369e3a9903423779286d5f4678ad42ca8e4d6895ee27756ab38e050ac01ee60cddcf7af24e0119ad376460f7ad16b22b1e3b9e066123f9a48cd3cc2ca4669b4649f54134f5ddc107f15903466771461410d7d239cd6725d38279ad18ff008783deb7402093520f9dcc13d4b93e1f1b33dd910958c2d6463dc1e28275369f7ed5a9a5455b4a481216a1f8cd1a7c373c91aa8b1bb009048fdeacceae680df7055d998c4e70781debb7f178e392e05517e408250a45bb32bbd3cd1621358e32054d254bc8e05348119610942107e9e31ec6a4da8af7f534ac7be2a995d0e1fc0fc896faac01008e22f29e4d4ac094fc67c38cb8a4abb77e3151ecb0523b629fb6850295a47229be2de71dc4368250f9434b4dd14da9975e58c3830a563b55a1a56df776d84dea1c70f4723f98819276f938aa7ad8d3b3a2aa336aca87291f7ab234075664692846cb758e9d8957ea50c9dbe6aef772e4630551bdc78bc93e3202a7e612ea6d04ddd1bfe210be8717caf8ef9f6a1dd257eb9e80ba8872944447090acab841f74d1e4cd6fa5a6c62fb5768cdf01410578233f6aa7f5a6a78b767c356ff00a908272bc77fc52ab1aac8a49b3a33175c9949e43e63cead3f64ba5f98bd59bd3f5a4a3fde8347e92476341403b9c01deb28754b5615cf3de9e30a6c91bb8a0b1946fc47c401535d45ad901d90e206c382a193ed56469ab5b522408e016d86c0de470554276c911e1b0a70a81ca4d10da756daa1db5c534ea0ca755b508c1c93e2ad4b6ae2d1a5f931bbe42e0e3864fdc6583a6ec71e55ddf7a22c25961200f209fb1a2398587e23d6c43a0a9aeff9a80b05c19b359dbfab6b8f7d447dcd36b3cb5091749cfb876a54792781819cd29b8397db1ebed0faf3ac34a973f321350c476086d119c25cdff504f8151b70b9c84c64b6eac9da9f7e69c0b9267dca6cb5384a30436280ef37a77e69d6ce461581cd37c6c9a906acf98ca9e616a4d1f98c357cc7a65b9e88e2c94380823f6ae23ea0dad56ed4325ac7055c7f7aec7b9c95bcd2bd43c60d72cf57e3255a80ac646ec903dea89eb0b3f5617c7ff1339d7a9f2ce639691da21cdef864608e2af3d2cc0640fa78526a8ae99325ebd06ce79231fdeafa2b720c4421a59de478c559384c76bb810c4766736aecf1cad9f88f2e325b64a90cb9b963b81e2a2fd39def4adb633af3c1d924824f3f7a9ef9667dcd30e27d325a9f2b0766199dcc0166944e59578ac2f918ad8f835a2ebe608c40ee20b200a494a1de94738148aab61372626a2091c7f7abf3e0aeca6e5d5254e29e2df0d4afdd5c5502e700e064e2bae7e042ca4bfa96f8a4e0a4b3110afbf73fe29373767b586e4c75c0d5ee662ceecb0b410cb6909ec01a276fea6c04f1439634e1085151c01cd11b4b4e0006b8a2fee26757bb422e02c23b8a4d2b56e3ba9604148069177851c0a678ebb89ee23730b58c1fc537772a49c1f15bac9f7a414be08a6f50d45ce446ee28a3b9a6febfd55b4a5e077a8c5c94a493ba8cd483cb52454e2942b45384000d34626851c1552eb50563151b368cf1d99ba1409cd2e93e3ed4d9076f7aca9e249e78c54c8d353f1286f8d6690ef44e49c0cb3358577f1dabe713bcb9c57d12f8d07d43a3d3519fa552591cff007af9d4b57f3319e6ae3c27fdb955e53e678a807327c56414feaad569cf6af02061278ab1c4537129b0420039ad568714ade903de932ce15bc1f34bb525083b15debc4cf4d1a94b6940a15b5685056478c55c7a3fa69d40f8877ae9a85998db2ab1436d875c3d9c501c23b1fab154e3a101c0a4a0107b8fb55b7f0efd7e1d1bd4333f8a41727596e6d25131840fa8292787123232686b812b09a48dc9d5759fa9d79d183e1d2f2c37214f4c660b735476ba84e7e94281ee0f6a36d4ba0fa85f07e206bed1d7855d6d8fa12d5d58772947a84e0a718f7e01aad6459f5c75635ddfbaa5d3fb2b898d6c90898952920299083b9236f62703b0cd58fd48f8a085d68e99c7e9a46b54c6355dd5f623ce69c00a14b492a52904f6e71c7140110ddebb98e9ce9c47c5beb8d51acf58b5f20c4086dc7663c773716d447d247d89aadb5f5cfa8fd12917ae90b5794b9a7a7a10eec706ef513bbba09e463cf156058ac3d40f841bc44d6cfecbbd82e8131ee8cc7fa4b5c029072065409c7919f35090ac376f8b3ea45e3505b3d7b5dba146fe5faa42ca53dd083c772ae2b59b29126751fc3e31a77a31a73aa7a1a6bb1f504586ddc27be95e77027ba71db1dff6a8ee94c5d43f151ae130baa17bf9b8f6289b836d2432b7138c0191e7ef43737aa3d4ee93e9ebb7456eec372a03c9532d29f27d48c9e794e7b839ed52765e92751ba6ba22d1d70d2777713336990fc303294c7273b95e14938af762648063bea75a75d7c2c6a2f57a75aa5d6ac97b0a4b6973f9a93b4729d871b48f7ef52fd1af877b3758b454ed79abaecf8b9dc1e57a2eb2f72cabba8ac7807fbd4242b86aef8bdd6d0acf72447b446b447538e3ac7d5818c1591e4f9fb56daae1753fe142ead8d2ba83e66cf735f01e672dad5e5253e09f7adc9331e304b545d7a89a52f0ff00446fbac5f36344c436ea17f584a14a002b777239ce0d741ebff859d036de9eff001dd1f2dcb6ddadf1cca6ee2cc9294c85240249207d03daaabe957466e7f10a2f7d43d5379762faf2b685308fd6e0eddfb006a0ba81a97ac7d22667748a76ab75eb44c654da52fb416a2d1cf015dc66b1b3f067b5a92ff0aba82d574eabb73fa997d725c86a229a80fcf7bd4087f76d1dff006a3ef8d9b5694444b348810e3ff1a9b2414a994a5454d819ce13e3152d60f863e9e5e7a4b6f794eb68bd390fe693768ef9010e11920948c0c7df9ae6fe9bdd2d569eac5b97af6f4f4db65b65b8d95c978b806dfa539cf619ac95fbcf4b53a01d6c8bd1bb3b9a27a876a996a86eb8653527d039413df20f70476a0cbbe96d51d7dea45f2ffa020a551e310e07963d20123907ff0051f0055bbf15f76d0da9b424193669b0ee3739925b6e03b19614b28c7e9281e07deabee92753f53fc3ba1db7eb1d113859eee02d4a0362d240ce504fbfdcd7b7b9e83faa3aadd4fba5a51d1ad62964263cd692b7d683ea63231bbdc0ab6fab1f0e9a2f4df4f93a8f4a172d572b345f5d72d9904092a09cabf009ede7ed40563d0d3fe29f5fdff57db67aad502225bd8e38dee502060278f3f7a1cea66a5eaf692c746f55dfcc8b58f4d48decfd4a6c2bbeef6fb7b56373d267e1875d691d37aca749d6b77db36e0ca1b8b3251df870ab0a5127b64714dbe27d7a76ebac2337a490ccb92a8dbe4bb11608567b138ab8f54744ba5772e913332db1a234e40b77a9fc4585856f5ec255bfdb9ed5cb5a22e88d112a55d9fb13d3624a86fc26a42db510dee052082783deb755ef666ad6788d6a04494a55f4a878e3fb53556e65b21238ef9a78ea524ff293b52956d19f29e7fef4d5d737abd250e29a54de4b16d9f312dc5d4052876a50288c280ec2937b2d35840fbd61974ad3c8a94488c35e97ea13a635a5aaedb884c6786427b9048cd77fc1be2674269f69cc21d424f1e4e335f351873d2712e249dc083915d9bd21d63fc57444171e777baca036acabc8ff00e949393a3c87946b8176ba86ba9ef6e479cc2e3b4b75d0424213fd473c510dba05cae3150fdf2f0eb485a7298b1fe8c0f652bb9a0f87788132fde9befb2db807d20ab1fe4d1e4191152a01eb845071c7f3927fef55f4ac7943b22d70bd4466da60b010bb23620bc8209736ef52fdf2559a8f992dc485256b2b5118c9f3fb78a2690fdb366df9b42881ced39a1bb93d68c9434b52d47b81dff6229c63b15e80959cbc7fd476cda906ec88ccb0e2e4c869b4724a4ab3fe9cff008aadb54c232232ae51543d35af6a71c66acc930ad69694b11198ec904a9d708ddfbe6abfd4f748d3e43168b4ed0c249dca1e4d3ac6b36c0c06ac4f0f83b820e236c1860ab2b424a48f6e6acee836a47ac3ab21cdf5c04950439ce38c8aae6e6ca58dade394f91e6a4748c82d496c27215baac1c75e71f9247fb1e8c0bd4bc6d3c870d7e359f71d1fc19f43e5f5a1cb7698535066a5d756d92da52bc90ac719fdeb9ca76abd610e6392c3eb5a9c714e2b24e39351762bfb8c474b4f27e9481924e6a645ee0be4214127f35dbb8be27171d7dd51db4f8d32db30bfb19c7dd54e86ff0011cdb3acf788c7d3b8445613c6e24e28cecfd61b34f09121e4b6a1c1cd5752a1439895709215fe286a76951c98aea90a27820f6a3ede331f5f1003c671d9c7b5f033a4e36b3b2ca64ad1311b48f7ae31f8d4bf47bacfb737196951421c19cfb9e2a5ae12357594a83125c2da7b73deb9fbaab7cbbdf2ea855d56545a0427da90e76226354c565ebfa7be915c3e60662d9e400f8951dd7ea92124135767c36ebc674b4b0990a094ee19e7c66a93bb9487cab1d851574c2385ce411bbf50ce39f3541fd7db89717afe67d259bc6d3cbe11a2ef833b2a775a7f882d46182a47007150778d68eddd1892d84b6460e4d55cfde18b52bd241528a47d4287ee1aae6cb5a9a0a08478c1a39fd506aa7caf3dfe253b1bfa6d48b40c55d7f3263519b5465abd258dea0476f39a11765b81652dab8fb561f98e3895294e1560762739a6f15c4b8bfa863f15cdb92e4bf5b69751a13b6f11c31e3b1d6bb0eccd1e4add495295e685f52021d4a4107f146171da98f84020914133d9754e152d449cf9a9f8ec47b81b17ed24ce6f6d3521fea49f02bcb5057193fb56f211f6fb5249001ec78a92d5fa8ee2c43b1b8e5a46d4820d61f043673e79ada3654ac78cd66601b381f6a802eccda47b7c93585feaa5509c64e7b8ac6013cd4be1352444f06bc40f2295d99ef5ba63052b0146b1ad098dcda3359582077a70eb7941fed4a474a1a20ab802bcf2d041da73e6a399d4458491c1e6976c7d5c77ac4703c8a508015806b60753206e13f4eb53a7496a76a6ac7d2a52724f1e6bb4ad93ed5adec297d97028b8d0c8e081c57004b42be9513fbd5b9d06eaebf61b9c7b25d1c4965e71284952b8c12079ae83e99f521c3ace331ea46d5ebea12e0b9f4feed69b99720dba4486164a8fa682ac53471c6ca3d3d9b5492428118293ec6be95f45343e9d6747357a90db0f992da5c05480b1c8cf154375ff00e1a61deee7375369342633cbc953481b50afdb15bddea5c4b723dad007f32c1c75165e3e2722a5bce4918f6adc364e0249a773ecb72b0c8763dca3ad0595141c838e2a28de62a5650851241f6a2cd8b676bff31d2e3b21d349ab4ca5db24a5e0e61390559f6a3d774fc5d4b144d80e21992a00827b2bec7daab3627c590a09f4d5b854d43bf4bb37d70a4ad014394abea491ed8a28358a06cc9fd9671f4192172b34fb43c04e8ad85123f989c281a64bdc768db803be056b70d5573bba1287834bd9db6b78c534449b82c7fc3a26a6771e24494028346391b42b9213f9ad829015cb82984a76738005003f14d8a2639f4fd447d851d557af8913924752783ce2925287411edbab68731506407cb61641c8493dea11b8efb5fa9c03ec4528eb72d68fe4c809c7ba7bd1c5dd40ee69e6fafabb85933a8b381fe628b6903684efce054cb7ae3669897e9ca0a71c400ae7b9f3fe2aa872df29c70aa43e08fc56e36476cb6eac941e4f380696f2193639d93ad489f26c5ff10aa17519a8aaf492a5151500462995e2fab90f07c2061ce7b50d076daa2082da0057277f269fcebcda131da6c3884940232554aaece0ade4cd066cab0fde2779d40db63d2d800d9f511e38ae6bea7dd5ab8def7b6e67665156a6b5d5b0e325c1165216e293800550f767244e9eb90a4ffc451f148391e4d2e5f6c4479b713bf230bfa4510aef5f32acec4a49c9ed9a3abdebb810251693fcc5367040ed9fef5565a2e32ecec2d98abd81c1e0ff007a456f29e5a94a3fa8e49ee734c5bd709c771e30f0c763ff0099516ac9b7cc4b093d5f9d19e1e9c06fd30a1c13c9a79ffbf057ff00db93ff00f1d55aea0388d8690f974fb0a0b13fa97ce63a78ab0d486dc6f36d98ed5e0568bec6b627271ed5a2c8edef5cc4772d6468c41ca4554b2f9a457ed5b89a9f9882c827cd772fc0adb8b1a16e73979ccab96d1ec76a3bd70d0c07067b679afa0df05f6e5c6e915ba42811f3525d779fce2ab1eabb3c308cb5fa593cb2b73aa6d09cb49c703153296c82140d435ad402001e054c215f48ae45510cc4ce8b7fc458ad494fdeb4f554b3cd6ca20e2b4202559a6f4f5145aa4c4dc24034d1c5282bcd3d5a9279151d29d293c536a813f117b8d46931c23dea11f788cf6ef52139f27806a0253c539c9ee68e0b063d18b22614b83f353715d2a09e79c66abfb85d8c55156f000a2ab05d11262b6e9f29041f7a5d73956ee17580c212212957eaa42400cfd6738a51b585104f622929ca0b404e3815b57613d4d1ebd4e6bf8d99c11d2b4452e00a7e7b48fce057cfe5a407bcf1c576f7c72cc2d693b240eea7672967ff00953deb8889056a27deafdc20dd7b129fcb6836a6778490335a3892a5023deb5702147bf22b28381fa855848310c550b4e3054323c568fb69272073de937991c2db3cd380a41402a50c81cd7b53d356dd4640cf359200792e05639f6cd3671b48585a33de9c32f2320ad45252739c5608d89b2368ce9bf861ebee9de94c299a27a850d56e85289911e516c92564765fba4f8aafc0d44ad7f71eb1683d2aeceb15aaee6525494e5bd8950c707b67c8f6a83d537fb76b1b2d85ab5c275dbcc38e589c9691bb7949e0e2ba2be183aabd3d83d3593d3dd5063dbee10fd575d6651d9f38da8f239fea0334b6cd0319d7f509eeae7c4b687eacf4b45834a971cd437b5a1a55b96dfd6c38a3f5ed38e46478aaf341dcb5dfc2b6a513f54d8dc569fbc36944b2dfd676e4608ed850cf6a08b4a8e96ea12baa16bd35325e96b6de17b5c08dcda501473823b1e7835d07f105d5ce9deb7e9a4781a6e5c5b94abc2c18ed23fe2b2a233c8fb1f3ef5113a926b4372a8d58cddbe283a973e668288daa2c08c1616f7d05431e73c935e87d73d6dd35d2971e936abb389ad30cad884e13ff000720852540e32819c8a6bd23d5f7df87ed53f35ac34fc98d6ebac74b5254a472d367b2c534eafdda3758f5fa1de9db0ab8ff0023d4ded230427ee3dbee6b00ee6de3a1b99e9fe98eab74c6c707acda696cbb0de0af59941c87190bce1600e127b6466a4359751351fc4edfacda5edb6055bde6c2dc524ab290b230a51033f4f9adf48f5fb5074fb46cce996b0d38a92db6d2fe4c8c0f4779c16d5ff32684f4343ea668b545eb1697b7660a5d70b2b23725d428fd4923d854bd6b734246f50dd513ad3f0a72973a2bf166da2510a7d8524961d247bff49af680d1b7df8add6b77d4ba9ee4623109294b8db07f4e7b04fdab3d40ebc5c3ae56e83d3db669310265c64a1b7d417bdb71c1dca47703df8a6172d03d5ff871535ab2c57a08ca4170360169601190a1ff009a8c0df731b91dd468bd44e82ca7347db3574d6ecb7342948602b72149ec4609e091deaebe8d748fa6dacba26c9970215c2e125b2b9f24272e30e824e4fb553fa7a2eb0f8aed7ad31a86e91a3ae1325c57a6809c23d923c93ed5bf567a77ab7a01250ee93d63718d6b9ffc977d3738715e729f15e1d7cccc04b2b963d0bd5965d96e2a65aec973dce28670b4a540703edfb715d3ff0010bd46e976b4e943af5aee50ee0fca2866123d5c3cd2ca871b7b818e33517f0bda4fa77a9ba7f362dd99833f504879d54b6e56d2f609ce53ce391f7ae7fea2e9fb5e8feaecb634c465cc896f9297d294b6567be548e33c78ed5efbcf438d08aeb3fc3b5b13aa7fd9a126cf78690b92c2dccfaa3b827fe52053ed130d9f8afeabcbbc6a584b81061c52a311b77ea08c63b9f3564ea0f8a2e96ea4e994e6172445bb18aa63f86bcceefe6f0904647154fe87e96f59f455858eaa6909ec34a791ea2a381b96eb58255918c63f7ac81f798ee36ebcf4faff00d2079ab159b54ce5d82e64a1b885f21040ed91fea6ae2d077ae9aeace89b5a79b9704bd6f82b4c865d5252e25c0924ab9ee3fcd559a6f58dcbe227ab562b7f52a2c4446848712b6993b12b29ee939f2ac63f7a73f133d23d33a01a8d7ed30170db96e7a2a8e95148cfbe7cd6413bd4d5f5e339f6e1e92653e5bc047acb284ffd3bb02a35edabc940e69c38adc4909031c1e7c78a47691f5718ef4daa1a58b18ecc6cb715b4208fb1ad9b4a71815e5ec5ab183de925bbe9ac247bd49b9a18bb6e04ac2402707fbd5d5d0cd4129bf5eca8076abea03daa90dc3214055c1d1088da24aaea93f5eef4f04d0b9a9e55184e1922c9d416ad3764ba30d26e9190f28e095636a87db8a296b4368c7e30657634f6c6e0ea81a16d2ef2dd4254a2739147f6e59081ff007aa7162afa966f00ebdc8677a6f0da25569d453202543096c80b483fb9e6aafd7cc6a1d35252da35338e25dced536d84abf38ab9aff7562d16b7ae528128651bb6f927c01f7a0762c5fc5ee62ef7467e61f928de92a1f4b29f000a6788c77b313e6e3544772af62cf747a2a6e9a867cd93eb1c36d2d4791ef814bcf8ad5860ff00157881e9105b6c9c1fb558da8ff87c14154b5210c3183c7d3903b802a9ed697f3a967294d252d454e10da3be71e4d3ac7b433c4ed50ac6d6375ea16ef0e2941b28239e40a9ad2bb553104f041ffbd05c28e632c28700d17e9a4adb98871dfa51b93cfef56de3705b2b2ab75f8111739c857471d6873aea5c91590b600cf81da99dc5f541fe67a9b523cd3f86e2131d2a0a18291417d45b8bed44c339c676e47debb1e7e5b71f83e6a3e04f95f8ac2ff56e50633f418c7dfeddc786afae624e3d8d14691d4b0754dda35bd99694a9e58473c79ae7290ebc85293bc92ae727c1a5ad97d9f6c9ed4d87294c3acb81685a3b83e0ff007ae48ffd4acd16b53589f4753fd15e2daa4b2dfddafb4ec4eb074b6d7a3ba66febf8b3dc43119f6a3ca6dd2305c73b6cf735c1bd50bc44b95cd0b898094839c0c66ad0ea275b7a95af74f43d3ba9f53bf32db05495b515202501c031b8e07d5f6cd507a91f7172895057ee6b4c0f567239f6b5569fa4c767d09c5f0682ec607c8415bd2beb213dc8a23e9bdd3f874e42d6a03ea4ff00ad0bdd17970fdb8a7fa5f9948cf3923151e5dc55c911863561d56b9734d9f0ae29594f0e2c77cd0bc9614d3c4f2056c97be5f696d3c9ef9af3ef38f277293c7bd57736e368204b5e0e3ad24751b15612727ef480969656540f6e6b0fba13c8e6a2df91925431c77e0d2eaa96b350eb2d0a4efe249bf78de0824f1e2a0e7c92a249c7353360b0cfbebcb4c182fca281b95e927381509758aec594ec675b5254daca48230411dc1ab3e1e3d94d4594f52bb9d941fafb48d52cac118e69bee50510453a481bf15a16c1591ef505c34fa3f302423537860ee07ef59980ec23f7af320b678ec2b124958e2875fdd251d88c77148e6b54abeacd28a6967c5265b50fde8827a91c5bff0015bb6e6d5851ad1295129a54b44838a849d4f451d702d1f4839ad5b776270a029252cb6369a6eeb9bb9e6b615ec6e49b11dfcf252bc0cf1deb225052b703e6a29c50f19cd65b591ce4f15ef6f53c4ea4db9250a6c050cd319186825f697b5c41dc929ee3f1588cc4b94bdad364835e9367ba8390c92073e6b744f1faa6ea37dce97e83fc7c7527a70dc6d3ba8ee0e5c6ceca82769385211dbdfdabb7b487c5af4efa956a6c37778f1e43a91bd0eb982335f208d8e611cc6583dc9fbd6f1ae374b3bffeeceb8d388e410b39cd2ecae30de7cd58832c3c4f30980ffdd4d89f59351c3d31a8d0a2cb90e5a559270479fbd535aa3a75646a51762b5b14559fa46715c7361ebcf502c294b6d5e56b6523f439e2ac0d37f14173f9949d40a7f68c14b8c61583ef82467f1569f4b5361bd68b6e017f9974ff00a8788ca5d3ae8cbe61f4d673ee130dc4ad078ee39cf8a236ba25aae4212a6184e00cfbd559a5be2e34fb77e6d534b888c7682b75ac0fb95019abf6c7f177d229efb50c5da3256a4800f2da49f6e6afb97857a59aa2c0c3f885635bc55a368c2005cba757db012664450fbe38a1f71c31d450b6979e78db5d1d72ea7f4c6f7110d1be404b9213848f592aeff83502c683d1b765ae4c7b8070f92b51420e7d8e3156ae33f495d63f5287737b712971ba08945c78d3a5ad7e9c2591838f7a673605c985e37a904f8aea7d23d31b0c5945f5bcc3d9e0202c2b8a2d99d2ed1b721976d4ce40ee1232685e4b96c0c53e28a47f890371a75d9138776dc639de7f999f19ad9bba8076cb429b00f200aec09df0f3a4e6294a650a67ec1343777f862b3a9a57cbccfa8827071490735816f45ffe645fe9ecbd03b9ccf71ba5a2342724fae3e81efdf8aa3f57750a6cb98a6a1c8d8ca545200f357d7c46f43e4f4f34c3d788b3965a42d29c6eefbb8ae43925c0b2952f38cf7aa4fa839543614c76d8fe25439abadc53e2cb0851acae6cfea7f7027fc528e6b27e57d0f3aada78e284d4491df9ac05292339aaa0c8bf5fba564663fc4267551648f50cafd5e0f7a6af428894a941609ee2a0bd750571c56e992bcfd4a26bc97bf97d523c87f359b3ea395049ec6b46d653faab552c287df35a950142d84b3ee28dc5fd415ede3d8d360a39adf77debdedf9f7b99f107e63e200348b9dc56e493cd687ce6861d18f06cc4940d20e8ef4bacf8a6ee673dea49923a88949dc527926be967c2d41f90e91e996b0402c29c208ff98e457cd60029c1e076afa99d1082981d3dd3d15230116e6739f7c73549f58d9ac5f112e5e914ddc5a5bd6b236f7a974a86c150f6e6f6360d4a201db5cca8597bbe2dbebdbf24524723cd789239a714a88b6cf8987d7b7b544cc779cd3b92e915152d64f3e29d50ba8aad3af88c263fc9ef5072964a546a4a6ab04f350f257f49fcd1e00d413b304357828b7bee82410da88fec6a4fa5d7c5ddb4f465a8e4a53b4f3c8151bab407edef23246e4293c7e0d0bf462ec88708dbde57d687149ce7db34a7293ef0ec6d7de743457cec4827200acc9786d24e78a8ab6cc0b090093c77a5274a4842b04f6350e39d9ee4f7290099c5df1c57bf5752592ce97010cc75b8b4e7b28f9ae535f0543deae6f8a7d49fc7bab3720da82db840454907b11c9fdaa9ac83926ba5f0b5f850099cf395b3cac22225bc9ce6935829ec6b75124fd35a791b8fe69d6f7148debb8e58505a4254a02b5911425614859e79a6d292b4a429834ed9256d2379e7b57a66611c2706b5719c9053effdeb0f32b0414aa956c029c2d58fb8f15e9e1f32f5f836d45a5ac9d4f535a9d3193f3b094cc475fc6d6dc2afd273efdb34bfc5e5874b5bb5dc676c0a69b7dc6b7ca4349fa5a39c83b877cfdaa817421042d20eeed90707f6c574afc21696d09ad6f9783ad1f172b846423e4a2cb59582dff504e4f240a02faf4770ea2c1ad4b9ba0972e9d6a9e84a34efacc7a31e3b88bc45529292dacf3bf0793c66b8fac1274ee8eeaab7764b3f3563b6dd0852948237b695647dbff344ff00119a51ae9af526441d1f2df871a7365d534cba51b3ddb23eff007ae92e9b681e9b6a1e8340850d3167b72a217254b2d82eb3239dd9578c7bd0e575081b247e242fc476a3d03a9ba5ed6a0b7c98d3133d204271a7015eec821247718aa0ba0fd49b67497572ae97eb5baddbee31d31dd7dc6b96d279047bfde832147b5da35aa23ca79d76cf16e18712164a5680e7240fb0f6aea7ebfe9ed0976e9e33a8ecadc6084b23e51c680daa4ede13ff00abf358e8494ecca73aef77d39aeb58434f4f1c6ee02412a2a8bc15e7c63ec7be6a4b40f5c15d3ed2b23a69aeb4f29d8496d498ab4a0171a528104119c11cd07f41b56695d03d43897cd4319a76010b6967d3e1a2ae377df1dcd10fc48dc749dd6fb1a5e8d971a5992438046579ef83e4567f8982363703b4bd8b5ac992f750b485b9f663dbe6ef6a4a070dac7231fe2ac4d71f1457cd79a34e86bce966d9bab8b11d731b50daa24800ecf2a34d3a41d6f8bd35d3b33436b4d372176b92b53ccbe947f3195287215ce140d57eab45eb5f6aab95c3475a1d5b4cacc84ed4fe80390558ed5b0e848b5d4b2d5f0ffd51e9759a175034fdd9c8d29861321686413e882738571ce7daa1ed9ac351fc407506c5a4ba8578619603a5b71c6d3e99007be38254381f7a297be2af5731a61ed15abb4ab4fce6db2ca6725d280476fe623c903b50d699f877d717ad26df51edd3950c481eb4669a397169c9fac1c641079ac68377361f8857f103d05b674a2d69d61a0aeb7086da1496d6943c50a191dff7a92f83dbc68a912af10f564b886f934a030b96b00a9b50fa86e3dc91c554d7bea075335b5c2074d35bea64bf163c96d95add6c216848500379f3c55edd53f853d0d67d0c75069296f44976f8c990b7cb84a5dc609c287038cd634267e2553f133a3ecd13a991ed9a36de5522431bdd6e3a82f72d6729031e68f74bfc52c3d2da2c68dd7fa5ae112e16f8c188ca0df0be3001ce2aabe816b7d29a3ba8cc5eb5f3cf3cca9971969f7565cd8e15612a50ff00940e73566fc545fb446b46eccce9272df71bb497b21c8aafa92823e94abc77f15eebe27b635047a6df0ff7eea2e9d9dd43837f76d325d90e39092d8e5585e4906abbea5ea5d7f26ee9d2dafaf3225aacce96d01c460848f7f7ab5b4eebaeb17c38da459f506974cbb2bb95b4dad7c237107724d0959ec6c75797ac7a81a8e4861c88d190cc74380952b073c7b015e5ed8485fe0ca6a4a5097165a394e692c8da41f6acad29f5014e40ca8fff002e702b4738ce29b29ea2e2083122369c8a6cb29714720e452ca5e0e0679a4d49ee456d35dcc05600c7715617482f53626a16aded947cbbe5455bce3071e2aba5763ce38a99d2320c6d430579567e612320f8c8a8f23eaaf42118eda69dc5a624108424704103f27deac2b5bd9484a8fe6aacd2d24161a5a959381dbf1560da65215b01270a20553af5d3cb3d676a0c4b5fa8bffc26d49014664e4ef4ff00d29faa93d53a824e916588ec5a52f97c242e438ac36cfb64d23ab25b516f961bb3ae84478cf2d4e288276e53804fefcd056b4bbdc35c4a54069c533666f3f460ff003d5ee7ed4c3146c7cc03250b349a9fa0e5eb75b371bc6a067d03f59622e4a71f9c0a42f5d23d3df298b7b0e21c40c856eeff009a61a5ae971d1e1311e0b76dc7182919520ffe28d3fdb0b24c6c258b8b21dc648715b48fdaa67f3a8f92cd0515b269a5032ed2b8729e86b49deca8a07ef4fd8b8b6db51d83c2c28023c9e6a435638cbbacbfdd9e42db7f0545278a0bd537055b2efeac64ee6d04703be6ba47a473b760561281eaae23dfc47f13d4bbad3702a8a842cf1b40a61ab638b8412940c9ce4628374deb761f42512728ca47255daa71dd4315cffe38f4c8f7aebb7ad7978e6a73d19f3a57837f19982f453f49dcaeaf119e614a0b0a0738a6d6f806410b5138079cd185de5d9249c29c467f3ce6a3d2dc6f48888a06b8a73fe964e3ec390867d25e96f5b59cba2e25a34df118391207e8713c631556ebc6a3c79588e385640e6ad8674f5f2f0b51b7407a46ce4fa692702aa2ea0459706e1f2f31a536b42940a5439c8383c520e1f390e5fb43f74bb72d88cb8a5898097151dc567cf3fda9f69677135a528fe950ff005a8fb97657da95b0acb72c0f2558fde9fe59db195ec4001532cc61f69f7005a863b54fc88f6a66d854b7509501c64f9a024bee20023bd6b2e74a71b5254a2a071c13da95578eeee4158fff005b5d63f708e65c84978b6d9dc9cf7ee28d3a43d0cea2f5c6f722c1d3db11b9bd11af5e52de7830c4749fd214a3e55838001ce0d572ca9c59c1479f7aef4f816ead681e81690beaf5fa1df42ed2599c896c47f514ad8d94fa653df8ee3ee4d5e380f4b5b7e15b9b555ee326b4bf7eff008954e6fd416a6853203a7fd04d47d05b8b71faa5a7fe44380b88931de0fb2e11fd3b876fc1c1aa07e25458ee1d409174d37190dc690d02e2594e121e1dcfe08aea3f89df8ba87d5c92c69dd196472d96463ea5cc92007e41f1848fd29fcd7374c62d37169664943cb5673955748e3b88c66e2d933aa155ac08d7e3f9883072394cbbcfba7e8fb4a1cb6a0a2a230079ad11fa89c1e68d757e9c8b15bf52deda8249e40f140cadccb9b54a239c60d730e4f854c2b3c14f97f32d3e057fda3b1b71feb5a293ce7c78ad52b05279af2bb0fa87bd22b38f71d81245b77d4c6413b706b4750918e0d6edadb0a24d68ebbf560e28738ee9d113733c138acfabb38a48ae927147debc29246b531b997d414734d94739a533ef493bdf8add8697426477f1115f7ad9a19514e2b04127b79a731192b928404e77568bd90b251a86fa76db1d105a7761deae722a694c208e07f7149dad086a236d253ce053c536a57649c53b6c4515830fa8a81a22473ada790903b7b505ea381fcf2fa5245581f2a0e7779a8bbbd984d67d34255ed9a5b72f80d492e5f25d28958ab9c829fb735905612159391d81a2093a465b4a57a692ae699b9a7a7a3ff82ae2821b53e4201ec3afc8323f7ad032dac8ce3df8ff0035b098ea7e9dc4fe466965dae7209cc7511e30292f947907f98d94fed5bae458a76aec278792fe66c9b9ce61614d3ceb78f2959cff00ad10c5ea76ba8cca596f53dc0368fd28f995e063d86686d6d71e69128046e19e0d1b4f2f9b47fdbb489b2665f57ed632dbb2fc507582c3184487aae416b18fe600a207e68d34efc707552cc07ceaa2cff653a0823fb1ae7052860fe2bd1909797b559a37fea6e4474ee0ff0091b8627359959fa5e768697ffda27aa62ba05f6c9eab60ff00fd3bd83fd8ff00e68e627fed1fb4bf29b6e4d8a5c56f80a714da5c29fbe01e7f15c476cd256e76387df794ac8cedac4ad3f1dbff00f665edc7b67ff344e37a84dac12da93fe2143d5394a274d7c42fc5b587ab1641a76cacc85b6a00b8ebc80da4abec9ae5c9477acafdce691111d61494adb381ec38cfbf39a7182a1b403fdaa2e6f0ebbbfbd4a81fe226cee5ade4483646c4103358ee3b76a5ca72318fb568f0404e13deaa214a6c18201b6ea345a8057e6b52bf15b2f19fbd24a50cd6e07de62d3a1a9b15915a85151e0f6ad0ab3e6b5dfb0e45085fea3020a22ca2471e715a6f5fbff9aca5497958279c529e82688a54b8d891b9d7c4906f251cd795e6b1bc01b4034938e100f068423463b04cc2f93de905904e05672b576148ad0e679e2b61321bb9bc31eb4e61b033ea3a94e3f7afacba0d9445b25be321384b31da401ffc83fef5f2cb415a9170d65658aa055ea4f65bdbeff5035f5674d345119094a48184e07b0c015cf7d6afe35859d0bd1d5ef661cc2500ca4d49b441466a2ade47a602bf6a9448212306a834fda5b2ff0089951cd69b55f6aca8f38ad14ac273c538a41d88bac2351b4b49f71c5454b040ed4fe4ba7779a8f9ae6505591da9dd2bb8b2d90b3947350b29584ab269edce429b5e49e3c9a8795210b49215dc51c50f8f4200ce0483bf94988b4e41354ed8af5fc1754cb8bfa415058078e09ab62f0e23d07772f00f635ceface7981ae1b505e37b241fda87141b0e8cdebbbc4cea5d397f0fc76dc071b8019cd3ad4baa116ab2cb9cf29280c30b70e7f07154d687d6a869a6d890b4edc0e72687fe223a9e885a3dcb445751ebcf4fa6a20f21278ffbd0d560b35e0085646501493b9ca3aaaeee5eaf93ae8e28ad52df5bca3f9271500eee038f34b3ce64e40ec4631ed8ff00cd3775c5715d2b093dba42ce7794fee584cc339c9c8ac3f94f2919af170f648e6b2d2944e1638345c1a6d1d25d1851fed5e782d820f8cf8ac2df5b07e94607bd29eb26420641cd641d4f4ca14b7c01e2b47995a390be2b60a5b4309191f6ad8ad4ea718fef5b4f6a2483ea80daf38a95b55cee9609ccddecd72910e64521d438cac8da7c827db1518b496d2302b7428bb8209013dc7fcdf6a8ed5f25d4d958a99d2bf0f9a0a0f5feef7ad53d4ebb2aecec5096fd15b9e9b8e2cf01471dd22837ab368d45d10d5770d2ba4b524b8b67b9326421869e252a6d5c6c29f0479c78f34d9883a8ba456eb2f547a7fa916fc59a036b2a465217e50b1fe077a35e94f4f66fc4f5eaf3adb5ddcdd65b8ca4b4daa30c04acf18093e2963020ea3047d886fa07a17a1351747a1cf7dd6665ce734a7553867f90b3d9271c8e7cd731dee2ceb05e24e9397777d56e8f3025c425d529b42777709ce3b79a3dd5cf7523e1fef7374659750bed5aa7364b7ea0dc9524f919f38a2ee9cfc3cdaf5e74e1bd6972b8baf5d2e25c75252e0dad9e783f726b4240f9930ecc98ea474bf4231d3662fba4951d519988db85e04125653f567ef54574aaefa674d6b9b7dcb544469eb6a1e3eba548fd049e147df1df14c6f88bf69bb849d206fb28426ddf4d4c870a92467938fc55f3aa7a49a3a1f4d215ef4fbecc80e460b764240254bdb920fb115e1d490b0d411f8841a51d1165698b8c792dbea0b4fa0e0fce081db148743fab2cf49173e36a4d36ebd66bb63d67d28fe621407ea1ee3ce3cd56ba464e9cb76ae82f6a30836b8f242e43609c91b873f7fc55ddd663a10d89370d317886ec571295b4d32e6549e3b118e0d649eb52212bed70f33d54d6eeaba756975f65c6cb852138207ba8738a30d2bd7eea47496d0746de2c516e515afa23216bf4dc8e3db3e46684ba33d4899d29beaf533da7dc9f0253262c8504e141bcf707dea5ba9bad2cdd69bdc1b5680b1c84c99641287301455e47159f80009e3d77257a7bd0bbcf5de15e7a80f5e516e0b90af97404eef51439201f18fbd08eb9d47d5bd09f39d35bb6ab9eedb8ee0585af72548cf8fb6289ec1aa3acbf0e0ebac3716349b73c732623e3f9793c7071dff14ffa63a647c4e751ae97fd68a11e1c4612b5478879fa8e3090719fef5ed6bb9ed1d772dde9e747ba37a87a431501a872a63b1cae64a4b83d6696464f3ec3dab95ec6e2346f50957bb25a557581649deaec434a521c42579e78fd43146fd7ae8c48e8d2e3dd34aea5922cf3dc533e836f29b24e39dc01cd58bf09fae7a656ed27234d5e6e5062df24bca71e4ce00a6427fa704fdfc71583f9134f8f98cfac1f11ba075e74e24596d4a949bacd096cc47d8ff82a279c2b071f6aaa354f45b59f4e74131acc6a00db33994a5e8cdf0405f60af7ef4b75aecb69baf55a542e9adbbe692407d4dc3fad2a733dc007006699f52fac3aab52e958fa0b51dabe5245bdd0a754460ad291f403f706a5a46cc8ad6d0954952028a94377b13c520ea828f1dab2a393c9ad4f3e69981a102277125a79cd68a3c62955115a2b15991444fb115276023f8b44593809782bfcd47a80a5adce9665b4e671b48e7f7ad1fb5d4deb6d309d87a32e4da994a770e001fe2accb53a16940c7048e45519a26729515b3bc61c4a483fb55c3a7a41521b6c9f6aabe657e2db96bc63e4804336e347928087d9438dabba549c8a6d7cd2f16734d2d9c33e910a0109c0e29cc35fd239ed522d3c1d18c8201c1a855c81d424a2fde0e41b4c2465a759c280c654320d573ae34934c5dd323d3096dee02d09ab82e4c24214a424829191c505df0fcec175974ab2927612390689a6d627eaf880e4d5e4bf4ca0ef08936c95be33aa529b573e78a6139cf9a61529d4051c8cd582f69f667dcdf43c92a4b4d95123df1404d301c7244604a9016463f7c55e3d3f98b5e42ca7f238b63d4c09863a43455a6f96f4ca2f10b232424d06ebfb6dc74e4b7198128ad28ec334ea15eeeda793886e1420641cf6a8d9b70977a7d6e4b58597383c5762cdceadb182a8faa715a78eceab9067b4829bf895e3f7fbca1e2a7dd5019e7bd18692d5dea28452e15ba7808e493f814e17a5d0f30a0191b8e4e6adcf848d2fa36dbd44757ab9db734a5328f955cf504a0282b27ea3d8fb678cf7c5513991757435ac091f897ee1f2310e48ad34adf98eba71d53d1da3d2517f6e49cac29496524295e769ce300f6c9ae7ceb76ac87acb59dcef96f8c23c691256a65a1dd0d9fd393e4fbd743ffed0799d3e97ac74d35d389d6e9b2a15a97fc6e4dbb1e99754bfe5a1451c1501ec315c792dd7dcfa16ac8ae79c4f0e832ffd4994a9fc4e8d99cb23e37e981dc87b9670b3ec2b7b283f38870f6de155adc338571de93b5bea4293c7255c5590b967d9ee23f68fb7d1d43b1e996c2d4a029bc99311a1cb8927da9934c5c9f40536caca71c11dabd2b4ddd14843cb42bea3e3c53dc7a9acac3a2c52d432316779b33748ca752908fbf7c57d4af81df87ed01d5ae8bc3d65aced11eeab9d29e610d92a48692d929c1c1e7915f30ad9a4563d3724aca7fd6bbdfe06be2dacfd16d2e7a79ace2cb7ac6252e4c392ce14b8aa5e0b895278ca4ab3db9c55d53fd417827af8e256df207e9e988fe22dc815596af913a10fbe297e06b4fe93b139abfa6c24b31a39dd26d8e385c4a47fce8511918ef8ae2fff00649c8ea51c2d3e0857715f4bba85f181d1dd57a7245bad9a8132d529a28f48b2a49191d8e45715dca1d96f5717550d69425f529407f4f7ce0fe69f7a630f3f98e39a9e6148753d31f9d7f3f981e37a89b17926a1013501f2652b70d3af9614db8dee41383c8ce2abdbd688981e538cb2529564806be96f4a3e0823eaeb3b378d47aaee31d127ea6da84a47d09f7fa87f6ad3ab5f027274c5a977ad2579917911d054e47b8213ea6dc7f4ede09aac5b4f10f96709b2f477aec6c6ff00ccb3ff00af63594fba475f99f2be55a27c524164e077c520b65d18ca4f6ae9bd49d3b84890b8d2617cac86d452b42918c1140d3ba6d19f529287c641fe94d7b91f4e66609fa0792fd888661dd4e58f2a8f529808392706b45a08e49e7f3566cce934d037b49708278f19fef43f70e9e5e61387d48cefb8ca3ff14b2ee2b2c542e6a881fe26edfbbc4181a4a87735a2960f9a9b91a7ae0d9214d2c78ed490d3d30ab1e9afefc556ae25dbc75d8922ab0f9914029406c1934a376f94f9c06493447034abeb4ee4a71efbb352ecd99e8e5202327b52db4143f5436ba3cbe2047f089dce232b8a25b0d936ad0f2d9c2929e73448cdb94400a671ef520c4068104236f150fed3b86a61f7b88c48a768fa7914f91195c1da69cc68a06013dcd4a311118e7bd32af30950b18a5035ad4881102c8dc822b2bb6828c247f6a9f440439919e69416c206135a5b62b893ae2ea09ff07510416f26b29b1eee14d0a2a16e77391ce2b530df0ac6def429008927e94375054d811e580479e29bbda6613b90a8a338f228d5310a79566b06036a39208cd4053cba1236c103ed2b597a2e1b8a386f6fe2a2e56838c50434541556c3b69c9f7cd3276cb938c2aa2f658191371e87e04a7e56839884ee6d6306a3d9d2d708aee4a54403e055c8e5b31949428f8a68edb5b1c7a7827cd6cd5b412de301ec4016d32594251b149091ce6944bbbbbab268ae6589b50ca9640350d22c5e92b732e957da867a9bf7447762352da318a5e4286d71293f7a5db44650da76e4f1da907e1bad67f96453743aa49394e31475398d5f4fb2206ca444655a642d7ba3a16e051e12d824d463ad292a520820a4e082318a2db16a37acb3d1292da1c40e16d938c8f383e0fdead7b7e86d19d60b62dfb194c0bab4838482371563b2d233dcff0050cd59f8cf4cd3ea0a4be35816d1f6302c8cf187f538ebf339c1ce39c1fc7b5355a8eea2dd65a42f5a3eecfd92ff00114d496b2ace385a3fa543dc1a15711cd5533f0eee3ae345c3b10ca6eaf2ebf72a3b1102a50ad81041cd6158079158cf3c528d02499191f89bb380e850ce29f647bd34640cd2d8fb9a6f85b5af4247edf94952d609ac16923f50a78e467129dd81db34cd6e28803de96dd59468efed125a509e5229bbab48fa943b73c528e394d5c5f3d89fb0f3512b7730837bdcb13a076ffe25d5bd371b66e09965c51f0360ce6be9a58d2768c2bb927f6c8af9ebf0876bf9eea8266ac653062add27d94a1815f436c63f96939f15cc3d67696b824ea5e92abc282d0ae11c2066a4d0bdc80078a89879da066a41b240aa963e898fed1f99bb8a20d22a59db8fdebceb8324734dd4e53ea008a6c1119272793806a317bd96dcdee6ece714fa4b9e2a2e52c94119c538a75f022eb84af3a8da96e1a76dcecf8300cb2de54a1bbb00339aace6f5625c0d348badcedae21f94ac31b394f6c8ef8ab8ef76a8d7269d62427721ce1433dc79aaa75dd94455c0c476d50601012d91c6718cd35adeb51f588a2d4776f153029aeaa4dbbdd5b6f2c86d49fa90a38c7bfef557f54eefbf51c4920f2527f4d126b88f6c6f7c980cfa2fa0124a38c9aa7f515e4befa532dd05c40c24a8f8a3a9aabbc6eb1a8b6e77c63a73b8716cd6298f1c6e7541491e1555aeb7d532b52dc0b925ddc96c94a066a2a7ea452418d18ede3048f3510dbe5d5e4f7e724d31c6e3d55bc888164671b17c419b9ca53c9f348b8e21594a73915e79cca4a127269ab41cf530af7a70a35d08a4efe4c72da79c1ef5b3ca5251c0e6b67404242d24715e4953891c566626895975385a09ad8b85903080079af174347906b2a75b791cfb76ac6b73d150f21c4e41ede0522b756839c605610b4b58213819a556eb4e2738c9fb56f3d36f53d440e2930971afa81c60e723bd612ad87710702962fa1606d35e3d8d4c193d61badceea889a224de8c1b3cf94db8e87065b68ee1f57e3deae4970fa87f09b7a6ef7669f1af765bcb6db8b51410dbc9efe3f49c7635cf477238c150fce3147f27aa5acf5668f83d2fb82da9517e691f2efb830ea324009ddedcd076d5f78556c35d43c8f035a7c55eb676f463b7698f1594b6e29277a18e7fd4d3391a87aa1f0e37295a5a2c8625dbdf7161b6de1f4a86385a4f8e69de9cba752be15ef3eadded29936ab9a5b5becb4a052ea7bef4a8e3903fcd6751de3507c4feb61134adb1c830a1b65587940e10064a89c1fed4215dfcc255bfe629a0fa252bab5a7a6ebebbdccb7264b8b5476da5e01c72afed5576a33aa3484995a59abf4c444528e63fa8549c671c7e68e19d53d52f87d9f26c495c57e1bc4a3d2751946ec7ea491dabda37a7b7beb20baeb5bb388692d108c347014acf8ad0f5fe26c48d49f87d2dd311ba7f0b515b64c5b8a9f60fcd6405ada7319fabdbf35483ecdba15e17eae15190ea4a920e328ddc8efed52f7a8d7cd19739169b6dc25c56dd2a0e30db9f4ab1ff0030f39f6ab2741f4e2db2746b3a9d2e44b8bce85090cba905c69439c11e33ef5b84eb733adc99d5b72e964ad14d5c74b5e196d1e8252a8a558712e01ce40cf9aaaba7f7dd45a2f5142d7365b429d3094a753bd2362d24615c9fb540ea6830215f1d2c842501ccac20636e0f231ff7ae8fb7751ba27a83a7ccc553916d7322c74b2f46751fad4072a07ce6b257aea786874641f55fe2434ef5374a26cb034cbf06f720edd8e00a42144ff49f39a8987d1deb7f4bed91f5ce9c90ec275a6d2e80c824a1246edaa4e39cfdfb556cd69ebedf2eb26eba6ed9264c769fde97123e84e0e538c76ab7a5fc5c6a74e9377496a6d2e1bb9068b299c873692929d9c8f381f6ad49eb53dbdc1cb26acd45d7fea45934ff0052ef70d88ed3cbdcad81a1f4f749f193daacbf882f871e9e698d112353e984396e9301b490852f7a1d04e37057b93ce050ce84f84abfeb6d20dead91a8c5aa75c12a95122a91fa8939ddbfc5553ac2f9afe05e95d3ad71aba6cc816b92db2eb6e399406c773c7b77ac8206809861d6e4e7c3ef5234b74d352499daa9b586a7321a43e0654c2b3cf1f6ee6873ad5ac2dbad75ddc2f7670d988486db5253b77f1fa88abc3abcae8fd87a471a069c8d6b9b29f6db65892c293eb8700ca96bf3f6ae54714a24a9606e200cf719cffe28ca1013b80dcdd6a20a241ac027359583deb51de8b104efef3ca07dbcd608f35b919fea358da6b3a9e88a8d65a1b5409f7acac015e4a722bc577361bdcbeba69700e418ff00593b404906af5d3cf70dab77815cbfd32b806dbf472ac83c5743e94965c69ac9ee9aaf672772c582e48968db1fdc907be2a55992dc73b48fa9678a18b5c929010327353e1e8fe9853885138efed4b00d467bdcd2e93d4f3a59120278ce31dfed50529b4a5975d5a721292ae7ec29dcf5090ea3d2ca4248c90072295ba4547f0d9096f24a9b38fed5356a4c1ece8772afb8dd1ab358265c5dda97652886cf9dbdaabfb3c66dd716f8208793b89fb934aeab44f9c9f937d4a4a5873d2420fb134958e33d6c0ec6907952529467c73564e38fb2eac3f32bf91d92bf992d2ac0dcd89909c907fbd453ba65c6405368c11cd1958c2245b1052e05292a2142b329950e3d1571e6bb2a6eca56d1f89cc33aaaecc86a7cb46572faa7c1593c14a7c63bd3155f429787db4a769e0a939228f244661455eab609efc8a1eb8daadce85292d00a19238f34bafe43c7e975ea6b5f005fbadbbfcc18b94cb6c965676a771ce3238e7b8e3bd561a85c4225a92ca4019e3156749b530e12d9e376700557faceda9b6481eeae46293676555600a8ba8e38ee3afc57f2b18983077be4360654af14bb3679f14332244175a697f5256a1c119a4a2496e24d61f733b50b055c78cd5977cd7ba4ae1a395668292f4f90a6c8529180c849e706ab975c6b7509dee5a96a162124ea33b24f8d1d84a1c5e4e3818a204496e421252001f7aaedb7dc012a42d27152d1ef8eb51f1c1c55bb0b34d2a00f8886ea19d88061fa44696a421384a5230481dbef4facbffe9ab71c6ddc159e7078fed409035239809e124f153f0ae0ebe8dad90a3dce2aef81eaac7c7528e837f990e3f147dcf3dee13b97e24a90eba951f7ed8fdea5acd7d94e147c8bab52d49dfb4124803c8c0aafe4b721a51776e73e2af9f84cbd68db3ea79af6afb8c084e9692988b9df4b63dfeac1c1f6c8c7bd30a3d5ae2a7b50f901f6ff00f1191e36bb5bc2d51a33b07e147e2e347c5d3ad68aea25c116ab8403e8c794fe434f20671956383c7902afdd4fd77e98bd6625bd5f667c2d3c29131b59fed9cff8af985f189ac3445f3a8f053d2c9d1a6b2cdb5b6ee92a2a36477650513f48c0ddc11c81fb55108d753ad2adafc369c29f294ed3fdeaa785c3711ea2c83c8166a989d953f98a394e3322bc66c3c5b00561aff69d7fd59b8e97beea89732d6195b2e2c9f513e49a90e8b7c3bd97abd737bd7b93ac458d82e7a09c2b3ed93ef5c8d0bac16f5a12dbe1d609fbf00d5fbf0c1f1656ee97ead4bb735aa55a2e584c908c15b641fd6064671deba77277ad5c5355c5d9bb80eb7f3fed2b9c770f9bc263ad54dcc403dcec097f003a1516a79562d43a862cb53794a9c7d2e35bb1fd4823b7b806b94bab9d20d41d34ba3967bd5bd996cf76e5b4c94852738e7d8d7d0ed3bf143d15d4b6655cad9d40b33896db0a71b32528711c720a1441cd7077c54fc42db758f5166c2d3735b5d82dec25a696cf297dd2921473f624551fd15ccf3b76636372a09ab477e435aff118f2b99650d59c472cdf7139d2f167b6bc54af9347bf14d635920a41f4d848ca71db34c646a47034b05df724e3ef4f2c77b8f225c3b6ae423e666c96e3a3df2a5000ff009a79570bc5f23c8b14d4b3b728053e568fb4425d8e3b71d4829c387918e303dea39ab6ad04ee50501dabaaf5e7c27ea1b569145d6c9a959bbbed34879f88f34195a372720215fd5fbe2b976e2fdc74b5d550ae91836e91b8b6b20e0671e293f29e99e3b90ace4613ed17e4f7d7fcc0b8bf55e2e4b9aea70483a9e6a32d3c29907f22961192affe1014f6d37445d5f095210948fda88d8b4b0fb896d2d9dcaed81dff00148a8f4065e77d786432fe4cb8d3cb55ff009c1766101821269da639491c51539a6cb6de5055c782923fd6982adfe99fa81e0f34b792f46729c5297b17afe236c7cfc7b4e95bb91ec32472524669ca5a00f269e263231c1e056ab8a3b82315596c6b476e237471a0668db441c819aca9277e7d318ed59f49d411b0e6b62ebadf2a6ce4561696842b8dea681a6947964035bfc9c55232a5a538f735a09c8482a75a200a07d77aa511db4b36c772b56776d3dabcc82a1b9ebaf5a976443090ab7b495625b7948e79a18baeae830494b6dfa847b0aaa5dbe5e03c5c5c95e09f7ad4de14f02975d5157dcf1503deb133f2c8c7a10fd5af187525221807eeaa879fabe4b8a21884819ec7342a5eddc82295664a5584ad6050965c4f420ed9fee7c47137525d5c510e02948f6acdb750296e61e3c03ce6937d88aea3295027ce0d44c96432acb471581711d181dac1fb30bd5798279f4d2a3e334ca4a59989529b4201e4e050b992e0c7d74b43ba391897379291df0715e6d3fc45ee8ad1cca82fa72432b5241c1c0e3f19a5f4e6a5bde8dbcb37ab5c879990c919ee0389073b55e2adef861e91c9f895ea62fa7313555bac2a45a9f9e244a846438a2df0a69b681015ee492303b64f144bf137f051d4df875b637a8b502ad778d3ef3e238b9dad247a4e1fd2979a57e8ddd81191f7a6586f93c75f5dd8edf57cebf222bc9a68b14a5a7a33daf6e3a47ad9d3746a48ef478d77b6b5b54851c3a95e396c8e49493d8d72c4d8e5a7541238428a4fe454aa9e9cc2d4e4579e4a95c2949246f1e3ff00c547c82560929e4f73f7f734fbd57cfe2f3d4a015f85abf302e378f387b0adb07e24738d950ce3f15a2507b1ef4be0a15f52b8159c21473546bc12db319ad3e43b8812506b7f56b65a3278c1fc563d33ff0029fed594b594684916903e65d970d1ecb16d75e4a7eb4a4f1fb555b2505b71483e1445747f511866d716536c7180318f3c573bcc41f55c2ac0dca269df37c61c2209fbc626faed1b4f8918e5357383df1f7a7ae80334d57b723238355b09af99103b3d4ea2f823b4054fbf5e1c47092d4549fbf73fe2bb76ce848483cf1dab96be0c6c620f4f1eb92d3f55c67a964fd9031feb5d556903d3cd71df55ddee65902761f4ed26ac35264fc3ed4fc2804e6a3636e00734fb9dbde91e383a10fbbb88babc1269052f35b3c70719a6cb702524f3ed561c6424455644e52bfea151125c3b48fbd3d97240f150d2a4e72334ea94d18b6e61a91d29d290ac9e7c502eb86db916c777384252771e3c8f145d715f82729dc02b1ed5ce9d51ea4ea5b4df27dbe3cb47c9b4e2501953631fde98d741b3a1135f6fb67706f53c654a96196c9dae050c91deb9b35eb8ec4d44fc551386cf8ae9fb93896ed72a7129de5b44863dfdcd727eaeb92ae9a825cb573bd471f6e69ef1c80f5f888b91727b32352f82ac90724f7a76890848c057351bdabc9512a00279cd3a000f88a01920d2d7ea12904e69d2829080e6ded4d50b2ca4138cf7ade3cd2f9282924e6b613c62edbfeb1daa029552cb4063183482086945411827deb72efabc102bc663714fe5b832aef58496927b018ad014a3839af290950273cd644f459486d68c1f26b44042091818ad194e321469c2d94ec0a047debd3d177236d8689594ed51c63cd334ac859f6fc56c952d2d86caca909e706b5383935e98315f552460d65b78b7856f2140e411de9b607b9adb02b0cbb9e562b2cdbb75aafba8ba7c8d0ba86237702c147ca4b58fe6b601ed9fc76a91e986b0d61d0c9cd6a499a7df7ad5766821d0719791e0a15e142aa54a82860923ee0e314516dea15fe269c91a69f784eb73a9da86a49dc593ee8577150b6386ea4eb691dcb23a97ad8fc40ea5836bd0f68924e77912024a82bdc11e33ef50c87baabd02b90523d36a3bc8dae455f2d2f3dff7a1ee9575325f4bb538d411e03535b5a0b4fb4e7054dffd27c28558bd50eadc7eb626169cd27a5e4b32de5a77a5d214a2af20119e283b2a29d7da188eb60d9f982568b1ea3eb06a09f7e94c34d34c242e4a593b4fbe1247209f7a8cd496691a31e5bda6aed708c1cfa1e497092af7c8f34fd762ea6f4865ff00128f2570de28fe72149ca563c2540f07f6cd44b336fbd4dbf1139c04a06f752c8d8081dc8ad01eb5373f4f70bfa3ba16d5aaa14cbc4fbbb06e6dbb8111f20296073bb07bd0a753ecb06dd7d1199434878642d2da73fd87834eb5869081606c5cac7266447d3ca9d53877671e0d4bf444e84b96a6907a91720953e1298cec85ee055eca2718cd61988f89ed0fbc3be81f5cba7fa2b4e7fb27aae1b900e4a84ff40afd4fb2bffa668535858e675c7a80fa7a5d664496a3b580b09d893f751fe9cd48f5ef4ef4f2d2c30d69bb8479329f580db71940848f7c83c530e86756ae9d0c9f2e55e74a4b936bb960bca09c389c7907cd7868f7f79a9ebe2105a7ae1d7ce84c0ff63b54e9e8f3a1a1ad91933539f44ffd2b19ed437a63a7ec753a25ff00aa7adef28816e6df5a9c5378cad58ced00f7a73f117f10b6deb033120e9eb64b8f118c3cb5cb48de56782138f15487f14ba22239011739298cea8a971c2cfa64e3da88aa9f2ee416d9e3d4d6788689cffc895164b8b0d9cf381e4fe45352af7af15124e7907fc1ad48f3472a851d40d9bc8cc139af71f7af57ab7135d033d58cd66b55f03359dcf75f69a3839af24848c1ad4127b8ac93e2b04cc13a861d3e92a6a5a9b24f715d1fa265052594e4e42706b98b45bbb6e0af1922ba0347495b484a90b1db14a339011b8df09cec09765a1c40524a8d10a52975adf918f6a03b3495b8104939e3345511d7c3252077ed48befa8f046f2b735303695f07c0f6a9275d286543bfd3c54249714d49cba0ee27bd4bb64b90d6bc64f18a97b03a9a5836352acd57a75c9f71f9a69a29cbc838038c679a88d59010ca96e328c29284a7efdaac7b949436f7a6a4907f1423aaa205b0e494e7b7d547e3e495222ac8c5d8f2105f43dc56a765425903d3fa93458f4a011db26ab8b5030efdb9a5a8050255ed45aa9a4a79577aeddc4f20b761aee72ae6f88b1f2fdd431692b61c39522a1e5c46565440029690f919e7bd325bc7c9ad722da5bed25c3c6c8abb2643c8b3b4957adbcf19aaf3a87677dd4075a41591e6ad090b18c13dcd405d9b6df69495f619aafe6356a3623cc7aad76d19cfd29a71b5a52e0c12718a90b659e5c871a0ca8a8abb003b5175df4bb0b7438c80a564d3ab3c47ada5a7db8c1cd9c91df349a90b6d91dfe9dab588c3e9e5e5d683a4a939e71b6985cacb3ed07d175a59fbe38ab974a5c1cbd37e9add4470818d89473442ee8db7cee64ac2f8cf22acd5626d740c0d906e7322a52da04290527f1459a16e0ebd27d258c823bd5af72e96e9e90da828049f3c508b5a3e369d9855196768ce2a2cde32fa69372fda4f888bee47124215c1ce3da91798c46dfb77639194e7149ce7b624ac2c7151c6fee6df97572338e28ef45f2b8d8accd9bd83f999e50f92eabe8cd5a94fc778b8c6d0465383dc8ffefed51375714eee0b1fab934e97280529493827de9849743aae4d357cea0daceba037d011369ca8f2ee31762b26329084fd6aec49cd4594cc83f5a0a863f4907152eb250a049e33e2b49050fa3d326b64cfd379a3107f332bd8d111087ab2f10ca4b7215948c10bc608fc019ff34e46b4bccc77d152ce14476fd291f614d936f8c904a9bc9c71cd3889021b4af55c514e47147d9cd655d5942fbfe7e26568a836c2c9766f61ddac9510bf27ef4f31262ad97d69532a0efaed292ac292472160f823bd0c4580eccb966224ac25438145b2eeb0e598f09ec25c8e8dabdc70451bc7f141f18e6162197b1fcc8aeb3bf0201065bb27e2e3abcbb246d3ae6a32fc5691e9e5f612a5a938c0055de836f50f52eb975bd452fd14385a0d612920ab9e49e2831f5c45ad3e9e481db0aef45960bede82131a3c8dade36ed2338156cf4bdf4653d98590a34df8f888ece231b0ed391869a7ff00da674bda6ff3350c5d3b688cb913e6bcd466584fea5b8b20003fbf35f4174b7c005eff00d9e8f2af5ad8b17653614a65b8a151924a73b48cee27c678fc5718f40f5ac2e9ff005db4feb5d52c07604593ba428a42bd107037e0ff00cbdff6afb25a37a89a4754d9dbb9d9af7127475b49737b0b04723b11dc526fea3f27c97a54d7470e0ad446c9037b3f1a85d195ef3f864b789d7ccf9bdd61e93eb1e94c84c5bd5a92e44ce1b9b0f3e9abd8292ae524d5332e634495630544f7f15f4e7e2126e96ba69b9d1a5a23bd96d440563703b4e0e6be746a4b0dbd539e445cb443848091e29c7a4f97bfd49c69ab317eafc9fbc55c57a857fd4acc6f2d85fbc150fad4382003c0c9ef4ba50e6c19c7b726ac4d0ff0d3d51d72e7ced8a2c56212cec0fca58c2bf6ef45da97e0f3ae3a4edebbbaad76ebac56c6569832c0771e48411f57e33cd0d561f014dded66de9e44eb5bee5e29e791878d4fb94980a6c05a93c014d1eba328dc4b3909ee4d485e52e5be439125477a34860943cc3e9dab42bee28566dc1a5a4a5271bb20e28de63d17c40c7fd45235bf8866173f7d8da4ee426b4d73163c731e2a1295904122ab25dcc3a77384124924f9a99d5f01f324bc1b2a42bb50daa2ecc25491f7e6b89729c53d56151f10ebb93b720e9a3acc691ce452322d88713b9a5f348e0367e922966646094950c557efc435804c196c0c488d44490d9236e71df9a6af9710afd383535bdb567079a6b262077ea068064f13dccb06ff00c645190eb63214a07cd22e4d7167ea04d3a7a21472428e29b96739c26a329e466a19cf4622a70907be29b970a06ccf735290e038f2b18183c7e29e39a7da232b740c54ab57f3352a7f31be94d63aab44dfa1ea7d1d7c9d69bc5bdcdf1a74573d375bf2791dc1239078c57436a6f8e9eb8f53b4e37a2ba99a8225d6c676a5d08b736cbcf6dfd2a70827760f8fdf35400b5c26c603a49aca224568852524fef4eb03936e3ec5b822b11ffa86e436e1d79286bb3e3f8965bda4341ea9b7bb71d3f7a0c3ff00a8c75ac823dfe92303f626aae9d1151e5bb19630a6d7b00f71ef52d12534c9dc94ed3ee0d6244a6dd5970a5b2a572a514f27145fa8397e3f9740f5d212cfbeba06458d8071fe90db5fb41d9708ed0529efe7c5374c4583e38a20548418eb64a13dc9151eaefdb8aaab283f785b2858cdb8db159f2696f4c7b0a58049f159da2b4d01f1301c09d39d52b517d85865455bf0720f8aa0b54d95fb5169e71b506ddc84a88f35d6536dd0a4406d4fc74acfb9cd571d77b55be3f4f90f3111085b721012a1dc64d760f5170699947ba4eb4227e3b3fc1420139ade560f26902415a4633cd28ef39cd24df2a19f7ae29904d7e4258b1f565827d12f86bb3aad5d2fd3f1dc185ad971d501db2a5641fed57adb86d484e2ab0e90368468bb02509000b747ff002d9cd5a5040ca7f15c2f9b72f96db9dbf8d50986a04988e7814f0a804d3263b539513b6a2c51bd4d2d8dde5ad7d827da983cbc20fe69db84ed3cf9a8d714a2d9c9feaab2e30d08aad8ce615119150529c565593f6a9c924ed3cf8a8293dcfe69bd7145d212e52708510ac0c8ef5ca7d6d51775a4f435fa1652aeff006aea1bc01e92c7deb933531327534b3209708938fa8f8cd39c13a2657791de86a3cd4d7430ac0dbcf2929f4617a6904f7fa6b9524385c92b2a277296b27d8f35d23d6025bd35841c61af1f8ae675925d393e69bf19a6668ab3be06e2a0951c015b00a4b8060e739ade30056323c8a5de003bdbc534d6808b44d42dc2b1bc6476a72d29b8ca0e01fa8d248191cd385a525bc1038ac4cc50ad32124a7cf14a3694a10079a4a201e99e3cd6cb241e0d7a675b997393c56cd823f5115a24e6b249cd6c27b5a9b2958381e6b216bec48c527debd5833115cfe3fbd639f7ad326bc09cd784c18a84fe2bc78ac249e2b2af35b4c4f038cd7b291d8f15a1271deb5c9af4f03a8a139046719f6a9ad21ac6e9a2aff1b51db4257262a8ad2951fa544f706a0726b39fa735158a1be64a8e44bb3a93d7c87d48b2c7b531a6be4e61da95bc5cc807b1039ec7dfc506c6d2572b5308b841bdfa131bfad086960820fbd0484a4ec0470a201fb8cd394befb285a9a796929ed851e2a1f640939bcc288736fdacafb12c979ba21a6cac214a70ed4f7c7268db5af4923d96d45c3152021bde5f3ca718ef9f354d3ce38b495296adcb500a39c134e5bd59a967db9ab6cdbe4d7e282a4869c74a9381e39ad1ab0081255bbc86f509ba57a834be96d6d6fbbeac865fb6b2e92f369e4820fd2a039e3ffbc1abbbad3f113d34d51a75cb1e95b1a6e2fb8809125d6fd3f97e303180338ae5a581958fb835e686729392024ab93e454831c7ee90b641d6a6cb709c0fa4601e304f73f9a4c9cd6b9249e6b049c77a214003a827916ecccee159247bd2559c9ada7a6d8fb8af63ee2b5c9af64d7a7a7b39ad579c77ac9ad093915e9e9e055e7158571cd66b573f49ac81b13064e695514ce1e3ea009abdb483a362393e2a84d3bc2c2877f5bbd5dba314a286c13ed4065af51a617c8971d89e1b51f5519dbdfca002a340963fd29a31b6f61f9155e61a68f845ae8d87969591c0adedd314e15c61cf6e2969290a47233c547c04a5bbafd03191cd6df69ab44af7012a7d0e2881cf7a85bcc661db6ba94f7c1ef44da8b886563f50ce0d03dd5d7168054b27e935b21d1dc8d8790d4aa189863de0b6e24ee4ad493f8cd132dd3b40c78cd085ec6cd4cd94f04f7a295ffc149ffa45750e22f65c0044a5e4d6af7953109320838e699b92877e6947cf7a8f73949fcd66ccb7d6e646326ba9e9135048fa8d444e92024f3f7a752520678a869ddbf6a53937b58b185352a1123a43ca2b2a4f6a93b13d063b055294949009e6a280cab150da824becc40969d2905601c7b50f87b0fbdc9ae6f243277476a9f4b52c848708654e613cfdeaed8371f5da416f0729ef5cab6b7dd6e536b42c83bb391f9abbf47dc262e12774851c0ab3e25aece06e2cd6e194e9c12bc295fb50f6a15332580eb6704781deb5d4525f4b48525c20fbd0fc790fb8bdab70919ec6ac39390ef47b23e0cc22e8ec4869edbca514f82714d63596448570dabeaf3ed44721b4292adc9079a96b030d292b4940200a8bd1fe97af99e45f1ad6d003706ce0d42fba4ee025d6dc9b694a1e7b923350cf34a5ab2d90477cd4bea3716b93210a51294ac800f815171092e2524f1c505cde00e3b2db1d0f42454ff713cff319ba0a47d640a4925248c134f6e484051c26a387046293a64588de3b982be336796a4a93851c679a7226345b4a169cd3758053c8f14cc9217c1a6955efb995ecc2381766ad07d78c80547920d0fdc663d2e5b92d4afad672123b0ad1d79dc6379c53724eeef5605e6326cc75a89e84d0d209dc99b55c145050f781e6a61bbcc88d8f95925008c1a1b8bdaa40253b3b78a8f1f32fa1bcaa6d1982a3e0c38d37786df5b9f3ee8733f51cfda8bad3d60bfe93494e99bc5ca004a87ffb3c92807f3550dbdc5a240daa22a75090b48dc339ae9347aa2f7c25aec4563ffea1b8aafc2a325bc2d5d886f74eb5752aff00352ab8ead992dadc15b1f70a8ff718ff004a5a2757a6b0e0fe251f79047d59ce6abd04a56769c7349cc19614a3dc67069cf0dcd8bcfb42b0bf9d4d1387c4a14fb28013f79f557e07be207426b1b0a74ca67448f788ee67d0de029d4ffd20f26bb21f936d763a94a79206df26bf3c363bb5cec32dcbdd96e0fc19f0805c7911dc285b6a1c8208fbd765741be223ad378d2cb375d7f3e629a012853edb4b501ffa8a735cefd5dfd3d1999ad9f8b6f887fb1dfcff001a8becc96e1ea6ad14303f99737c64e80d24fad3a8a3c5433377105f6c0fe67d958ae2699a75e53ca4c7792b48ce466ae4d79ae7566a69af337dbdbf2db4a4a8254120671ec00aad1b427e69431dcf35d4fd2dc3353c5262e5b79f8fff00dfbcaffa4b2b2eaf3b8bf4493afb090313a7da9750c94dbad760997575476fa5151b943fbe0546eaef876ea5e9b0665cf405f604650ddbe444591fdd0158fdebe897c12da2d936c172992a0b2e3e87f625c29fa80c76cd755cfb2dae45b1c69f868750a49494af2a0463b60d72cf537aaf0f07916c06c40ca0e8927bff006969af9cbaff002fa1743fe67e7ce75a1d8c55ea364041c28820e0e7b7e699a61951ca78e71cd7637c72e86d23a6b5b7ab60b045b797dbdce08e9284924f2768e01fc0ae495a437ea140c6324509c9fa668ccc6af2f1be956ef47ed18707cd2722baf0d1074647fc8c849fa1655ef8e6b0e994c800b6afbf1daa5197965edaa0850dc8182da4f9fc56b3945b4c6d984ee2a0401807f6aace77a67daacbf90968f7027c4845beea890a6c8c7b8a6ab71295123827de9eca510e9c1a66f80a3922a996a146f13370de4371c459419e028f22947653b23e94a871510ea8a563071c5291df742b0167bd4247e278c934475a8656b26bc5053915b30eb8527eaf15a6e2a5f2735a1247531bd4d4ad407e9148a9c27c53b291b871493e00dd81e0d46660b90224865c50dc01c56aa41070534ee2a8ecc6699485a83e403e6a3b2cf01212e4cf6c5039ed5ea58f2da49a4f03da844c82fb91794fffd9	image/jpeg	0	\N	2025-11-15 22:09:06.108636	2025-11-16 22:09:06.108641	f	t	2025-11-15 22:09:06.109159	2025-11-15 22:09:41.050726
1	mrbeast	YouTuber. I want to make the world a better place before I die.	USA	f	100	https://www.toutsurgoogle.com/wp-content/uploads/2023/02/MrBeast-YouTube.jpg	\\xffd8ffe000104a46494600010100000100010000ffdb00840005030409090808090908080808080807070808080807070808070707070707070707070a100d07080e0907070d150d0e1111131313070d161816121810121312010505050807080f09090f150d100d1512121515151215151515121515151515151515151515151515151515151515151515151515151515151515151515151515ffc000110802d0050003012200021101031101ffc4001d000001050101010100000000000000000004020305060701000809ffc40058100001020403040408090906040601030502000301040512132232061142520723627214213133418292a2435153617181b2c2f00815246391c1d1d2e2347383a1b1f25493a3e1164464b3c3f12517459435748485d3ffc4001c0100000701010000000000000000000000000102030405060708ffc400431100010302040403070205020405050100010002030411051221310613415122617114328191a1b1d123c1074252e1f01533346292f12425437282161753b2d235ffda000c03010002110311003f00d5200950144c195d834b7f9d71410943c012a009fb17a028b3270469a80a54013b6aec05273258626ad5db53b62ed88b325e44d5abb6a76c5d80a2cc8c4699b57ad4f5abb0145992831316aec053b015db50cc8c4699b57ad4f5abd6a1990e5a66d5eb53d6af6e45990c899b57ad4f6e5eb51e6432266d5eb53b6af6e43322c8900da5f83452622ba3124924f44b686f51f54b8cb92413649d178910cccf3241738279b1c6ed2f640445723053786249072a3ca922709d3447a150cbca4ca485365249c133532691e103082f5a8bf0225c297eca3e6045c8781a842460b9b9104ca4c594a0e09a31bbb26630498a7a2293114a05365b64dae452f72ec051dd26c532bc9ec35dc1433045ca2985c8413f80bd06090cc10e53bb268452e0d25e0125c192492f4b6c47a84df83af4184fc1b4a84527394f085bd50f824bb6122a0f8f2ae8bc2939ddd92c44cfea430dcbc572360e0241c45167f24b308b7bc83bd76114e902461a5dc28e5a424ee5e8412a02bb1042e8655c82ec22bdb97525185ddcb9b979760823d172d5edc96b9042e8b285cdcbbb976104adc8ae941ab908252e42095082228c357209505e84177724a5655e82ec17a105d4574b01760bb05c82eee448ecba9493b929252805c4a8457119214c75d21b5b2112e221ca9b7c8182ee4f450bde72b05ca1a114eb0c139a448bba8fa83b4ea7dbe173188e9696844cc8bfc20df1facb7412836b6e1eaa49c97647e1a688651af54a1be2aa2a3188d9a3752b4d47c315128cd27847f9f0496682fc786def15a8a0d9777d2e363ed2aa6d1edecc323d50b24e5d97f4f6304be9bae31ddf34167fb59d21ed2b6de20fe6f6c4b48b6f1385ed3908414038cc87616ff3cd5d3385211ef1bfc7f0b57ac394d93f14e54e5e5fbc420a3e9db45407dcc362b72af39cadb805ef0f8962ec7487b4ae8e66e9af37c42e134e39eab7ba10ff00352345daea9359899936c7538535e04037764591815b0515f8c5403ff65611f0b51f56fd4ade634496cbba6c7369b8873777c6905b3118e879b358f39d284f3622e4cc9d2e699b729333832cf7aa2e7fd9261d2652265e1285427e8d323c24f37332645ca58770c7e94063752dd743fe7a26e4e14a47771e60dc7deff45ad3db3b323c225f416e404c49b81adb2143d1b6fb2b78b3d2ef0965179b80da5ec717cca5677692219c9b27182d4eb7690c479884a3bbeceef8d4c83889a4d9e2df0fc5d5455706387fb66ff1fcd945c60b96a93979a939bf30e3771691b844bba43e4faa1e3cbe448764484ad257d056c730bb4acb55e113d33b2bda47c147d8bd623612e9506148e6851052140dabc505250974a84aa4f3827851b8a8888a4c414e4244577f378a2f696a1fe9af2a06c498b6a7a34e14829214a152d493873d4161aee129a29614d38c2509ee9b3404289c25cc25264d0a670fb296254d1a5b20a0cae60a30c53664961e4a6cc2d1ba622ca4c44574849344c1258f3298769b357a2e0a413ebbe0cbb0944bf0a6bf54ec13719848298244424493edd2c90cf18404150ed94645d24989129c6e903c4896e44078520d5306c9d6e192bbde3655a83645cc950972e5256a060571c1148f6cec148ff4816b972ac8c81ae94810a9f28218c5285438a43b0e8da3aa888ca24c6594ac6d4c3b6a71b2951df48c0a3a32eb9e0f14640497b727398531c869e88684a12ef827693c4691132433390e5c63a2689849f078a763124989125025365acec93e08bd0955dde4ba8eeeee93959d97212fda4ac2149dcbd6a2d7ba3000d82541b15ddc2b962541b2457f34e0f45e8452a114a19724e0ca1241704e863fb26ae82f44d3f09325d84a24e76a588a4ec868b8bd722c6592a32a8731a95c890a06315c46f832f783a3e6048f677a0b72f6e45c5949c2479c24985c85dcb9b917169730d1e7446228684177727f0d7b090ce8b96530bdb93f84bb8486608728a1e105edc9fc25dc34338439650db97b72230d762da19822e5943460bd6a230d7b0d0cc8b9450d62ec1b4461aee1219d0e4f92170d722d22b097a2d219d030f920a209316d1d84b91692b989b3020b0d7a2da360daf45a439893ece82836bb868cc15e84ba1cd47ece7b20b0d7a2da3a12ebbe0c873421ecc7b27b7ae4609e84b2f60172a8d9829fcb7f5098882e4051184bd86486745ca3d935015edc9ec35eb10cc97cb4d5abb014e4052ad45992831356aed89c80aeda8b32506a6602bb6a76d5eb50cc8654d5abd6a7772f5a85d0ca9bb57ad4bdcbdb90ba164dc45737275791dd1654d5ab96a7b72e6e4332195356af6e4eee5c8410ba2ca9ab573727b72e5a8ee8644d4209d6ed5e88af5a889ba0059118fca91179356af5a9394278c8e29cc42e64e0b8486b57a081684424211cd99a74a2a3c5c24e03e9a319521b38d8dd2dd6d3316d3d8e94262940908886bbaa1a0c2e783274cd271092eee4c96b130e3091868b89a6ed4a0e3d534e89b7d131014f36d91695d8825b256a271d3446c6d8ea960cf30a785a11e14927c89344e926bc454a0e6352a224911812f63af5e9562905cd3b2e8413982249928924de8ac510781b84e9cb8a64a5d72f5eb92c023aa6dce61e89316173013908a5c092b3148c8d2988324bd8449f812705c492e294226212204bdb91846917201c503101d50db97b722372f6e479d279698dcbd6a7ed5e8a1990e5a6772eee4f6e5eb5166479137015db539082eee459918626e104ab52ad5db515d28352372eee4bdcbbb915d28352602bbb92b72ec208ae959526105edc97b977722ba56548dc958656dd6e5e6e14a7cc5a6c9d76eb7e0c4753c5f24d5dfe65e487ec82a2d4b690c8b11d705b1cd6b225736c8f28f317a37c550e278b883c11eaefa05abc0786cd67eacd711fd4fa792d5680729f050c7707ce115b68777d099da8daf9496f3f303fab65bbae2ef0c357fa2c2f6a7a4c269a106c49b6fe51bcb885ca36ff00ac5657b4fd280302e7578931f2845959bb96ef1938b34eab9ea372b7316174d4dee8b0edd7e6b7edaedb56dab9d2725e4c4be1a68bacb7b2c6fb9c2f9967359e9798699bb12a0e0fcb3c2c4a3245d969cba36fd22be6ada1db271f709d0c471cff0088982c421fee87c8d0fd0ab7395399998daebce3df3115deca7a3a6006a95255ff004afa70bf28c10116865c5ee5b6d222f64061fe490e74cd2ce758ec9daf70b6de297b569c3f62f9ae4ae12f10e9d443f063d946957458cad0dce16a78b57746dd3f4a598afa04d09f2f88ade368ba62962670ddf0895bb2db2ae3ad3d6f0e56dddc3f5c557e9f5aa7ba244dcc4f364e166726bad221e51128c737ed592315162e1fd045e78b36671d72e2ed0f112bb6ccecfd55f2c56e5499b748b76b16f6889dd23f424be20d1aa5b2a1ce3a6cae0f6cfb84389298d86e0e67261e1b9cf55c0dc22a37ff000362895d392f2ee708962fda6fc4a618f0c684bc32705be5c4a865fdf77d1042373b224e75952956cb97f49773735c31ca90014ebac544d328155932b65aa12f83a885e7ad9773daff00b2beeceed4d664edcd6896a16e6189e952ecb42d9c4877fcf0550a84952a6f29ed139770b6db6fbadffd6f128d96a17823974a5499986cbe0f308b83f74a293235a46a9c89ee69d16ab5b275d119969bc37b516196010976478be6dd152bb39d2b5424cad99706725c7e05e6ddf086ff00ba99f28e9f246e185d1f12c85f19e1b5d961732f9c97172e70bba251ff0045c98daa7db2fd2599a179b1b87132e5e5cba93701920766614ba86c750d2d905fd42fad3613a48a6d54445b7065e68bff002730422f5d97cc116e1991cde2b737660ae7080af86299b6526e95d33d6764844487d5e2cbe2f8d7d13d1174932cfb032ce4c6236c888b2f15c530db5f2732d96f271b1f240e1be30f2477ad252d767395fa158cc4706118e643a8edf85b0890a5c1d50853570890b82e3642242e095c2425c425c429a27c95b88330bdd651d5b90d882ac50745722e0aae45e2e65cc62e64af65f348ff00531d9586f5c88aafc5e3e625cc63e6247ecc7ba4ff00a937a82ac116bb49926d434260f9892c5d2e64390e1d511ae63bf951e623da48836287174939081256523aa2e60774440cb0af14b8f2a66112e64bf0ab7892087744e8747d4592c6493834f141b951e54c14f1971256490f54933d38e97529e000924db63caa320e1971258b65cc872cf5721ed0d3eeb111170520a609205a4e88255804599e7c9378c49508a5ee5cdc8ae11807a94a82461279b6d3d011149cf64e88f36e848304b919422e146e2271b349323825081874d545c69bd95e852c94ac5d5cc647ce7a1ecb0a8cfcdbda49fcd23cca52311e65c880f30a2e73fba2349176512e52c7993274c1e653a223d94bdedf652854bc774834111e8156ff003512f42924ac98c29317bb295ed5226ffd3205030a4127428a4a660e1256f8a49aa9138dc3a0eca1e1464a852854b40092a2cf6927da5fdd3a2862e8d50f1a68af78288a988b0291e08287b41ea50344d1b00a2b08572301534326dae153dbe545ed0deb743d89d6d2ca10a229b8c54e4694299729029c150c4cba8e5ec144462b918a938d257614b14ae7b135ec927651372e4494bc69c29054e1e64a13b120d1c8a2ae5c8c54b0c887325782b487b43517b1bfa90a1e0bb01152e2cb4970c2eca067f228c511eae0a160029560f2a98b9ae55c8bcdf28a2e71ec51fb2347f3051506bb2bb064b9549f84b7ca2bde183ca28b9aeec8c5347d5df451a2c1f2a57829f2a3e3389319a4398fec87222fea2a3ca54f9527c14b9548c1f4a83e8f9ae4934f19eaa33c14977c10b9549f842e46611f35dd90f668fba8e84a172a50ca123bc2173c251731e87222ee8484912542449162e1125404920c8e4b14f19d81417807757a12228b381241452b98eee88c318e899f0215df0605e38a6e28fc5dd36720fe54e8b4dae90b687debd18a3ca7ba2e601d02777872a491072a6a315cbd1e54832f90f92385b1e54ac314c83a9d8389a20a92d734a545beca445a4ec1c4b1249b909ccad285c2ef256122e105db517311f2020a2c8ae465c51d6aec1b1439850f670503e08b9e06a460d8af618a2e714af666f651be0649052ca5a02b91124626281a46a878b2b91694c61f65249914ae7a68d17651184b986a4dc961e1439b49625ba61d4c5a8706d390975db097b10850249d900d68dc2f4255723269c19a24b19a457784e06c4531e049319245f84aee38a19de8f931151f16926228e288a68c3b4961e9a74206c858452b70a7099488825dc14ce52375e84057778a46e5cb50b219ac9cdc2b916c57a0bb0448f429184bd165390b5777a198a3c8d4d41b5eb11104a80a2ce9422050b86bd06c51982bb09645cc4a101ec85104b16bba88f065d196493204e080f64d418ecaf465fba8a160938009b322785383d101060bb2b91932252052ebd0973145ce43d97b82a1dd9221e124cc5a25384d9a6ca5c93ad9fba8efa21fcb750f05d52b195e64826c52f9c137ecae1b95196aec011f1114988a5731239085832bd848ab5285b459d18850706d7b0d4a0b02904d8a40993869547c1b5e2046c4173052b9893c841c0576028ac15c8b2867093c9210d115e80a7e2d2f61a199172d336af5a9eb57b721990e5a6a105ddc9cdcbd01433219122d5d8412ed5ddc8ae959122105eb53908254051664a0c4d40576104f4209430492e4a11a62d503b6fb56c5299127049e9a784bc1655bb711c2f97747ca32f02f4fa6ddd0f4a57491b4254f961c06c5c9e98fecad96911d2532ff00eac6edd0871178bc9025f2f6d86d4149f8438530539569822c49a71cbb0c4b947c83bb2c210872aa2c4b112dfd28fde3d7b7f75afc0b006bed513fb8366f7f33e4afbb77b78f9669b98b9c21f32258423cad0b43ba022377d6aac5b4d86c91dd7169c42cdde1687c845f3ef595ec98b9509b79d75e2c36f33c45989c22e11f47d68eafcc94c9604b7572ac8e193df263c5eb4567395ad8efd4adcfb478341947445d7f6909fcc236db70b77165bb888887c5e2f2c7773420b33ace778ae71c7335b71711715a3cbf3ab13f2e2f90e1090c9cbe5b8be1887847bc43bd37090cce3ae36222d8f09711169b79a25e8f4294ccacd94292efdd57aa30b044046db87320a5eef465bb5176559634f0373adb89c2d2cb7abfc52f83187957a0c0895ad136d88ea79c1bb372b63fbe29d0fd132e8ee547469c62de5d2e691f847bb56f0b7feaa5285b0538fe726c5b1bb4b9d591776ef1292a74c34c15ce3dd67ca17bb68ee8c7ebdcad34da95f97108aee26db271cef13a56dbf442290e91cdd938d81aedd13b3fb28126ddc5352326e7ad3731ff00480adfa9481c25887afa938e08f1392af90faad14611f9906529972b8f17670c44bedc625fb53edd3dfb7aa936d922d2f4c10917b250cbf528d7beea5867408b97a0cb3be699987b95c297c2bbfe747708a1a73621b1ccf8b72fde294f7ad3df77d481aad26aa237ce541c6e5fe4e5db2747dd88aadd5ab52c2368f844d17ca3ccb0d7bade62fae29623bec5365e06e15b6468b28256bb312636e926e605a2f6776e246b14591cc41549398cbfd9dc12b8b986e6f766fa16763b54d80895a577f72d3968fad0de8a97db1a7979f97b88be125db698707b56943723e5148e7302bfb8743211b9c7997adc41c3199cc23948b3461e4f8bcaabd5cda1911b5b6a604b94a685ff00e4ddfe6a02bf3328e88bb2d353131696208b8d8e3325c5a77658fa540786cb4cdc133733f26f08f17eb47c843f3c1188efa14be6f50a5ab4cc9ba59899122f86972d25da68942b053923302e30f15c369364d979c1fbdf3c22a2a6d9c32b4caee571bfc695c626c9ab6eccdf0dbf7797e84f3016ec54690b5c7c42de8beddfc993a4a96aac8392732e32dd49972e6d92ea89cb9b122c01f216612df08732d54995f9d52554705c65f68b0dc6ed26e61b2c27997473095c3dafdabecffc9dfa581af36e4b4e332e33cccbe2dccdcd93d85862eb984518c04ae704a223ba10ba3ba10ddb95cd0d7d86576eb318ce0a5e79acb5adafc365a1c5a5cc146932906caba122c8183c90916573093e4d126e20961de6993181d13762f5a95182e6e4aba4d82f6f4b17922d5db7ba88d92812364f14c260c852b0cbb2936172a48006c94e738ee9b2114980a76d2e5498ddca960a6081dbe8badc13b034c665c889a045d2c3edb5d3c4f10f0a64a78b945222c92e4258b95186b7aa6dd2ca7ddbff009f05d8d40fb2b83507176324e72ae782972a57e9f9245e7ee5391aa172a41545c5e84a172aec250b9515a31d9197541ea578679dfc0af4671ce65df04739576128e72a1e0f24a1ceff009bea8737dce6248c52e6246f80b9cabd0902e5479d83b2498263dfea8384c1732ef85123614d2e55d852c90e6468c4151d2e866e73b29e6ea1fabf793c34c4e0d3c536e7c653ec8aa0266353fd5a4c6a87ca28b8488a5425053778fb27f973ff005207f393bcc9413a65c448e8303d95d83428676746a50865eaefaa430e917c227c5aed12f0c053a0e0a61c7b29ac6e9e229b8b3da25edc5cc9fde2ba2d8a466ee9dc83a2660e125e39a7e12e29c160524bda96237f741e3924c5d252106857b0c51676f64a30bfba8a232ed241117694c610ae610a5098764d9a677750b1892e5c4a6f045262c8a509c764d9a577750d7172ae461d9535822b9822873c7644695ddd42d8bd85d95331605262c8a3e7a4fb279a88c35dc02529822bb06d2b9c8bd9145783af783a95c25ec145ce43d9028bf065cf075300ca7300517b4250a20541c185e8b2a7232e293196143da119a150986bd6929af0714a193143da0248a17742a0ad5eb54f1538532e4823150d289d42f0a24629771236324493195247cc6948f677841ee25ec345c1a5e8823ce93c942612e1368cb0b95262d1219d118507104888a362c92e783a589026cc27b20ac5d8348d84b7653812e5ca88ca106d313d1010692a0c9276c4a8368cbd2044988892f6644c1bed2eda939d2f9450d0225d83c488c25ec0433047cb78d8a660f92ec26093b84bd808aed4b0d7f74884c925784aef8392ee1765178518e624f842f41f4a808f2aeef145a764af1752930709762449d080a72101492e1d938d613d5085726e312e55236ae1410127920e80f751b99722d12918457717b28f987a04dfb3b4ee546c25c97bc1894891a688c91891c9269d8103e0e4bbe0e48c18125c5b247cd288538f351f1609730491d112498dc8c48524c03cd098449316c919bd26372567288c43cd0986bd848c80972ae44490e624f242120caf61226224b98648f3a4f2821f0d72d44c1b24a8325ca8674622250d0827063d94f425cb953832a4925e138d89fd90f021e55e85a8b84b125425d239813a2177f810f06fb44bb168b99162d27444536644fb60ba8fb0d76f315256aee1a4f37c92fd9bb12a345e2e54e84c2289b4de0a199a7a21cb78eab98abd025c8cba6e2d23d1192e1b84e9009264a505285a24e8b24866b7549ca1dbb506526493e085caa4460429e1751199c80a661f25110944e372ca4e2e8a4e20a1ce714a14cc1d5071652232e8d8bc2bc2428b3b91f29850380bb82a4616a540451194a314c145c58e515e8ca92961014e405173c84af6305414650b9524a4cb955837249121ed2eec88d033ba80f042e55c8ca129a71f42bcfdc9c6cce3d1477d2c6deaa3099249b11c511ed26a209e0feea2ba203643dabdb93f62ec052b32211a62d5db53d6af5a8b3219133082e4cccb4c32e3ef95acb399ce62e56c798a3fc7e244834be75e96ba496ea0fcc4b4b385e032395c71bd2e1364424423e28dc657421bfc768fcea05755f2a3d373b2bbc130a355378bdd1a9fc283e9cfa4969f789d0e1b9ab848870c6db70b2f0c07c4be6daa54e336fdb761b645988b847993db6b5d27dc211ca38845150d4602275b11cc444368f6b8567dacd0c8edd6e27946610b7dd0b55a410c186e5a55bc365b1b9c70b338445949d73b443a61e8f128aabbc246326c5adb62374c3839b047948b89e8fde565ad4af834b372cd90f843c22530f5da88b31774434c2105006ddade1b59aecce1165c42e171df48b70f40a8d19d6e54879d0357a5a6586ad6edd236b23c2df33eef317f3216646e733756d8f9b11d45fad2ed47fc932e80cb0dc457139f085c5ca2d35ca8084bbe4371752d965279cf385d911e15200ba69c935cab8b43852ccda4598a60b3384a0466cf8ed22ed0e644ce8362586c1716ad445eb0a96a0ecbccbe575d823c445abde4ab868d53258e71d137459a268b13059cd97c226072b7dd1e22f42986369dbb487f482e626ed6dbf67894eca6cbc9b4244e382e618dc573975a3c44576e80fd10dea16af332239449b212d22ddce165e1b87c43bd325c1dd13e016aec9d6048ad6dc26ede16cb3117eb1d73c43f5233f3915c22e393839b5630ba3eaaa5d40b106e6e5de111f66deeee404b540da2d370f136e0dc36fdd4a100b5921d35b75a99548a65bc0f0ac4cb68938586e0f67e2259e57a4df967bacb7fbc6cae121ec97ee53d447187c7a81b4b5392ae767898779a1f129d7e51cb447184592f378cd8badddcb32250de3f3c61e4f124b6ec3aa370ce1658e4c5c598887ba8b95a563f9a72e2f932cae17752b68e52c78845bb6de5d25cc43d951cd4d10db6f0e612e21f594b1a8d1427d9aeb394b0d326a58c4c45c121ecda43ea96afa13f3a18e3898786e0f9e674e5f976c4b87e3843c8972db60fe5176d7b2da5899aef5b84be7829495ac4abe222ee34be6eadc6c71444b94aef1dbf1c134e2ebea13d196ff2954f3ef5c3c2930892b255b6708bad69e65e6f8add225ddf2f8d57a65936ad818966cc3c4243de4b690e1a244b99baf44eb302809446db6db8bd5fb2a6f65abaeca3f2f3328f38ccc4bb82eb64de5704bb25e421f44463e28dd18461e3519493ca4dc0bab7b565cc36ff009dbf426a718b1cb6db7b4370e5e642daf9a58376dfa765fa27d13eda3759a70cce1e1cc3622334c895c22443e7dbf1efc322bbc51f18978a3e8895aef15f087419b713345a8b2f8bd8d2a2f08cc37715ae30ef54f8dbe5d2e6f847d0430f897dda66d9dae34424dbcd8b8d90e926dd1b84bd9257b4751cc163bac5e2f45c87e66ec7a2ec4c5732a4182e5aa7d82a42e3d42722209116879926d5cdc95f1492ef20bb1971e6498b03ccbd1498c1285fba41cbd97b07b4bb064b9971777923d51787b2ee01732e611732e46249318a2d5112dedf54b8365ccbb112e614d462b918a3b143301ff74f7f882bd7dbf08878c17ad43224f33b7dca2bc20b997a13286498c11e408f9ef46426976133dd40ee5eb50e5b518a87a9084d7752a13aa36d5edc8b94d4af6b9029484fae786f69465ab9b91725a87b5c8a44e74b993453c84dcb96a5089a90ea990f545466927c2450f115cb12b235239ef444667bc931984dd8b962195a8195e9dc65d83899b17ac42c11891c8983a29709a14261aee1249635284cf1b22fc3879576152ecfbc84c25ec249e5b12fda25ee8d8554b952a1552e5140e12ec19245cb67640544ddca33f3a1a57e732420cb125782122c91a704f3f728b85492bf38a0bc1097a12a48b971a573e74742a02950a80f6901e0a49709624931c6942a26ec8f84f02ec274147c5925e836493ca6273da64edf4525e163da49f0a1e54040097b7121ca6a1ed2ff00f023bc207952a0e0f2a8f819732541ced7ba88c68c549ff2ca4616aea045eed12e466092796539ed2d47af6f408ba6bb79a2e5a3f681d01475ebd8881b8d722e121cb40d47923e0e2705e51517897b1891986e885580a685f4b83ca0b1c92a0f1241a74e0af53c2e0ae95aa101f24f0cd126cc0427db58d3ba9283629700151909b25d8ce122e5392fda630a48850ee95bca8139934dc488929b111ba69f54d3b0288278bb29317c931692f45a24ee50a3191c76ba59bc5cc988b87cc971652232e4963284cb8bcf7f9af6112e8829316d249b148e7278535903005db1178694208b9894204242e5eb917b97a30459d1f28f742c092ae4f5abd6f650cc941853705edc9cb49722d922ba194a66304988a762d92e585ca9799365a7b2400a7372f4205cabdbcb9526e9434498c4b95713b0b97ad42e8f292922d7692b05382d8a705b492f4e36307a26305285a1450b69506920c89d6c0988369506853916d262093993992dd1222c0ae4258539864bd0024798f745907648c014a83429c16d2858492ef34a11f9262c82f440511802b9160516746633d82108572d45c1914b80a57312792841653a12e9f5e84124bca7044d093069722da5ae4609374bca1344dae6127e02bbb91e649e5843e0aee0221737a2cc51f2da98c35db53b18ae451e6432843902e8b69d25cdc95749c812600bdb8576291114111f45e890a4938bd612f61123d13673744dc4d253f809432e959824f2dc50f68ae880a2301760ca2ce11f28f64d83629c06c7952ec4a114d97279acb745e8363ca950015edcb91484e0b25a6c8d777a4141180813d920de143bb309e8cb0a414aa75b9546939876421ba49b2245465497a1289d0f68510c52141460bdb91d09515df0614ae6849f677202c5db11f83da492651735034e420ad5d80a2f012865d1f3020202b21fca836b8a9741701a730e72a0e0ca3223e7303ff36e8fa4460d9084630f97843d2be4baecc94a5399941fed1305e13345cb972b45f40fda8ad63f294af0cf6d04ab170f82cb9109692b5a9622cc2430d2642e1ff890f8a0b0fdb09b274a60ee2bb308f744ae2fda44b3f57273245bfc320f66a70dea752a9130ee6b95bfa2d956e1324fba37372e37089713e5e687bbe98f75573c02ec3b74db738e708ab550e2db0c913775ba488b538e969111e5111228fd49995d66d82544dbbc92ae7527bc25e71d2111e111d3a47295a3a5b87a3e350b3d36db5ab8b48b799c2e6ca3a579b3275bbbac21d586456b77713ef9710fa04125c98618cc2588f10ea11f37fdd7694568b296e20a026a789acd8642e1691ca443d9748b7c6efa1571f71c9972e2221112e622b4b96e2e253710174b366bb3618e670bb245c3f1c518c53eecb68ca88e9cb71117f37cf14b32008b9772a325a64581eac5bb874b856fbc450ff45e3aebe7a6e73985b6eeff00ba99fccc256934d93c4398aed23dacde2bbe650f5ef09639991e51b45c2f6787d2898fb94b730809d96a8ba3aa9fdd21bdb2bb9888a3bcbe2dca69aa8936de261b625f276b5eb69d5f5acedc75d70be11c2ef17ba29a6e262599c26c94874408d144e7106d6567ae55da2bae97b795c6dc21212ed0f909549d2811144aefa453f30e916a2c4424492a36e54dceeb8b2969089088985d7090dc424570ddc56ff92b46ceed2862613e5736e65cda84b9aee642747361938ddb73842570f331f0843fac0d50eea376a366ed222b6ecbc36dc43c2e8fa1c1f8fd29a7919b294f301b5da9edada60ba237657385cf9468749108f15be982cfe75a212dc4ddbeadbf8fa55c366ab02e8f82ccea1cacb9f083d91ed7cc85acd3356215c37757303a84b95f1e114a8c961b149959cd171baa9de5a78797f954ad198b84b37577661bad21e2b87f8a546448433758596db73f115d9517272960dce36e5a5a6db7ddb52defd13714041bb9392cf9365ccc90da5715a439b5365e5f12929da234e8e2b4459b57eaf94884784bcbbd46152c48bac2197fef0ae73d9146d34d86b33530e7aa58445de12f15bf3264f70a4dafa151ef531f96eb2c2b4b4bcdf097687c96a545dc41c032cc257089715df26e7f9db1f12b2355ac32cae0e1b843882599bef7fd94b9b92cf8e66e5de6c86d1d225d96b1474b90cd6eff00a1204c7a84a11dc68a84322fb44370b8de6e5cbeb7a17db3f9286d704e5319a7bef36535223d48dd99e91cc4d8b776a71a2c4128796036c57c93169c685cc071cb44bcdb9d6108f1097d0b4afc98eb2d48d5466df26db65b1c070789b19bea89f687746368ddbe3b949a5a92d934f450ab689b2c25a46da8f82fb1a6e198bbc98b5198ad3a22e30e0b8c96971b2c412f587c449a882d3c6fb85cf2688871050f6ae5a9fdcb9114e664c644c4417ac4fd8bd623cc8b9687c35ec344e1a54010ce8f9283c35ec346da2bd68f6517311f21050697b051b97b295bc50e6147ece10180bbe0c8dcbd95e8f790e6147eced41602f0cba2f78af40c50ce51085885f064b19644620a5c1e1445ee4a6c31a1232c2b9196146e28aee30a4f31c97c98fc9010955e8caf651f0745762e0a3e6390f678fba8c39648c1529188a4c6029425290ea56f451f0974b84aa386229507051195c8db4ccee808b2bc1eaa34e2249360a1ccee8f936d8a6211eca720e8f2a72c15d8362925c12c34848bc522203d94fe18af4196d27301dd28b09ec98c31eca54210e54f41815dc11433840467c935b87957b70a760c8aee18a2cc12830f926e16a5098ae9309052885c1ea810f1b009c810af6e14314a92e619a3ca3a149e63bab515168799262ca6617aeee242c7ba1981e89716c9730fb2bd089254228b547a24e11241b048908a5c10ce425729a503e0e4bde0ca42105ddc8734a2f666a8cf0525ef05527b976d439c50f646a8d84b25601292180a5da29266296291aa2f0897202a5ac15c836293ce4af64ec545c5beca4e17654c608af600a1cf40d15faa86c35d836a6612e293193147ed0117b0951362ea92f011e65e8d3c7990e73517b23fa051b08a542228a769c878c912587b4f54d3a291bb85c84452a0629a3608522c476053799cde88a83a2bb88283dcbc864095ce3d919880b9782137a50c50c887389ec8b17139034c6e5e8241013ad79088de9487b92a069364e07f74ec60bd04dc1c4a81a2b250704b80aeee48debb024452c592e0bdbd7b7af6f494a5cb929720ba8230bb082edab908aeef412c2f58bd86bdbd7b7a2d50f0aee12ec1b49b976048b54632a558bd6ae5ebb0245aa55c2ec20949308aeef411aeee4a841277af5c929496bc9308aedc823baf457176e5ede820b89505cdeb9bd04694bcb908af6f4112eaf24ef5ede82095bd722b9bd737a085d757b72f6f5dde82165cdcbb6af417b7a08597a02bd6af412a08905cdcbdb92b7af422825582e4057ad4adeb9bd2754345eb57b72f449262686a868976af6e4ddebd7a3b219827179377af40d1d90cc13915c8c122e5eb90b222e096bc9172f6f42c8ae9693182e422ba8591ae5abd16c5760bbb90ba2b24610aec0052ad5eb504328ecb968aeee15eb172d448ec95080acb3f287e91ff00334a372cc15b3d5017c5b738a565846d7267fbcb884437f16f8f8eddcb47aa9be32ef14b32331342dba52ecb8e6036e3f6f56db8fee8e10c4bca5ba3b97c1dd22154a66a2f14f3cdf874c4c3ed4e1095ccb632c58584c16ecac888d908767e78c53529b34eaac28226b9e0b85fb0f3f3f454d72aa4ed444c8ae6db6ddcce716109115dcda90b3ec88b24d966709912f58adbbbb9ae8a664616bd3ce10e5165c111fefed1f54a2288a9be58c258798991774f64ad5577bea5680f655b6a51c2211cd863ef08f2f317a159e8f2971088e911b6e1cd87cd85da22b61be3e41151f4a3bf0dbe6bae7394757b512f2279faa1b624c35a8ae1221e1e511b78a03e28a6de50161aa91afd49a6fab11c421b47569ece5d5f3a0e5241d21172db7133138595b11ecdde34c531821cc4d89169eb348917317117cc8b989cd42e6215baad2b84ade5b748c3e28268103409c03329590931b729165d56e5bbf796ef89483122e08e52b6ed389abd942d073da425772970dbfb752999c684ad1b888b36a2b46ee522e1fa13454c8d9a288986dff36534223c586dda23fe5d6b8a31f95d44458c5c22f17aa394757c7e2f22b6392edb7e71c6c6d1badc4cbfc6e8aae54c98d42e0916ab8448adf59201294e68b2aa54e8e64e5cc36f37ddcd9bbc31ca3f328e97d9b9e74bfb3b9da27320fac4e6e829dc716cae1ba60b98ae211f5474fd314b7aa73243c24575d9bcd8f6444b529a262d55eea76bcdd354ed9d6cb24ccc4acbdb949c12271cff00a7e2224aaceccca37a268ade6c322f58ad86f4a8426486d22b488b85b1f748608b95609c2f3cf088da369165ed165d59bc904d9988ea9f6d383d142c9d3098ebda98b5c65c226c844b48db9be3b6376e8c23f3ab6355d6a71a1172e6dcfd48e56cbb3fab8fa21e8f2244240848884aeb86db5cd4e73654a7ae6c6d16446e1cce0e51fe36a6dd3170d52db4b9765073d48127315f71b65be6bad982b79407fd629c6aa32b764730c74b8457384e0f15d7788b7a1e7a5408b3f53cb89d665fef074fd2a2864880ae1b6de1b73277470d4a6b9443959a33c3865e0d9992e5111708b949c286f1fa9414dbee8661c61f5446dbb97f8a729d0705c120d5a887fa55a26e4dc74ae2e5e2b7dd4d19030a75b06659c3d98aeb888bb5fcc9f625af1ed0ab6bfb365ca436f650d4ea018bd690908971709277da9a4689b14842ae84c105b944bbc28a6a60750e5e66fe0cbbca62a9432122ca4a1612c619a0dddcd76946c7b5c90f8cb4a9891a990f0910971715bdae6ddf1ad0ba2565cfce7224d4b8cd3de103fa2e5ebb98734610b623e3dd18c2176ef1aa1506a02e65705b1e52e5ec92b8ec53852cf0cdf840b6f4bcc30e365c22e095d9adf1e1c447c7b9344e57a506ddb65f7451698d34e38e8c8b322e38d8dc52f8586f5d9ad7459b6e784bcb1208eef419229c8a1763ebadd529d2f3c036e337d608e917c72be23cc37096e8a3222b514c5a5b71d573fc4737332b85ada6e988a4da9f8c1737299995696a6772f5a9d8c17ad43324e44dee498c13bb973723ba19535b972229eb57ad479924b1316af5a9eb57ad4332191336aec01396aeda8f322ca91004a8322bb6ae5a8ae9400ec9632e295e0e29adc9493af74b05bd92fc1857a32a29bbc9760648bc5dd2aecec95195eeaec255260e1258b84878bba3193b2ef832e783972a7048b993c069b2e29e6c6c3dd0b831e55c8b25ca8fc55cc649e63bb27390cee818345ca940c172a2e2e24c0891e728842cee99f065e8cba7f32ec208b394ae537b21a0caf60a286097bc5032146200808b69b31525bc5750e6a234c0f5515b97b72942014d1b2294254d1a523628282eef45c1815e8b28f9810e4b909792f62122f05262d0a19c22313bba1c4d76e4ec4573723ba2ca534bc9cb57b723ba2ca92304a808aeae6f494a0005d808aec0052624b97a16285c27202295953172e5e8b294398113bd7af42c4d7ae47912b9a8b838bb07107bd7a048b2202746e2a541e140deb91345cb4af6852107d760f28dbd7a044872822f6a2a4e0f0a541f15131b97b7122e4847ed8eeca562f8a6ca64546d84bb06c91889bdd11aa79e88c39a14c1be3ca9ac325ec224b0c684cba47b9762ef65208fb29706492b012ae026f2bca1e249312444582498cb9250704d98de9c8452a09e9662f2b45483ccb6d0e621b9459276b375650523e4d945ae6f4e1ba249308a36481fa8426a77466c5237af5c9715e4bba672949b97af40d4aa6d35a8b328cffc56c261d53183625496d24ae17014fb8fdb98b4a0c6b0d5d6dcb33db5dae71d2b5acad8aaf4ad75c1e24c3ab05fc2a6c786bb2f8ceab7966644b4a7204a8bb0f5cc4cb72be892931c9985d429612c75aeb8269707172314d4ccc0b63712324017292d6926c13f024adc85a74e8b8899b9a111507dba32eb056830d932ddcbbbd7b7a1d87ae4e6f5346a2eab9c0b4d93d08aec093172edc8ec8664f6f5ede849a9816c6e506e6d4b4256dd728fcf65eca5fb2c997310acdbd7b7a8990acb6ee9521034f0d7651492374f6f49272de24d3af5a37170ace369f6a1c27084348a62a676c42e548a5a774c6cd5a48cc8f30a76f592d12bc7899895dbf3e8da2a3b6bd996e549387499b28565b97af514cd69ab7b48e68eecc9ea79c4bb266aa98c1b94fc0d7af4da1aa33cdb0d938e15a22a490144049d91b72edcb2bac7497d661b0377695a765ab2e3a3d62684ad26c13ee86468b90ad772f5c9a84536fbe20371108a7744c824a277aeef51a35b96d22571279a9c6cb490a644ac26c149741235b7211972f5c9ab97ae4f6551b3a7ae5c89a0a6a7db6f5121e5eb0d39c49371b25ea45eca52e5eb93626943147649cc9772e5c944ddba93718a48734ec96e639a2e425c22bdbd4656aacd4b377b856acea6ba4a271ec36072f3227c8d6ee8e389efd405ac6f5edea0366ea64e88dca737a53483b2438169b14e6f5ede9b8457b7a3b22cc9cdeba9971cb46e2ca22a955ce90186dcc36cae2d37243dc1bba5b18e79d02bdc17b7aa45376cdb2d442acf4e9f1746e144d7876c94e639bb8523bd7611429cc0af38f888dd72048ee93675f645c0976f508dd5c6ecda51ec4d09e9d2988ea18f7656a952533e36e67236e5eb9337af5ea4655173a7ae5eb9337af5c86547993e115f1974de04351a909323e14f4c4cb596eeac5f7cad26eed4440231897d2bec781af993f29e90baa2f4d8dc442d8cb0ea1b5d1966ff00d3137c22a2d5e8c2adf0720c842c0e854f132168b3623cebaf765a9621d5d9895b082819e9c2329870748b96b76f0888dbecff0032b452e4f0a5dc7789c65df644846d1fa5c5014a931c321d2e113a5dee1b55537657b2e8a1659e26db70872b970e1dbc36ea24eececa95a4e10ea2d3f64bb2312f1c63da820c9ab49ce211222fe51575d9588b5282eb9a9c709af6735b6fb3eca0fd07aa6e36dcd8a8e8cb165baed2e93625c45dde5f8933091211b4b2915d717362708f2ee52d3d303e1ba72b32e2369715d9bd544cabb882e62692f365c575dc2a33dd6d94e63015054b9729470b51364377290f77b4a629d3ad3f946dbb5758e13457774b51296853b15b71db7cdda23da2ca29aa86ce0ba4ddcde6707106dd436ea2cba463f3a68ccd3ba94da770d97a6da69a1b8865f4e5222c5212ec8ff1555aa9b6e656c5c708b313dc3dd116fc4a7ddd8bb6dd4576a6f55bdab91b25b322d8e6cbca5f8df04933346c872243d1546974b2d20398958a1b3d6b822e109171728ff32b34bd22d11706d12e1e6ef5a3a454fecf5247ceb9691708970ff3265f3129e8e9835561ba0da4de51cc24377e3f6a9591d9b69b1b6ebbd5cc45c2acb32ce2b82c3622243e79cd423c56fc572bc6cf6cf05a244de5e122d5773767e848cee29f11b7759a96c98fe8e56e9d570da571717761723a6f629a26c9c1cdcc3a7d9ed7ccb626f671a2b6e1bbb4459912dece08f0895da929a5c8cbd8be6498e8edc22f37c5972db77f2a549f464ee52c3cb76ad23ddb97d4ccd146df3624bced01b1cd68f7787d9f22578fba65ce8fb2f9ba43a332b86d1bb375856f17c90f67e3534fec290dbd5e6ecadc7c04474fb36a68a97c492414a0f1d02c5ddd92cb6db6fda4d47627cdf565956d23296dc36897687577537312e36e51b516a8f30ecb04af6ca15c56f08aa753b66889e704879b2db95c1e21ef7a7d55f45d669ed966b74f12afcb53844b489717290a53642d446269e8be63da7a30ca3dd596ad3ca4b8f913ac088e526dcbb2979c21d577d0b45e9ae96224db8223988aee1f5966124042423f2656f68bf1f1a971bf30baae963cafb2fb67f23d9e27367dc688ad2979c744473108b6fb4cb83ab48c4f1230ed5cb597c7d5e615f3e7e47e64d94e09b8422e36222d90f56f10962b457792e10c787f88be8638dcb47446cc0b138d47faeeb7aa1f72e6e4a4adcac2ea8cb137b97a304bdcb91823ba2ca9118250b2bd18daa32a55277cdb43712875755c902ca7d0d00a826fd1482f21645836c6e74ae70bdd5d9b9e16d1c55ac736e5265c3640fcad088dcbdb932c4d090ddc2b3fdaadb7b5c26dae14e1aa6017486e1d217655a09bcd8f10a5846e58796d7b97662579d8dda8c5b45147541c6c95361ce8c5d5e6d5c8c179e99111b888450015b608ad12b9483201ba842071d91d6af5abac3a25a5335399c36c8b8b85032002e89b0926c1266261b6f5108af3330d9692b9657b46f4cb8e11139eaf2a3f672b385689166515b5a09b2b076185adbdd699082ec10f4998c511215262023de4f4950d60d546828a49490de8868254228c718ca8288a5472078b8452c2e88d8aec57610507b4db44d490e72cc5a455764b6d310b57aa90f9d8c36253d152c920cc068aff0004a8128ba654b1148de960870b84db9a586c52e26bc372127a7db686e70ad554a97492c065151e5a8119b594ca6a474a3313a2bb15cb972cee4fa41174b3165e5572a55485d1b853914a1e1313c0e8ca9381269f9f6c32938224a3ebf50269b2b7ce169593d51e99270889cd49b9a70c364fd352ba51996d8ccd89692b93972cc766b6845ab448b32d1a45ec46c4b992e390385d14b13986c8889a8dacd6da961b9c21eea39c8ac2ba63aa936f6ab8b845091f95b70910c79df62b4995db56dc72d1b5581daa362de2112f92a8f529e27ae1caddda968f29592704448b4f694296b0c6cbdb553d987f31f6bd82d71ada46c8ad152f2f30262b1a62a42d712d1f631c3759bc86d1e1ed24d155be57d9c8abe8190b3335592115ede93b946ed0561a936f11d2b7b2ad5c40172a95a1ce36014a24dc2b2a9ce90c9c2cb94558365f6885cd44a0beb9a0d9aad62c2de5b771b792ba45237a4f8409269c991153e17731b70aa2a59ca71694fef4943427452866853a5847451c1074ba29b6ee489c75a6b5399953b6ef6d064dbb1b2eb0bdd59655b6d8adb9c7ae2ef2a0aac55d1c995adbad651602c922cef7596f92f36d9e924fac4360f6f848adbae25b0526a62e8ab5a7a8120f35435746e85c6db29082e146d5ddeabbb7352c2972b7893cf76504a8d1b33b8353757dad69a2b47310a669db522e16a59194fdc45993d4d9f2278444bbcaa8d5bef72b4430f8f2d80d56fd293226370a7a2e2cc4f6a08045b6d134dda070b5125ffa9c7b2887079752b4681aec0d44d32731051b12563190f6dc2a9903a376528abfb4bd03410bc3cc29f66223989148e0c6dca5c0d7caf0c684636d912e1c08752e3552144cc9890a8b1d466362159cf8798db7ba13117a2ea0e24849fa9b6d0dce15aa638068b92aa5af2e3940538cce8b43712aecf55c9c711d392b76a51854ecca2989a5c4b95ed1d401180d22ea469ee112036876b25a5329382e39ca3a4555fa41da7294670982b5c2d4e7f2ac3eaf5eb7988b888b5283254f2cd98a7be95b358b96fb27b7a2e17088ab047681bc12212ccbe5b95ad90e6b95c76676849ceac891b6adc410a3bb0f66616564aed5c9d70ae251b02ef20ebed9379ad251d1ac888e62549231c09babc665b591f562cbda55999a810eae1576d8565b9bb9c2d289aa6ca30eb99b4dcade828a5963cc02a7c4312a6a79031ef009d523a122766de221121647896e708aabecab2d4a4b8b4d0888f655924faccc3a4751708ab7640616789679f5b1d4c9fa67376b259b96aaed78cdc1cabd5bafb7758d66b75120e56b8de925498854979c8cdbaf9ad2e1743cb19de35e9e481939c7dad29baed5e66d1e115686661873845075d8365aadb45554770f015c4840612519b28644c89129a812a4cbed33625863a454e495641ce25b96d14ac602e1d173238d534d339ad70deca6f7a6a66630c488b85340fdc85aa062376dc987c66c4053e39d8d70738e8a85b77b5a4424db5eb12caa7ab8625948bb44b45dbd6da61bb4731732ab7479b23f9d26c7132cbb657385cdd954afa77b49b8b2d5c5511cac0e61b8531d1c4fcdccb8386d95a3f085a56df26042d8dc57121a0dcb4b362c4b322db6d8dbda24c94e238aa4b344ccf4225d7646541bc46c85645b652462444239568f55da06986ee70bd559ced2ed630e8966b53d3b04e01b80a1c321a5716e526eaab42a838eccb6d089115cb6993a48e1889166b732cf36427e5a5849c111c47388b52b0ca6d28ddaae25593d318d5d53ce241756f92a7034571662533250c42caa8e15a270844731172abbd3dec297e5224f50bdcc04a8d5d0891cd6a7a6222de5598f4a0e3afe51cad8ab64c4ea8f9eb5f1214fba491dba0da38d9a80b1fa7ccb4d1758af3b215f6c88445645d2abbe0cfda3cc9ce8f2b7d6379b3112435f670452341695f50bd3e2d304e9708dcbe7cdbee901f7e60845cc36c4ad1115a36de55b0e9c2ddd98857cd75b9e068888b3384a554bce8d5068a31abbe4af14fda5747e10bef12bd6c96d5913838856f65619459f71c2cbc5c4ad54f9826c8494569b153e46dda42faaa91378ad892ed626f099221d4aa7d1d556f971b8b854c6d53e3e0e45d956ceb88f32cfc45ae9b279acc76aab4ee62b8944ece571f278446e2cc85ab3ee3ae5a228f96b581cb6dca9a771840713a9e8b4ad843fc206816c34aab360c8e239994f53aa0d6ab857ce931517c8aeb894951ebce897585eaa49c4496d932cc3035f996e155a98dda93cc3bd5dca87489829921ccae4d80db8776553a168b02dd5375760d20ac8b6ea6a6ea13a4c34244db6598b8457642882c0e6d4b44da49a6251921684448b517112cd2a55bb94695c4bb44f534203002aebb2f3f695aaecf4c8b6de2195a222b36d821c52b95936d5a2759c26c94d80b9ac24aabab8dbcd0deeabbb49d2308910b5a478b9945d23a42b8b312a9d6f67dc1d4abafd2dc6b372a882691c6ea7fb2461b6b2d6f6fb6d3f44b5b2cc43c2b196ea0575dc44ac12d49999967289778b8552ea92a52ce10dc445c4495212e3728a08c341015a646a44259896b1b05b437379897cdce566d1e51575e8d26265f1b9b1216f9937a84f35a1ced56d550da1eb846e563967311b1b896264c4c94c888dda96c34a952160710b853f514c5b1800dc9e883248cb8b8d801d5483520deab94930e0e915568bc44568dcac14c0101cc5712629299ed7f885947aeab89f1f84dd48ef5edeaa1b4fb582d161b7ab8895426f6f5cbad1529f5d1b5d95428e8257b732d7b7a85aded2cb4b6b706eef2cea6b6edd36ec6fd6254f9e649f72e75c22bbb488d635da3538dc39c357ad664b6fda74ad6f4f32a47e50ed36fc838f890893cdb436f1756458aefb0430deb941a6b4d88e6503d3d4c9372d2b60dc2f32fb05cb734424d088f96e2270b7c795b4ccb2978b1563434ed64976ac46a41872cd95d715d843cacb4d5c43fb7caa10e5bc1a5c488bace2ed62dd9bb228a7a708885a2cd70baef646d1d24a3eb1117306d2ca42245ea9170aadbd95c385f7507b4526402cb8236890dae5bed0a766e6c45995686e111709db6e2cd6f12919bb5c116b315def10e9b556ea4e1932d917091090f10fe3323bdd165eca6244b15cc41d44244e7747894fecfb38856fc1da445d9b4728fd6a3a9602dcb63e9271916bdae2f6454dec24814cbcdb423a8b317ea87ef454299d604ab2a766a2eb46d99a580ca08b9f099adef69ffed3df9b8b12ec32c4ec95b70f679b77c4b4496a48e1b636e911cdd91d222a12b5b38edc44c10dc457710dbfd2abec42b66d9576765eeb442d6cb885c1b6def1717d0910a2917c20b9d9646e1f67ca2a4b1671a22c4976cbbce62fac9e936679dca4e13225c32e223ef7952c14674519314dc21b9dc36c4728b7c43eaf96e8fc699a6494cbe56cb3244375a4f3995b1eeddab2abcd1762d81cce0cc3ce733d73bf695d2428ba72da23a787dd41b1929a748155f6436485af399b98798bb5cdbd5e24a44478447f57ca8c95a5da231cc5de24704b7647d5525b159439271d134cb03a46d440b29d1683952a2029db28864ba64813316e1cc8bb134e0a04236b90c2d243ed0a2c6092f0a2212c3b5516f359547cd076ad534e432a889d1b534e0a430dd41ce0652e2d4a0e6d9e21b72ab14d0a889ad2498768a4b164dd31b224cb39735cefb2b0d9460bc24bd521bb856fbd25062383ca236dbccb3162903d73bc42e5d6f0dbc5defe9522075828554dbb97d1df9394c6153a68b2e2136d10890f10910eaf9c5cdcad75bda499b6d6c48799567f27f931194221eb1b719749ebb575443697b436db0f94847d0a52b75d6ae21caaf6390e505666ae3064374353f6a26712d2b968343ae89da244b1ba8561bbad6f5122c2a06d376b6598b51270d672b7508d089765b73b56607e10579aaa345a4960de18f915b885da53f4baa90908dd94523fd50df64938400375b138e0db95030a836df28a8da3d5849bcc4869979a22d57291511f3da1c0a62925f67739a41f829666731dccba4551f6e6bd87302d8ab7ca4f08b76b6a91b51b3f88e6216a4e525180eb3b5f44fcb88b32e63e0f55eaf6d80b125abac21cab2576ac4e115da8b32d16a5b38de1dc5d615b9564d5fa34c8b8586256a6a681ed71b820238eba0987e9b81f444cc4ef69587a3dade1bd68dc56ea54ca5d0271f2b444b96e5b2ec56c40c9ca1116679c14868b382764176125406d76db3eebd6e210b6df08a068db42f9165bad44bdb2dd71139cca769d436c785074721f12389ac0036cadbb155971c211cca6f6c26c84441b1b9c24cec3d21b61b274b57d94bab551a1171ce2cd994c8daf7c24855533a38aa9ac2753b055216044ad70ae738bb29c6a858ae0daa92f6d0dcf166e256fd8eda1cda942303da6e55e10d2db05a6d1a40659911414fd40b105765aaadb8375d9544d5eaec37710e62e1539b199067b5c00a9c55434eee5bdc0171f8fc029caced4352cc8e210ddcaa9939d210f0aa257a7c9f789c22eea05801baee15466bded24374572ea18e4b17297adb8e4db98a7ea8f2a0696c5ae2742692481c22b4073169474d3731de329c7c218db342d2b6326048adb95c48952360e9452cddce6670bdd52bb45b48d30d97ca5b9456968e17bdb6682b1f8bd54113eef7003d567bd2b6d0913d8425688acde6a711d5569d9c9b221e6cc5c22a32bb4e734b7765e255554d736421dbabca0731f0b5ccd908154b4b295c4b68e89aaf70da45997ce44cb8d96925abf45b53c01b88b3214efb3d1d5c79a3365a7748f5bc01ed2c8aa5b596dd994b749756c41bb52caa9121333736d8e1daddd9ae42663deff000827d1374f2c514633b80f52b72e877670e6cbc3a6ee1647336df37796c119d1d23945576951f069065bd39474a1a5ea77248824560c0c70bf75796cc70c8bb2be6fe95666d9b22706eccb7292a90db98965dd266cd94c913829d6e6232f650e58d91bb377597bf561b72da3dd568d97a3bee4be395c23c22ab921b3222f75ae756d96657d776bc5a6c5a6846d1ca9a735aff0dd3cd391a5ff00203aa2762362dd9998c59b730e55b2b85bf945b34b4c34222d85b68e5115f3e8ed73e45e73ee8ab26cdedb0b5a8849ce224e446286e5b7254399b515166b8003af52b6822b55376bb67ca6cae73308e914dd236985fcd72b0b136999677c9beca741451c5ee8d7bac276ab65df69cb874f2a2764de212d59456adb692e26c912cbb66848a64ad1eac4b516946c833ec9c7c82305ced86ab52d9781bbd639947845586c8282a3cf096552d8aafe3a7742d0d2b072629155ca5cd09ec31e5497ed115035eda66a5b2ea739553a776add32d5979558c1874d30bec152d7f10d3d1bb2fbeeec3a7aaacf4a8c113d75cb397766dc7cb315a3de571db19c71deb335aa0765c1f9c7b09be1d45c22b0d8c534b0d41635757e1dae86ae8db21ea974da6b52636b03739c45c4b5de8b261d2f3825eb28796a74a4b65f38e71129da4d445bca19453546e742ecce375231089b3b32b45968f08aabede49e23256e6252348aa364398922ad3e3a456a69dc2a4582c2621ff977ea48745f3fd4691322e1708ab1eca6ceba2d93ae69e6256e9e36312e3b7babdb4154c462d1caddb944522a30497964a3a4e31a47cad89ba93d7a055683d9979fa88b79ae553a8544da222b4913b174a9baacc888890cbb65d6170f75653d9dc1d94eeb78260e170b54d8ea9f524fba56b23c45c4ab7b45d231bae136c656c78b9923a5f7fc1259b966f2888e91fb4b268d409b1cba959f39cc60634ff755668e37485ee173f65ab5276bc84bac2f7968543da56dc1d572f972526dd273312d03642a4e0b8229b64cebea9e1031ba80b6c98992bae147cacf997563eb20e942de0893a43dd4642acc0e51b7bcaf1903de059aa8ab317a68b335cf04f64f3eee18912ca36b2a24ebc571176456ad3622eb2443a6d58e56649f726485a6c886ed4abf17cd60d09ce1f2c7973feaadfb63b6a4d3b86087a7ed4918e62b545748d4ac3b9cb55064aa645974ae8f4143054d307b07aae598dc55b4551a3cd949f48956c572d12cbc4a835568494ed4e5c88ae40cdc995ab0789d1b5950e04aeb3814ce928d8eeb650d272f994e6c8bd6cd88f0dc2a26d212b7891d2d4f745c6c5bf385a8b95456d1dded6b75ba9b2d4648dd23b40d17b95bcd524d876586db6eb566f3db06eccbd6b644224598bb2a4e4e6dc684471330ea526c5608b896a5dc2cc2d07af55ccbff00b84f6ca6edf0df445c9d3d8a7cb8b4deae22e651af5648497a61c2750cfc90f1108abfa4a5869630c76c163315af9b14aa3235a75eca72915b270846eb7994f6d2ed51608cb3456b7f0843a8950a4a2d36576228fab569b22eaf85657896589d959111f05d238070a921cd2cc0f617fd958dfa9da39544bb58b4b52ae4e55bb4a027eb4b2eca27bba2e92f9dad5b76c85489d46d6a6c8bab1d3c44a93d155546dcc4ac9b433c3a414fc3309e6d5341e9aacff1263029282475af7161f1513361695c24bd275471b2d4983748b5260974fe502db15e728ea1cd9338ef75ab6cacf62b695b55560966fc7ab84557f62a6b2f754ac9488ccccdeee616f48acccb036398b9db0d6ddfc96f8d53aa29d8c61f11ea7a79aa9cd51df9c1c43ca3ab32b2ec2483728d9664eed8d645a1c31b7ba2a024a6c89b55d885217c2e9c8b5f60b57c3f8b659d94435b0d4ab7bb3d766551dbbdb46e4dbb44ae78b48a241d730c89613d20cf9393643c5c445c2b38f8dac65faae84f758d91957da97dd2b9c7ae22e1e1151e13f76670ae55475fb8b0c7d624f4d4d0b63abba3c4a384c156a1ae38456b65de2e1147c96d45a586198b889505a78cb2f9b6fde2474b3e219472f6b8903aee8374d96f3b095d69bb7e11e2f755f6ad56709b115f366caed0e13822d8dce17172adef66c45c645c70b32b3631ae88060eaaa23a874754e7cceb0b69fe74489b9d2b52f67a6089c24e4e9b45945220e372cc38e711295ca79018186e740a51c4298ddfcc161a959d74a1456dd7c8888489436cbd29a96731ddd2de915eda6a991384e7316554eda0af10888dcb535783414943cd70bb80faae714f8b54e21885a37111b8dbcf28fcabb6d26d03937766ec88aa5ffe19275cb8b32768b531e256ca4ce892e74e7126e5751630340685ed9cd9411e15651d97b9764aa8d88a98a7560486d42320381297234969037b20a56abe0842d8e9577a4cf785b36969541a9d3714ae573d9463099b5740963826a5690171c3354d0d73eceea4ea80da4970604b08732a0cc3c5766d4b4a75e6dd708795655b6a44dbc568ac36374992501a3a2ea1c33592d453992437d513171260e5b99561aacf092eccd6c550f2cad2e70b4cd9dae936372b4d1f6849ccc44b1c66a442c8970ab1ecc556e6c85754c3b06e5e182423c445d717c5b129a5c6000e2230e02c9ddbcdab227b0c4b2aaa4c14db9a592b5695b27b20c38e784bfd61708f08ad164e8d2843e6c561cd7c54ee2dcb73d575a6c0f9580b4d859651b0b507e59922706d577d99aee3dd72b0ceecd3063ca3caa118d9f269eb87288ab8a4c429a685cc22ce3b2cc627875432a5935fc0cdd0f55a6dc44e2ac4f52b11c16edbb32b955a772db6e514051271b172eb732762c3256c77164c49c594ae97258fd94cc85285894c3b6db8551ebdb18db824456e6527b65d2136c754df5d31eeb6b37aaed4cdba57115beb2ad95d0c6fb3f523b6cad23755cccbc76603adcef6f20a4a99d1530fbd88fb822d8f0abf1b4c4a362c30d88888f0ac8e5b6a5d12d4a7e93b4f715a44a650c94ae92ee0a931e8b131016c2eb77237f82bb52dd1c4badeb095aea226db388e9774542ec58b6458e79add2287dbeaf5c49cc62a9ac706c5a1b6a7f09ae13c2e6922cf56e2fd74076f52bb1acdb990d31b545690896654e9aa9a883aa6659f124bd095ba752436d5a34539549922cca3778a957a2252d88ab4dce8aad9a22d76aa546e042906cd05589dc3cd72f1cd8aac6dacc993786d8911172a4c39b3a3940caa56476ac88b522fa5a339ba2c9be259a9f506df704757833ac3ed7b3884dc7c7f37c6b2e93099021b9b215a06cd30e5425a7a46e26fc2257087bcd3adbe23f5933bbd656791ced0050d92b2321c4802ff007d164b32258cdb6398b2dc4597abbb32889922b72fc1dd765cd99193730de391169cd690f3269a21bb35d695beca82ebf556bb942523171db2d4e0b8243dee15355ed9bc216c884ad98c4cbc575d77de282d3281d1e8dcdbe596eb4b0f8b4e5561da1d986ddc322bad1ca3d9ecf774c5437d459da2b4829416eab0e9361c718163e47cde5d5f8f22dc3a12d9ac2631cdbcce69436c96c188be4fba5cc2d8f088ff00dd69b4997c36f0c7874f778532e7e7529b1e50a465d8bbd5f7949cbd2b1352e511a12d5c2a5ce79a6f5108f78929ad0774d49211a051edecbb045994831b3cd069111f55392f566086e1706dd3991813229e6c6d511d2c9dd21a96b7e0c4bb4dff002927c190e5f69709cb74a5637a538004c92e291850f4097aba52aeecdc9308f170f2ae386927442c4a78497ae4cc4f992a31e5457432aec22b844922493c485d2acbcb871eca544bb291bd04a0877c5464dfb4a41c251d3302b8b99365486a889c8285a88eacaa7a7623da51731051dea546b39db7952c1708473172f0ac8e6e6846d112cce13a4569708da36dbc251f2fcebe8c9b90c417048729090fb4be72db6a014a4ebc39ad12b84b8bf1992a07004b4a66adb66e65b1f42d5126a995072e2b6d618cd96d75f271d221ed750dc7d555eda5af5a459958f62a50bff0c33946e9a987e66ee669bb659abbe826df82a33bb1d3936e15a2423ccb4c291e18cca0ea16224c42374cf6923c06df94fecad5711eb8b32bde35ca03653a3771acce1123aaaee0161f2a855b4b2b0ddc14aa3ac864166381526db96a54ac5c3705b6f51128072a636eacaa67a3ba88b8f38ef088e551638b338052df2585d59ea93de0c22c0966e25d91a9f6967f5faee24db85da45c8d57b4ad9f48f1ba8f1c8db68b59a04f093822a5369d9eaeeb966141ab5ae0e65a2b151174755d6a9b86d4186517549c41868aaa7701d942ca090e6734a455ea522d8da56ddcaa85d22ed9963930c15b6ea254cf08bb3384445de53f12c5d8f7656341f3e8b35c39c2d2d2b73cb2117d875f8ad969bb4528395b6c55b68f5469c1ef2f9c65e7447492b1d1b681c6cb52ab6d7663e20169dd86168bb5e56c554a609665ea653c6ecc59556697b404eb76dca4696f66d5995f4186b678b3e6f80598c438a25a294441bf12a7f6d6b02c4b61b4b23aaed011324d895c5c4a57a50ae88dac36598b512a13936239473126a4ab8a961e4462e6f724a93434d357540ad97416b3475f540c01cbae46315c26ed112d486a83f68aa9c6a16bc245c24aa9f56e9059cb5118119b85f4550e74bc08488adcaa0266a7a86e5074fda0ba58735a36a836a789d7b2ade60f868968487750b94635317e2fcd6decc2353f5b2b09cc8dd712542644556ebb171acc4a11eda025ca6ae8cc52b9a7baecb4556d9616b81e8af2f545b6f3112baf46f4f3744a65ccadf0ddc4b2ad86a33f527b10ae1956cb31732dd5c77c1a48474888da22a56154a0d436fdd47c61eef64791a68a68a62d6cad593ed34d913e437115c4af348a862305da514c52da17314f339f6574ba62da5ce5c365c32a18eac918d27afc92b67a902db1a6d22d5cc83a8d3dab6d14bda2af610daa9ceed2f6973aaa9ccd339e7a95dba8699b040c8dbb00126a3446c890b1216b4f0a44e5706d22b954aa559bae4c02a410ad3f9c5a70b3e652b449d685f1b4472ac78aae58da9681b294e997444c72b7cc4ba270bb22920766b0f35cbf8ae13154b65b9b0d6dd3e4b6f19fc56c47b2829465cb907b27d58eab8b9b8549ccd71a6328e670955d461b2895cc845c772b434dc5346da56be7758f608e9595709c11e1e2501d21ed061893625a75129493ae5c259ade658bf4a15470de211ead9e6e273fa540969df48d73a5b5cec13adc563c5dec6c170d06e4feca3ea35622badf6947427bb4a25c9d1d23ed1264e6567f75a902c2ca76154488543994240d366f0a347aad176636b09b2115b3ecf55c9c6c4897cbb4e99b5c12fc7796f3d1ccce23239b853b0b982f993accc4d82bc5427c5c1c3bbbc809265bf36d88a68656dc471cf5542cbd705a70bbcb4981d0b65639e05c83a2c271ae2cfa791908759af1a80ad6c4a10129e7266d648b94543485505d66e51b54a95cc10f0ab4742f95c0386c563993b29bc4dea0aa6559d27df70b86ed4952ed8a1e2fa2189670b86d5a50035a06cb093992690badd52b6898175bc3687565537b33b32dd36409d2f3ce0a8d9180b6e0dd98b84535b71b497324ddd9adf6562f1fa16e60e6f5ea5761e03c42492231bf66741d3d556a72b373c59b89494955565331532170bbca529f572546fc308175bf657b09b2d569f59212d48daed64b0f292ce58a9e1e624737b4adea2e1d229ec1ea61a59ef21d153714e1eeafa5c8c1aa9461d74cb497794d536dd4f9651d2da8194da5bf8444549b13cd96625b518b53548cad36bfcd7209787eb682413067b9dff0a64e88c3e57ba586cf2f1129a97da696946c58946c5b11cb97ed2a6cdcd917128c726735a84181407c564aa8e2ec464397316db7eea0ba58ae38fbe2239b995722d888e656b9aa36239884a32bd4bc31b8964714a2643390e3f05d5f872b1d5544d7807b5cf53d7d5424916653d213c4d3824bb41a2b8798472a951d9d709e1bb8785438a06c9286b5a77ecad6a2711c4e2e736e01eaacedd78c9b1b8885439ed016388891166d29157a73f6e552bd12ec73eecce3be386d8e9bb512e9a0535352991d6d06de6b8a526172d6d75dc4eaedfcafbad736600bc1849fe21ca29f006874b629baecc8b7979546cb4ddcb91d4d43a79b39efb740bbad1d047494fcb60e9bf5253d5ba68ccb223eeaa847625868af7c8447955bdaa88b0c5c5eaaa56d355afe2bae5adc06a252392c7596238c5ad85bce7b6e3a5f6bfee80aacbb045685b68a69ca5b44368da84721950f2f36425a95fc983c527888b95828f8aab63b343acdec1047b3238d723818cd6b623da25352d30243992ca023c2a14785471499c6eae9fc553cb4e627004155aac010e91b89372471e2caaced360e6a551dbea888750d7ac4aceb716652c05ce1b6de6551e1d81ffa8cc2369b5cdc9ec3aa54f6d15bd5b59bb4a1a6661f73e1100c38202a1ab15c21cadae6157894f52f2e7b8fa0d005da70ec0e9286311c4c1ea7527cc9530fc0b89c2f690c276aa9b558322cc4a6827c6dd4a15cdef756b60340889f7ee55b9e708494ae2dc84c1c470479895bd0d7e4367eca0d5d3990783756dd869e2699274b28abb6cecd13ed93a5a4b4a8a93d9712966c4b2b7a8bb4a765de16c45b6f288e55adc1e132b8cc36e83f75cef8dab991c2da5dcee4f4f4522d3629a99944db4fa2c5d57e7334ae6ec631cdb5939479fc06cae253544ab9603cf9756d88e5ed2a94d37715ab9b595021971605352d33642075275f4567472965cff48b0f52a266ea84fbe4598ae2cab43d9da61e0893a3863ca81e8b7671a11c770711ce1bb48a94db09e2112112b544af7b2a0fb33068373f856d87b0d01f6d71d7a0fca0f6b6b6d312ce0b799c21cabe6bae38e38f3844596e2fc7d4b639b6f11b2e25877482e38dbdd9591c63086d3d8c7f12b75c3bc4cfc42fcdb0ec024990b4371662e1489387c2ba398bcd8972a124b48915c449c07311ccda456782d922e65f22cb6e64d3cedb944bbc85767c448847521e64f2a32115d4fd26a42db836eae65ba6cad72f96b6ee1d4be65a7c48dc111b888b488e622f547c6b63d86a7cc8b6373331ddc3211f7a0aef037b44de3200dee4d87d56578ae17be98f29a4b8e800049fa2d1189821cd7271e9cc51b48b2ae4a483a4de9112e5221121ef09461151e54e990cd8770feacb16def61f8c56d995948f759b236fd350b973f08c4e061262932db5d0d93550a336599637d2780b4e2db88c8b5090f786d58d74cec5b9943c7a473e9ac0ab3e12bb6b46616b2add2678ad564a5d5ed1d4b38a3cd91651b8bbaa586688784bd95ce4aed0d2b418574b994e6cf554ae597ca4eab7ecf4d88b7724129d016db459c126f3297f0db5b21159c6c554712eccad8c4c2e8583459a99a4ae37c5130656b9a122913763c5771293aaece8bad939cdcc88a05006ec777d5147d72688472fb2a3e2740cac9bc26ddd5e611c4270fa4b16dd60bb59b32e0b858687d98d869b7de12772b2de6222e25a90bc24e676ee454ece93822d36368f65468f85c3256b9cef0ee507f1d73a178636ce768df5549da1a7e9001ca3944478959b613639d16f1e67ab6f50b7c44afbb1bb26d3622e18e239dae1535b4d2644c908a4635c60e119a4a3b651a177ec14fe1be107168a9af24b89cc1bdafdfcd5419ab093820de511577a4cd37688ac52a8d3b2cf11291a4ed59089115c2b9c38926e574d6b00166adabc2850952a80acfe93b5036dc44886aa24fdc439847893f4f99d235addee98aacad89c5fb0053bb4f3e22d912a5bd5c26997087ce17baa7aa0189a95676929442c910aead50e14f42413e2b2e2186520abc503ff0096e4dbd1519c9dcce38599c22cc4abd599f74b8894ec1b11ef2067e5ee5ce48baec8028994a810a3a52a04257269b901224dd5045b1b5381a46a9b7d8e856e5d1bd66e60888b48aac6d3ed1623e43765b944f477365e0ce765579ec47261cef27e36991f7714b89ad8d966853139555013b562bb525cfcab96a818cb384e5ab454d0416b9215456d4ccdd005ad6cf45d9994b474aabd49a7659c2bae57ce8eea4c4a4b5aef2e9517b5f539670ae221cdc2aaaaa879af2e0401d3cd2e3aee53432c4bbadb61f154a66a2ebaf36d36244e38568dab68a1ec934c3038a373c437176554361ea5232858e5864e70f655bc36c9a74ae2214fe19470c6f2e90827a2a7e20acab7c61b08207541d47676586e211b9ce1152bb17b3cd4b0ddf08e6a2e5bb9506f54db70b2a9fa6e2b83d5364e5ba884728f7968a6a681ade66834dc9b00b1f4953592bb94ecdb8200049242f8ba6e489a7de6330b92ef392c5772b4e1090fb4248ca5b42e4dcb8e6b7107b577abcaa5fa59630ab9546f2dbe18fbed90f2cc913e3eb409c2824ec7cb5d3ad8e51b6d1cba6de2cdcd72e7351604d8aedb4a1d719858ef62be909697eac6df931fb29b71be1520c37947ba229898695590afd9a21d804636f888913842223c44a2aab3adb03885945655b45b4f3738e136d6313776516c709bf59cf297d089a129eed169755dba6d81226ee70bb25d58f688951eb3b6aebe599cbbbb946dff005240486c3cdbe222e138245a8748fe3e953f25d15e5b9d9c2b8b987ef70927435462e2a05cdb775bd2456f11096aeedca4681d28ba368f58e7ad987d52d5f4a4ed1743ef88dcc4f5dd9704487d52599ed3ec8d4a4facc3c611b7ae67ed65f1fd29f6809b713beebe9ed97e93251db45d730dce5212d5f8f4abcca5698704485ed4be1292da2996cad704bbc5e72dec917c4a6a8bb67362f3773cf0e6cbc225cb985139a46c8858eebedb8ce8f32705f1fea5896c8f4824e8e1bba8473169cbdef212bad27688486ebad1bb3777b4982f4ff234babc3731bcb797aa9f83b9b9940cbce62db65d6fbbed23e330921c534e8516e3abadbea31b99bb565ef24bd3a23a7523cc8f95a299c443bce2848d75b112cc370a80abeddcb343713c25dd4e66ba2111055c4deb756542bcef17b2b21a974bec0910b6245dab74fe3e655b9be97dd70885bcb77170f77fee8c350b80b6d9e706dfbaa20de58bb3d21b84576275989e6fe0fbbd9577a56d74b3e2ddae5ae16a12b7572fc777cc999223ba7e39005760ccb20e9be8e4755a7b6d8dc530ce6ed75a23ed7ccb58a3ccdc4236a1424db7f68dc7dd6f2d26465884b871e671ad1cddd47454ee9670c6ee744d62750d8699d23b61afc94aeced0c652992328642432f2ad8dc3f084444f97bce6f4d3ee66b5b1b47b299ad57f11e2fb23f750edc488b11c2c36c78788975fa7a66d2c4d74b61668d4fa2f3d56cb256c8f6d3824bdc49b799bfc958659ab86d541dbcd9970b30a977b694c8ad6c6d6c7de489eae5c36f12cce2788d34c32dfe2b5580e05574c73bf4f2594ffe1e9b75c161bcc45eead7a85b24d53298571624c10e625194679b12bb28973299a94f0bace189655590fb2b4dc1375a778aabd881658257a66d7dcef27a46a0afd57d8817f336a1ff00f041364ae9d5f4ce6d895061a6a86bfc902d5549b1b95f7676bb8720e3975ce1092a2d4a8ae5b6889299a7318728425aad549505af3766eaf00b36ce5409999227dc222b888925d224d1657caee65240e0da99e43cf44c078286968129966eb50b2c28f8c32a6dd196ee9f6d8ecac3b373e422adbb2a4e99387a47989573a32a3785bd7179b1d5da5a4cfc5b6f200da3a56cf87ea41a774606bf65cdf8be85bcf6ca561fd274d98be443ed2a9b35a11157be975a6c7b4e170f2ac42a91312b4732a3c4630d9880b4783bdcea66923d159ea5b4570db72aad42a99ae5191c52e12b9154dd9899992cc2422a16cad0eaac343ae3aee5e15a66c145b6caf3555a0500581b7894b91e1e956d438d4d07841d152e23834553190058ad1e728c33c5770a061d1ccb625cf95adfc9dda907b23b44203ab32b119b8e8e26ab95eb30d82b9dce76dd96325c6aab0867b3c62eedee55e364196cf0e5a519116dbcb947ed217a5292706d61bd4ae1d135345896274b510a0eb91175e2321eea834d143156931b748fea55d5457d53f0c027778a5fa0eca93230f066040b57126633d689112f6d2b9692add5a6ad649696a222f81ceeae0b9e525488eb98d3b02ab9b413e4eb8e15ca9d353d6916644bf51cce28198909c74ae6a5661c12d242d917ee5cae4195c41eebd0109ccc04764b9baaf69463f39948948486c64f3faad6735b6b975dec8c14abdd174db994661bef5bf88fec441c3ba70c6eeca97b3ae0bb3addd986e5f506cfb5892ed8f9b6c47878962fb3bd15cccb4cb66e4d4bdb77eb04bd9b16dd244d8b220dbcc95a3a45c122cbd918ad6603531460873c03d2e42e79c5d4151505b918481bd814f54a745a6ed0caa164e3884449ada01747313656f096a1f7509459e1112bb52dd411b4c799841f31aae652d24ae7da4696dba1165273b576e51970b5108e515836d1d5dd999971d7488b3756df08ad2f695dc4bb95655b691c01222f5456538a291c035c07aadef03cad88b98e3af4085199b8b3177bfa51ecb9ecaad519d111c470b3169146cc4fe5cab1002e9b753247726d988ddda41493dd5dd992da76d1cb98891108ef746ccceb6d5b715ce1695aff0045f50216448873169ecac324e8e6ecdb63a8aed3cabe81d9ea6e03023c56e657f80e1ada8973c82e02c8f176312d1419223673ba8ecaf72b3c2e8db7285da4a1916614c516605a2cc4af32b32dbed7aab606f4aefd31a2e794b20af1798ddde7a9546a24d908e1912e5666cb2b41a8945d61fc39b21ed297a7342457fbcac3281e33d7550aa73169676d3e08aa6d381a1b8f338933d3a99a84fa8a379132273ce672a89a70c1918a404b0db273e10bdd543a936e1939c572b4c5d224b90951d4439541c4e959cb2f71dbfcb05a7e11c46564e2160d1fb9e83b92b19abc8b82f2919288b43cce297e9126db172d6c556e48ee1b960310ad91ff00a64160fa95d92929a2612e69cc7bf4534d449cd4595104fb4da8076a187de509509e71c2cba5545acac06ab4096a9b65a548b1384b37a5625cadb28f5a294c7969bb526489af195c2e15a5aa8dd97894cd23679d73ac70ad1548a44d5af092d4a5674b045740c07189648f95d7bae55c5182c148fe681ef21a7259b6ed111b8b95719d9c17085d99e1d2dff323245bb739667097276715aba918f75ed73d49d4aceb319aa64797390d02c1a340027e62a0d3036b6d8a8a62a444e691b789454ecd5c9fa769b94e8e8d8c6dedaaa492bea2577bc6ddaff756ca64f81908e1dc23ef2d0a8b1b5bbb28e5cab1b94a80b45a558e9db4a4e10b7c2b3b8fb39515c0dd6eb8265754546579db552bb5d50cc80a1d4bac1436d5c6e1b942505feb87bcb33051b5ccbaea72546536527b7b3844e0b63a4752a7467ee715f6bd4bc5272d59ccf48136fdbda5a4e133090ed7c67e8b05fc40a79ded6dc7819f53dd58db8dcda809d9b1172d4ced16d0c259bb0733a5a479555e9b344e15e659896ee9e91c5a5e76e8b9bb688ba3cc7657fa74ea9709ab952e46614eca4089439e000dd4566707285302eaa26d6c3accaaef2d285c4a0eb122244b15c512c6d8402e1bae8fc0d4351ce73cb0816dcaa3b72c6680ab53968032ed88a1266444973de7b5758e415963b4e215d6d971688f5107950474811e14e3646f74874255620042399314732c712ed29ba949a668f4d2c71cbc4a5d3b43a468f350aa8ba38dce1d02d424da75d6448ae11e54fb72a8f950b5911eca05f72d25d56898238c3582cb81e37512d44e5d29bdb64e41bb53adc532d3c9db9492e3d555b221b8444bea557dac98eb87bcac606ab1599127e65b6f98b327a9c0cd73d94d84eccf35a76c7d4b0e4aee51545acd649d70888b894b6d24f8cb4a3728d72e65409c7947a3a505ce92db9d3d14dc566e716c4d3a01afaaba53e3736a81b77456f33859895b29d50062589d74ad1fb4aaf3d52f0b1232ca3c22a1e3348e7d3bdd6d1aaff84a26b2a5a4acfe32845945474dc30070c73112d328bb3e4e66d224568915d9888adb46d84624bb50a73127d6949b8f399bac72d11ece1b45e21faf7c7e8f1ae592ccc6aec5ecae76cb3ca06c93ee162bf732d9661e27087b23bf2fd25fb22aff004897a6b02d8b926cb9fac98227c8bd5dc2d8a867e7665d2b5a9516eee2c4b8adeef8ff001f4a902a6ba2c9396b7769d5987bcdf8eef9d57be791e77b053e2a48d83517573967a9f28224d4ab6c939a499ea84bbd830cda929adb411b8485b1f55c22f65cd3f4acce6182cb885876e9c1708aeff385a999c8bb973620f6846e1f6a3bc910049bdd3995ad160b5c736e1a1d5d60ddaad687bd6db0289717960bd29b7723708b968f7845d2f7990c2de5f1ef87d2b167ea585a86dcbc424225ff002e1186a4db9b48db8d97577108f0db772dbe4ff34e6549242fa2e5769a4dd111626b5696cadb8b56ac608890fcd084142ed3d2e4e6470e6e55b986c8b2932e780cc735cd0e87c7e35f3b4aed18dd68b2e10dd99bb885cee8978e0ad14cdab75ab4ada83239449b9897c797b6eb7296fcb9bc5be1082739d234101c40ec0a8c696071cce6827bd85fe7bad6691b1b4b16ed60459e1b4add5c2245be39bbdbb7fa209133b10c3644243697290da4ab4cd75a75b1745e6c489b1c6b7149bcdcc447185d0f8a1bf77a628ba76d64e4a161936354932f36d891138d8fea8b75df57922ac687161178656078efb11f95458af0fbe7f1d34862776dc1fdc28eda7d8a1b728fb2aa53d2ee4a376dab74a5d4a5279bc4962ef4bb9e71b2e5ed288ab6cdb7325a7bc2ad1d4f4d5a33539d7a83a10a8d9535987786ac5c7470d41f8aabf475793372bac84c1620dc9fa7c834c362d88da8a6e5448ae5b9a268829db191b05caf14bd5563a50772aeb4972e6c5416d9d445bca3a949d28c1a6ee22d22b36db0aa93af11708e94cd1d3e7989e814ec464c94e1a0ea7447d35e1253bb2b2d73f7170aa150e7732ba6c7cfdee108e6b7526f899ef828de59d45be0a6f07e1ec96b199c5f21bfc56b74c8e546b9015094d9a111b5487842e371ecbba3b751d53d9969fd42ab953e8fc6dca23d9157707d29c712c84012b3c90e8f3e50b2ab60d21a619b1b1528d9a6a7e395144e31b838213304ac2c775598570f0def5926b930d94a1116ab52b6d8735cabd557ee972eeae995679f8635fd5725c22214f8d3e23b2ce5e9c1c72ef2f4cb82a24258b1c8bb4a49d94259489b1b4ea574d7e770b80817e6ad50b3d3372909e94251d2b284e39cd6fda56f1c513c68a9e692569d55f766279b9692cda9ce1563d8ad93766449f2126db2e6e248e89f633c25ec599bb0dbd2df3779683b6fb4cdca3780c5b708db974b628aa6863886694dbc87f9ba851e312c8ee5533739fea3b059f6d749b4d64e25459a745bd3ed23ebf502222b8ae22255cac3b945b1d45a967a69f33bc1a0e81692288868e61b9ea5391aa115d6915a2a1dd9a71c7148610b6d88a725a4f89325ee3b94f08c0d908fcc10da23a894c52e6486dcca2659b1278914e8f58883c8d902c07757fd9ea8dce36d8e62708447bc4568fbcb666f6d255b9b6e8a044dbad80b60e6969e7047ac1bbe52369461bd60dd1f37754e9edf094d305ecba25f756bb4ea3b4fcdcdba6d8dcd3a4e365c4243a73737a53189574cf6362274bdfe4159e078552e79257b750d1623a127eab36fca476246e1a8303d6697397d6fa167dd18325e16de5b86e15f4ad5a18f28f34eda4442425f74bdd158774634c26aa730d966c170adb72e650a17dd842b3aa848735c77dbd56d2cc4444536f9652ca9029450e5482e4eb5b654dae344fdcd939863769b78796e52349a3b786225777ae1e1d3a54d153eecc5ecaeb8cda39748a00a27271a9a6c04b4da3c45c23eb28b8ed462113728cb9385c5823d58ff008a5e254bda7aa36244736e0b726ce61648b34c1713a5ccdfa202a2a9db5159aa10b14697f03951d534f0e10888ea71b68750dbe852230e794d4ae8e31772d3a61eaa6191153470fb534d0f744bb51f8940d627a6daf3b4998b78b049a7fda11582cd46a53635275dac38dcbc8963b62e38e8f8610be2c61cb0b708c05e8663cde4118a958cb54e59aa93b2bb4d2b385224c17e8ef3efb35229916c8c69ef381b8c9a12181896edd6c54cf66b85587128c3ac15cea2d52271cb5dfd1dee16e61b2962bbb25e4ff350d39b002399a70add59ad21ef0ffd958aa8e551a966ddaa48b35291986da26e625dbccddc3a5f6cbc62501f4c133b32d37aa9ef138ceaf0370ae79be6c0bbc76f65417b4b15a40f6ca2e15625e5266508b2e20fe32ad0f6136a087238cddcd89a8b9447e846495345d21d5696acb987d55223b3e3cb690f2e54c38952da1a342af145a84cba37032223da2b7bbd5f329d6e0edb9847d52509b1ac65b6e2caacaeca95be7106dca8d238075955ea73f69768bd91fc7c6b3fda4dab2689cb486e1e1bbddef2b4ed6b84d895bdd593d6e9a4eb8445abd91149eb652b4b283da4db2371b2b1c7336ab72f7adfe2b3ca8575c732e6ef0893a4b4999a134d8f9b71e70b4b623f68bc8230f4c62a19e927182b9f98a5d35b11bae22c773bb68ea52e2dec02873c648b93654f625a6df1b5b65e7335c394847bd6fee564a3747d577484b0f0c4b511166ff94a629bb5b4a606e2af4c38e7fe9e46d6f9ad227b77ecf4ab1523a419331b86b82d966b467256d12b799d6fc5747e24fe57f6501a2227de424af459362238ef323cd68f5843c3a78945543a36991b8987bac1cdd6090b8243c436f8aef47acb4992daa742dc76db799706ef0a93217db11e621f28ab5c861ba3a45c12cdfd595345ea532368559e892b06e5adccdc530c8e190db68f7aee228f955df685db66679b80e5724e5a6c6d12b89c605c1b7b4311ba1bbe88a6e569cd89364db6236f10e5f6b98be75335f9bc306c72dc4dbf7110e965b6887da2336e10f42730d9cc556d7b7b8fbedf14d62d4cca8a37c6ed9cd77c0dae0fd152e96c8b0de3bb99e2d23c23ff00d20eab562164887338e6948ac4d5a3717aa3f67f6a6a5e02222e3bab508f6bfecadf1bc565aa98dce8361d00592c13098a8a101a35ea7a92a22626dc6ad6fce4c17b2ddc856e0599bbae70bce172f65174a8e238f3fdab4493d222db4cb845a8aecdcc44a8af757bb28039e705cc2153c64e36d8e6d4a365a9dd613fcdc4acccb224c891204a09740ac9363ccac928f36eea54f64045cb784958591b6d4a6485a6e9b7b03829d99a3364d95a2b3eda9a61b4db96eae6e55a5d31eb47320769a5b1192e55aec2e58aa48691aac8e26da8a625ed3e1eb7e8be639fb85c24b947d5bab1b38444e5a2abd2d4eb5c215675713698d9c9187caeaa199bb2324df24baa4e5ada9691a415ba4bd94256a9776559d96a58f75ada2d2454ee6355e3a27a890b368ab6d4266db9ce5549d82c3686d1d4a53692a56b2e2d2f0fb0f2e4900d3a2c371848de74719dfaacd769a7c9f9973890454c6add39906cbb74c1176918fbeb3950e2e909f35a4a5686c4d03b04ba5d2d812b8854abaf36239444540b6fe64e3cf2653f74694c21e79dcaa2dc9b414e542eca8ac8d1b469d2c711bb2dcb6b9298c361b258e6c4ecace4cbe242d9618e6225a054e6f0faa12f36b77c2ede74445d73ee2ba5224e65ba2dcf61eab88c5b7254f42db889679d1cd6c5b1eb08444788890bd23f4b328c756d7585cdc2abaa9cca3aa787e80ebfe05610533ebe919905c816f2f894eed23a4e3d680912abed1ccb0c75732e66cbd5b36ba5697316f808fd118acd3693a45997fe130db2d43fcb6c211faa2a933fb4245a6ef5bf97c899abe2791f1f2e06e51b5cea7e5d1161fc0d0c7373ea9d98dee1a341f13d568df9ee51b22c3659d5e71cb9f2f674fd3bbf6a51f484223693c443cba5bf547c7fb9649335170edcc44b90952bb508f3715ab2ae8f31bb8eab7cc90306560d02d3a1d210fc05adf759fbd7e6fd88c93e928847ac7262decb8239bf66f1fa20b2ac2b73115c91122e11fba8b94d4b350eeab5b3e965bbad21bbb5fa4bbc25aad75b8970a94a4f4b52c45d7cbb8e09165cd6db6e921128c6ef8f3463b962119132cc9054f7785b22ee8ddf652b96d48e73bb2fa4836ce4dd1b65a71c6cb48b2f39691172dae462d88fd108422847abd73842e8cb95b6f58d8bb2c45cc23e22077bf0878d6094c816926db734ea98163ed1c21fb61157ad939d31b5b7599872572e9c29e6c7295a3d48460251f55391544b03b346f20f91b24be186719646023cc5d6a8cb12cfe56deb5cb6e165cb6e2fee88a3b9dfa211dff341677d24ecd3ae0dc0d939da112cbde1f28fd68b99939622f38f3236e288b8ddcdb7eb0c610687bbe2822e93b513d2c56bad8ce4b8fc232424f36d731096f3b7e7286e56e388ea64672e7b483d003f3545270a52364e6c178ddbe84907d41589394c996dcd25dee115260c95a23c4b6e746467b30da3c45688b459b99afdf0f12ab3b421f09c36c6ee51155ae2c79bc77f4ea15ac50c8d1692dea363e6aa12f4d74844455a29f46c06eeb6e2b752bfd1f63dcb44886d4fd4367cb4a488e5be8c3f24eb67a56def2374f3550d80a7f5c4e92d3a51d1b49567f343ad379146cb545d6cad25d1b8670f7981cf7e849d0792e73c5f34553235b11cd61a9f352b3b3fd67acae9b2357b592e6b5668f95c5729ca1ce6192beaaa60e65960e9dc29a40e09aae0994de217112b532f752223caa22ad11221245c664444478921e7331be48eb64cc4e5eabc6d911654eb523cc49c83f68a19e7c9339dc740aaf90c66aed512f1b6039530db24ef15a2856848c94a01708a4b9b61dcf9a7698bcbb3025a3cb4595f490d8e261b63de55f971e1157ddb4921bbb4a96f06195a22b9b62ccbd438aeed805c51b2e9a764125ba6f651ac5e48f970b5543c342bf6a62429ca67c046d419cd88f120cab5da4de89c054cc8495ae092d1648bab1598d3eacd8909385eaab448ed38b996e15a5e1c9e38de732c7717e1f2d4c6de58d9591e995153f34b87546add4a1a7ea231d2ba0534f0c87c2e0b93d4e1356cd1cc29a9f9c5234ea98e1aa9cf3b720189e2125a16d18919a226515d961bab8ce4da92d95371d78440557a94c9bf688ea25b0ecf519b93961e122d45c4b19c55551534023233bc9b01fb9f25aee08c3247d4978764633de3fb0444dc85ccf315aab14c92b6647bcae6dd55a164ae2caab548a8b6ecdf5624e66ee8ac1c26aad66b0fcbfcb2ea73494bab8bdb61e7fe5d3b469bcb6915c5c5720eb72025739c4a3e3336a2d99f5bd8b0e8e9e4e6462cb87c9c4553531f2aa1d9d657b414177108f52065849bca42572d8e645a26c8ced111e2545036df7c89a1eac4bce1717755a56f14c54501e6fc0752ae709c265c49c18c166f53d0049a54a5a388ee51e115290ac8b7c2879a78748e6b5454c3244e2e43897155655bc9cd91bd005d4e8386a8a91a006071ea4eeac5355e2b5575dab9116625d9c1e151755648472aa196a6498f8cdd5db636c62cd1951aed4aee245c94f2a953ccc8958a49824d385929ae254d0cd5c9c111241b2e8dd6922de80ea14574e2f153449192328d359b8b8532d3f70a68e249e8aa5f13839a9b9606c8d2d2ac4dcc21df512ccc5a8d076e5d4701c71950d0c76eb92714f0998ef345b764b134401a8b7e369253530b5863bea17320ec8eca51ef9daa3a5667aecbed23316e14d4853c8ae2d2229a7b8b5b6f82b6a18daf7663d012a36a8f5ce1112829972e318232b3316dc82d919072726c4474dd98b9455ac60471e63b0099a681d238bbcd2aa525333ce372b2cd939cdca3de47bb2ed53dbb01bf0c981b849c2eaa5c5d6cad2112737626e2f165dfbfc9bfc5144ed3eda782624a53305966db5c9c2fed1316e5226ad8efc38916e8461e38dbbf7f8d6744e89162ccce132598b108b15c1fee9af23451f24230878bf6ae6bc45c5ae9d9ecd4fa33a9ea575fe1ce1ae406cd3ef6d1bebdd4bd5eaf5476e1b8655bcbe6fab222b6d1cde52dc3e58c3c4376ef4a065a97985c75c9a9a707871309bbb84b378c87e2f169f2f97728476bb75cdca095a3f0ce75af38375d96ef108fa7c5e38fd4a1e72a6fdd6913d6f2dd9b2f645614349dd6e3301b2bdcd56665acad392f2e23770f583c56e26e8f7b7c776fbb7fa5433d5fb45b1222bade22bb9b97bdbd5506aefb775a4df68488bf86eff382782a6fb9ab28f686d1ef345e5fdc945a12799d9494c5546ebad22ed08965ed66f121a76b4d16abad1e212b5576aee3ae7c35c25a4ae2f66d50cdc9dc598bbc4294d0d4dbc925591fade6b5a7ae1fd75def5b1ddfb1114b37c9ccc4d8970b8db7987fcb717d71e25ea0519a7086c1222cbc36abbd3290db1a99b88755d75d9b8bbbfe892e704fc70b8ea5453746997c8488a5dc111112c6a7b0e9692d24e01c2dcde5df0f8fc4a425a88d4b5a4fe1ca96526dc977a6e59cef66c480f147c5014aac54c9b730c4884785bbbddb8750e6151c1b5d38d36e36e3998b48908ba23cb691437ffb9017294e6b4299065d6c45d6263c21bb6e16de261f222bb4dafc2f77d9dcb8e5405c1c39ba6b8cdd717844ae3b0f62f0baeb0e6f83bbbc9ba16c3d10dcab321b4b324242e9364d9691f0761af5489b84225bee2f2ef8a98a76d40890f58e4ada445d495cd9730935a787d21bfe94ab240562a2d466582c426dc9e6789ecc338d8f310ef89bbbbe7dfb968b46aeb532224db83896f165273984bf590f8a3bbfcd64e5b64fb6598656719b84884470c86ee21c1b708be78878d3e35f62673365e0ef5d70da259ade1bb7c604597778ed8c52e295f0bc48cdc262aa9a3a98cc520d0ff970b60372e5e6662d54cd9baf138222eb973d9b30e921e1f5be68f2fa7c6a54a71756c1ea856c01c3e3e45707e23c3ce1d525a763a83dc2b6f85dc36dcaa7b4b2f6e64b6aa0484afcd5edda2ae2084b1ea84d4365d0eeabc53386045a6e5aaf42f223804e711712c56b0643682dbba28730e43d55078bda1b879bf52ba170545ff88b8ecac4ed4f0dcb454b48cf5cb379f9febcbbca4a42acb89184b352bacc96be8b49947848bb29f75db955a995315223511492e48014c8126e79cca8484d8a06b75616d92222e145ef1b04674172a83d224f0c0ade25519ea85ac15dca9aaf5471df22bb8959ba3ad9009e7049fcb2e259b989764650b60c29ac90eb6b9f8f40b8a7b79931a32b0697b0eda752a8bb27457e6c89c6db216eef384397d556dffc322239896eb58a034dcb0b52cd8b2d88e91594d79a268b312cc5060f4f53b937ecb498ef1656517b8c197baa355f66aed288d92d93c06dc7086eef2b0cbcf7329371dc46f0c6d11577160cca791a5bb02a862e317d644e6c83522c914da87834b3986598951aacf5c445cda95aab32e22dda2a85599a11cab31c49339d516e8b6dc2b0b5b4d986e5576af1cca01f7b35ca46a13372ae4fbb9967c05a6251119cb9c52a75416d92e65578396aec088851d9005486cccd138f15ca6269eeb942d1430c91d34edc488a015efa307c7f3c537ffee9a1f6b2fde5bdc9356bb53dda6e2ff72f972853b81312eee9c179a77fe53a25f757d68dc910e25bf0ee3665771090e212815acbe53ebf657185ca1b9c13b86fd0dca86abb62db6d9766d259ad025bff00cacf39f29697788bfa55e3a56da9939192771eebf2e18b7aaebbf72a96cd46f79c746d21730884bb2437288c1671b2b694974609eead011d4a5a9d2b728a6a377acac941043aa43b46a7a34e1b74a83da292730c88728dbde2f5455f191ca879d95bb527c46a189755f2f6d26cb38ebc2e4ce33cde6d5988473691f20abbf479506a4c45a2c611ca386e0890ff00742f8f67e357fac5144aeca44a09cd9d1e21bb369fb49d88961525d9246d9c150a6f630bc2e68a9e4cb9233844f8cab8e08b8244599a21f210dde9ed268b63ddb5b967db93939512ebb05ccc4224445688c37622d09dd9b6ae22b786d1b72db6e9b6d4bfcced8e62cc597566d236fd9252cce2ca10c3a12ebeb652756da51294f0694911c31670ae71c68470846db84776a59b37d193ae963cb0cacbbda9b705c745c1739ad6e3081143f62bb8d32ecadb6568e92e5ed7ee523234b26c7b5cd7736a50e47979d54e8d91c2df02551a4881b6c66c5b29c6c7ac7191caf76be2bbe34dbad22f0ed211f6bf1cdf3a61c2d22a3916d106def752db32d5aac31d2a1286568a99bb9938c0989bde59eedb33d7088e92cca02143c46c9c22b447b377b3cc4ae1b6cd0e2090f0a8469f7074f786ed29a22c54c69bb41593bcc4dce3ce0b6e3323222e0b4444e5b38e5d945d2ba1e6e39bc43bf77892769b6229f4f9fa7cc860ce4be196698fd2d929912cc332d178adcdbf747c4b4b9d986dc2b5c956db72ef38223690f651b4716874b2d9116a1211d3d9bbc56c7d2a5412e4dc28b574e661bdbc96374567026c49da7ecebd2f2eccf30ddb238be19e16ee28bb3cd11eec6674814375a25bbd2a73a1dd82949ba74f5ecb64cf855ac938225a5aeb2df46bf89685579068aeba9f2ae11662b72b843765112f985433be18d322d34db72ec89108b2d8f5623f2997515de5538d502365551e12e0ebe65886d0d3a6e893a5e06e17839667046e29712e5747c83bfe6ddb96cbd17569c7445b297725ed11b84b4f649877cae8a8e98a53af961bba5ccae5bc25f7b7fceaf5d1cecf93022059844babbb508f2aab95e5c55d3236b4595a24a5f2dba6ef692f6a98b596c79ae122e61126dcb7dac3f654ccacaef55ae96a630196fbae7bd68fdd4fe1b664d98f404fc6da2aac5e42e8b96c36b903e1d7e8b2fa94c8bb325f26cfbc4a29c9d27c9c708ad6eec26fef120a2fdc2e0ddab57ac877ee2116c7d9e5146ebb8927aa880650029790a88916137e6dbe2e62e243d6dc2b9bbb4f08fde4d529ab5cec8fbc499a896239885a47f16a401aa5745637c87c19b52721343688f65401bbd48917aa29b919a2b91108eea4df76d7bd65378e5736aaf33317383d952719cf6918492ae2d4ee952ee189305dd598055caef59699b3d01758eb34daacb0a7b9b50d23baaec5630ea775fb2a74b4838f8b820deae22d22b92bb33292998885c78b529aac552d2c2606d1e2b55726dfccba89c3d952fe6483e0b8ad4f114d491986036b1d4f9a9108b659453952d9c326ee16d5aba26d9b17cb1dd1b84748ad22b92ac34c9385688aa2af929239b92c65cfeeaff0666252d37b4cb2903700f6ee57ccd2f47718b8ad25155e2226c856b75680bb7108f7565fb42d5ae10ad4e170462231816beeb358b56cd3ced95cebdb6ff3b959898e1b849c27d1fb4f2d6e6155339eb72ae7b89d3186a1cdf35d4f0b9f9b4cd77929ac5489a9bcaa0dda8261d9c501582326a71597a2da0f85bf88e79b1551a653dc7dc1111d4b77d96a4f80cb3636e624d48d2e160a5524777dcec16a9489661890730c4472ac0f68aa386f3c45a732bbedf6dcfe6fa7610669878728f28f32f9bb686b86e911112b4c2717928217c710f13ff98f4f41dd47c5f0d86ade399b0e83aab054f6c5c222112b5bf77fdcab93b56b888aec422e2fc7ee5086f5dab4a53476e955d2bdf33cc921249ea52e16b21608e30001d022098270b395a993932f7ad454ac3b56db9bbc8922cb6ffb8bf1f3a45ec9d00143b32a23aadbb992e2e37c23ab97992a237735a3cda7dae25c70447490895be6c4787f9be74574764d901717f2a2186c6ed425f67da24141decfdafba8968c7978798adff5dff5a328c14e14ee626f132ddc223f6bca8f969811cc2e3dde64ade1ed5d9aef4a6a5669a12fececf35c58a5eee26e40cc5a4e79bb44b96efe314928c1566956a65db5b6e61e78755b302c3ad8e511f30f44a1a7c5e4de89f056ee16df9726dccbd7372aeb1eb5cdbb87cb1df0082a893a5c3d5dbcb75deeff00aa7615f9bca45313168e92c6212f5487c68b294ace1598dda84b5b813d88de52b5e72e6cb365cb3f0841cd5e81e2f1254ee2995cfc894acc095c3392e24d36e17eb582de245f386e500c6d43a3c44f5df2dd697b5e5fafc68c97ace268726255c7351324587eb34ddb0b63e9cb1fa1158a5666f753309c75a21c56eeb6deb1bb84b37cab450b87e7ba11578d81da316a645cb5b7997ad69cca3737ca425e2f27a611f9fe68acd61b59322386e133303f284c88b823c569087da18a437521272e6089b2e21d377b3e2fae1bbe84b864742f0f1d3fcb14dd4c6da889d13b622de63cc2fa5aa35ce11141cb4c16a2b6d558d8b9f29911b84ae6dbcdcb70da3ab9a376ff00562a7a644ae5d4a82586a216bd837defb8ee179f31aa5aaa29dcc91db1d2c7423a153d2ceb6ee5b47329377a35126f16db88b3284d929427265b11e65becc0e14a5bd955d8ae212523dac84efbad2f08d38ab8a49661a0d97c9db61492967147d3e61683d2a4b890912ca241fb4b72d6d148668013baa6aea66e63955c312d1b8b35a9fa14b93844eb9ea8a7767255b71bc4734a5cdce8e91d2a10be7701f351ea0b190b6fba2261e140befdc87372e4914f362b2a491e5ea425dd4cd5ab6dcb0f339c22a3ab95319666ef842d2b3f7265c75cb88b312ce63b8b8a466567bc7e9e6ba1709f0d7b50134dee8d87753b355a1222273ac70b8537b86dc577ab1e11e2242430da1ca37389e61916c7c266cb10b536df08ae68f95cf25ce372575d644d600d68d02f4f4e61b7885d4b7c23c4e7ef41362fba3885d4b7c3dd4cd38ca72671ddf32de91e1f6531b59b4373980d691d56a24760913ae652cd688f17328769dbbac2cad8e9ed29b95a513a224e79b50db4b2a4e756de56c51028ec832ace215a2a7696eb82371128ad9ed9fb33383ab48f129c9e1b485b14ace4681106df529735523e62b548484c110a01c93b8851b02c31ca9c8eb248882d2521f4cc9059c027271c2f5958b65b61dc99b5c74b0dbe555e9270aec4b55b6855e3badb9742c278be473042743dd6071dc04c20cb08d3aad0a8b252d263680dc43c4bd58aa139a89428d42e1ca49902b8b32b76c0d91fcd7f88f73aae6d5588d43072584b01e834440c89bfadc216f954fecfc1861c116c6ded712afb9349da3bfd68f792e58f334f6ec1269e77b1cd05c4ebd4a022e5cbc7322d0dc45a54504c21e74b10ad2d2975b20a785d21e813984d10acab645dcfd135519d76732dd872e3c3f288e642d6ed6c6d141371b8ad1d2a5611e15c5712ac92ae52e79fecbd1186d14547108e316010d2b2b6e65e833991bb9725c86e55a5b6566d3751d33239ae5c9994b9bcca69c80a1e7a036a2b20a0e4a90375ca65a95114d521e14fcc3fa91a301552b902c7b454b34d961e6250fe1238f7122aa93a570a09008d4a90942b4b322a6dd1155b767ed2146ce3a4e3682507230a60493b21399ad558959b21ca8d947330a994350f8240e6a8f3c6d9585ae56b7f30a0d3f7f56838b8bb8617319e9daf5e78e29a114f58e6b516d388d72a96b36a852750c6e5ca63e36eeed9baaa9a57c9eeb77768a2ab02477708ea222d23de2fdde58aabcfed88cb36e34c6970485c7087ac707490f6463f143e8df144ed2ce95d6bb2f3043710b2de96f17986df1bbb844bc65f3c772ceea6238842375d76612d225ca445f17c7e55ce31de269aaaf0c57647f53eabb570f70d4348c0f96cf7e87c81fdd39355a275cef16ab887d9f40a6e71abb3627ab7111211be2cd770dd6e5f792224594737abfd2b236016c0dcec9e6204d5a425ef5a8f969f75f72d6db2211e2b4b0fda5da65385ccc44577290ffdd4a8c30c70dbc3cda73110fb3e4bbe7f42417b52dac2ba12b6e6cb70e6ccd8dbeaf0fd71dea366192772dc45ec8b7def8c8549bcd7310fada5495228ce3ba46e1e6d23fc536e96c9f6425fa2adca5188b291166e11d2adbb29b018ae69e1b8ae1fbbfc568db31b1c2223736cdc56e670b288f7568b43a083639465f37115c456faaa2be72558474806ea8f49d826c474970f66db788447c7f323768364babeaf30f1116ab7365f8c56ab254e11d3eee5fb487ab48890e611f784aee5ca921e5385817cd9b5342b7b43ddcc24396dbb9a1f755227245ccc25aadbb3715bf7ad5b76d3d3c9b7330961917362db7730f8a36dca8959a55c59750e9ed2951bd42918b3b759ff006a74806db4bbd9b98737d9b9589ca566b844bb5eb7f15173f2842457735dfd49e0fb951cb6ca2a55e26c8bbbeefe3d0ba0ee6cb97f9bf16a19c12fe54ce210e9b7f9b9bf8a7404c38f7570a7d4cae12cadbc25c2594bf97797ec2dd15a5d36745f6ee12cc395c1b6db4bfd3f62c4ccb365e1572d81aab9e102065e732909692cb97ba5778f7f655d601893a8ea5bfd2f21a47a9dfe0b35c5383b311a277f5c60b9a7cc0dbd0ad1921c4a84521d8aec0179f762ab5596335cb54e8ce66e630fb2b3aa9b770a9ee8f6a384598957f11c06a28481b85d0783ebb953807ae8ac951a6913feb229fa7108e552927322eb99558e124242b8acae27c365d9886ef75436261c6d14d560ae5669ca236abb52a372a8fecee76b63f249e6b06971f35e3da3ed2aa6d6ed1939d5dca559a311115da45532ba16be42b59c2580b2a6a39b2fbb1eb6ee7cd6538b31b7d1d3f2e3f79fa5fb0fca199cc423ccb64d8d7465991258fd37ce0ad3e4662e6c4574bc55b99a1bd1725a3273978dd6b9b2f3de1239953fa47a15b7129be8f5fb4519d23c7a82258164869ab72b762b73574c2b30c25fa901610e0daa46500adb9444d3d98bbca6649cead6e2427285cbf0d82ef703d0206b93d6b64b22da39e2270b9568bb40794950ebac088dcb03c4b0e49838aec5c1b519e94b4742ab07316a8c22b8888913527547c48966b2ad85d76057129269bcb9547596a7d99ce140b49085d14476a2a10cb728a71cb894a53dd12ca9246894114c0dc2bed3a7cc8bf2b2b303a4a4a59cbb97aa8417c5130f708afaeba0ca9373db3f2501d40c39245771392c5bbfcc6d8a8d503c2a453bc35f759aedad10aa3364d966b8b972a91a153db608981d32e22d0f68478beb5776e9987364abec35fa6cf7f796faa2aae216dd6beb266bda0376b04f350565a1c3baabb01cdecfaaa7a971b6d224bb6aa1bb56ab4311ca9c80dc8165e45371525aabdec2136ecb0921bf34dca42104a8452b2a2cee1b28b6e8829d0a4363c225de521134dc490d022cee28426050b34d8a90351f3c5ef243ca9118b95033d04c34d5c9f9a8e65cc5b6d51c6a54e2345352636da28d70d44c93b77b5a94b1453cd515e3555cdaa85d6aaec9eab7d9563da58dc25d955661ecd776adfe64cbf753231e153bf9a9b7387f1d943c28243e6fdefe65274976eb47ed29ab475275a6fba8ef25a5548e4cb4b8d895a867981e212578c21cd950933283d9b5193d925aeb955197a7e6d3eb2b85159c31b50a32a22a465609aba5bc68a61969667f943ccdbe063cccbbf696a7250b8565ff00944b022e48ddff000eeffee2b7c2694cf3e41d5aefb2c96335629d81eee8e1f5d161673184d9112453a72e6c9f3ca25e6c7990f5a2c57c5a1d3a8bbbcabb519a6c5b1ec95ad8ff002ff1489a1c8e2d4ec72e701ca6189ceac79897a625c8de6db2d239890d2ae8888917c18fbdff0064c4954c9d71c21d3cdd94c06d93a5ca4dd7f11eb47cdb6b92cf7585ca3725c9e1b6d917bc8075eb5b70b989164ba3cea46993375ce123e4cf13d62f64542bf0c394111d44a4a8856b771694564aba923941b855fe86ee1cb7aab3992a80bae5a39b32b33f5316dbb6e57182c1ccaa6355363b3f2a8e477927e586e27090d292e2ebe2de91b97a9731d59126367a73f4bf597567e66b5e4740b853e06bcc61dd4dcfcd7d1bb2d2cdb12cd88e911548e906ac4fb9863e6c55a29f33fa37aab3aaa9dcf177962b098c3ea1d23b521746e2090c746c899a036bdbb76433659567bb663d62bacf4d0b7a95036a9d2272e5bac3da73dd60eaa3cb1855daa337b64a873fb36fb8444d892d195ea8d20c7835c56dc5ed2ade29a58c43cc0355a4e12aa9249b944f8405f3a4becc4c91692569a0f476fbb6dc24b77a5ecc86a26d4f4ac586b9573a14d5320bb18574296b6869cda4905d52760fa3a6d8b5c7074f0a99db2069865c7ddcacb2377f2ab58551a2d2b09fca876ac445991688b375931cbd91bb8be3fd8a2ba96a6339a46dbcd4ea6c4e8e5f0c2f04f60b1bdb4da4727265c76e2d4568f28f2aacb849264bc104f35b64c3de5c6e574609c82e420ba8d21382f122e2fe5b47fa9474629c60c91109c6928b75d2b72e514c8278dee1cb715a3777797d1f5a2a4e53da4ddec9e0dba0e023ddef2560176732b7d176505db6e2cc5caaf941e88e58c8489c70bd9b530fa96b375322a27c9b2c55b87370f672fba9d0738adcbeefb4be8e7ba216f0c45a72d111bbac1121bbba3e2fdbbd43d5ba377edb9c7a5cb84711bb887fba687708a645734f4527fd31c06eb0c8bb98b4fabf8d4ba4db64df6ade6f7bfecb49abf466db0d91f866239f262cda5cdf1eefdca973720db45862589cd6da5eae5521b283b28725339a7550e32e2239487108bd51f5bc8bad85a595cd3c5c2a63f34161dde0ee5a5e6cb4fb23e5fae2a6a85b14eb9a84447b43a7d5e22fa1074cd1ba11d1bddd1575d022e1ec890f1296d9dd9d75c7db6c86dc421f38256f3662dda62b4ad9cd8d16f537abb3f8b55a6b9482946d99e6c73362528e66d3e12395cb7c85a483747e510a4944f50c847f3902fea955f4c69a95f39fe4697586fa048a136db0c8b40387688dd6f115b98b327a6df5154d9cbb8b312e5427385765829444031a2c00b2f3ee245d331cf79bb9e49b9df557fe8bdc1f0912ed2d87689fb99f557cf5b0955c37873712dc1a98c7646de5592c7585954d7bb65aee1303d81f1377596749511c1258bb0df58b6de906409d72de11595d718169ee55b3c2251c9b0ebaacee20d2c91cd28f9699216edb93ad928965f12d28b69f535cd1b859b9a375f5523bd2da211cdca8183e9a9b99ca4989010d250a3803a66876d70a9fb6952237ad41539c168710b521aa8573c44a16ab3456da2b8ee292ba6a8713dd7a270e8db0c0d6b4740a6e4aaa4fcc5ada92da47f4b644a23641b1699274b528f75c71d7f11c2caab6daa9b7562999d169916dbd44807e445a6c4cb5128fc4b9e1eca4ed654b33628590255ce41eb9911e6449480db6dbde507b3931d5892959b9eeac8475122468560ae78adcd6e945b54bb4ae2d4486d9e705ab9c3f5454804f7c21716914564774a7a5ad14cb12f72ed427b2a729eee5cc88842e9c9797b536f40874a289d43981120d7169b844f6b5c329527449c2d2ac907d54a9f0b494cc0d752e1caaf688353b2e2fc6787b69a7ced1ba3dc9844d0deebdbef2832711bb3ee75edf79686465987d163a104bdbea104d2f3c56a75a820a6cf32ccf17cee653641d4eab79c054cc7d4ba4235034f25212101448c38890522e5a29d9998b457243baed03648999c43cbcc95ca2e6e6f3244276dca92e1a230eb1562398ed21a7e72d6cb32005c225015f9f22705b14db45ca5b9f60ad346772dc94e4ddd72065a3872ea3a5e6eeb91590cd651350982f09532f43289285887e9172989d7c6db453aee89a6f54d422244a4251fbb2aaf39316a55367735a88b100fb144cec2d714849c74a0ea23a548cbb76b62943a231bab1b799b1b547bf021d4a4367a604ad12569768edb82baef0d624d34c1a7a2e3fc6f404d4e71d567ce3a9b1779b2ab3557676dd2ab73f2c41c244577674fadba1f56f82d4baa232c275f80b91f058ea6a7773036c2fe66c3d2ea0aad2d364e3842e36cb858ad322d8dcf5a38aeda2e14445ab8b51c61a5b0ddba30845661586f0dc268b290910b856dc445715d7179750ad32b1507da26f024de79c12122b449a1ec8dc3be16fc708f8b36f542ad32e13ee1392632ae11111365715b75c5f1e95c6710686bed726c4f4206fbaef787b8b983402e076276dbe0a23f377c2635c3ca23fcc9f94952badbaeef6a5292f4970ad2226fd5fe553d2526d8dbd5b7773115beef94be954af915cc71df408292a7136377599b887490fad0de9d7e5c8b2e6122e2e61fd9fe9caad7294f75cd3d67b5f694e52b645d74b30dce72895c23da748bc42a33a600ab08a94954fa06ce119088f585dad223ccb63d84d89d244c939de216c6eec89477db0f994f6c4ec3342373b0278b2dc2395912ef0ea57fa7cab4d8e46d80eef585fc13249727c96c42c3751b4fa1b6d88f56c8ffd422ef78bfc9480316f37aa0228a79d808ea897fd31f7509e143ccd9775ccdef23b240739c9c843f16da989a66e14f8bab8648ac942f7543daba48b825766bb886dcbfb966b5591211b7e11b2e5cdd9bbb3f3fa3eb5be4c4a0ba3692a06d76cab998dab886ecc23aade2b7d25f425b5d644f6e6d96360c5c5790db69758377ab6fbc82aa48625a42236f36a2cda4495adc931b9e12cb779c1d2577754403768dc59ad2b4bb5da2fa3caa434dd44735679519071b2b474fe3f1e350f3ed90e6f6bfa55fea2dda4443cc597f1f1aac4ccadc398729661fe52e55298fd143918a0a5cb4f7bdd563d9d99217b107290966bb4dba84bea51612975c236e5cdece644c8961b8dddcdf6737f3276fa82a3dae085b132f5cb8e3883a31dccb65d9fb39514e02ee94b207c2d70ea01f985e6dad844750f61e8e23ea9b7fc6291b3b24fbf31630245cc5c23de529b35457275f161be2d45ca2b6f97d8f6a9ec0800db97ac73888945c47128a16f24eae7f456d85524f6333068ceaabb47920936fe51ce22fe54d4eed09e911245cebcdaafcfcf08e51154f4b430ff00404789e3356753291e89f1aebb7665292b511255127ae4eb7316a9735044e16ca15550e3750c7df393ea558ea2e88b6442b2d98939875d22b72dda95f25aa23a491f08010e5b50a26b68ee18ddd5cd76252d7462e6e42a1c9d01cb8559a60b01b1114610109258401c2cca4cd5064b13b2afa19b964878d55efa332221b891fd24cc7505dd513b3752168547f49b56b98b473112c6cf04925735c06975d060ab8861cf693ad8ac7a766b31778949d2ea3d592abcec4b8906e54085b2115d04419da02e7b45180f27d548d6e7eeb941ed0c2e66e4b0811da9bda46c85b11158ce2ea171735e360ba2f05cec631f17554779bccbd2b28375ee691e146cf4a136ddca0de9ccb6ac5c94ee0b70d91a3429c9a7ae222e1e151edbd9979d76e41c4925b190125cf0a581ebb4a7987ad51126f5a92ecde644222519900531333f6add3f238db212999ca43ae5a4f0f86c85da7c258f3edfacd78fe7c35f353cfab9f4182fb758939c68ad295785fef5ba84bb311ba09e8e88cc796372a3cd582119cf4d57dc55cba278a4ddae37a847de5496007c2e60874b8e11767bbdafa56a53062ff583e6dc6c5d12e617078be8b966d2b242132f00db94bb5f7b8566646164962b5f493b64874ec3e452a61bfba8d93739b8531361fca90cbb6920775263170ac726f2919777328161cd2a499753add122565d4ade2ba8660bdafc5a8a8413c2c54170b2f6e4d9274e09118a27044130ec5013c28e78d42d466c6d51deee8a640d24a889a71051757a69ee11f5bd64c35e73f19947564068a7290456a9d6b30e655fa629b6c93ec5165d545d6a045ecaa5195ae177b52bdd41abaee254aa9b369165cd75c91204f4674561a26af65595b553a19169fc17ff004ac72d1b736a4a8ca6a56ea8c82f3905e6637259c3b29e02ea35f540142d4fcb94375c90f8f7aee648661fcc9b2c4f6e1582987690acd3f2948fe93223ff00a522f69c25a3d160570fe2d5997e528f7ff91951e5931f79d3fe55aae0d8f3576bd9cb9af1f3f9749a7f537eeb137646dc470b4ea22fbaabaeb988e62b995b6eecbf644568d3125892eb3bab4a95c43da52b1da2e5d41ca870f5699a99a5c9b854489b270b2b7a44799484bbb6cb8f0e22839d74489b6874b3f6b9916fbf6b7716915486057825eea4ea952b5b11fc112f03d761b7cb98957c624658a5a47cd8a3659c16849c22cda890f6636404c2ead73536242d897b2a36b95bbbaa6b48ea25519eaa38457116ad23ca28ba0324e12934f8766d4a665acb1b377573d967f0d17333e44e128d916889c16c548d525f08ad5a7e18c343eacbfa00b3dc5b59cba1e5f579522d55b0d9b526813ffa40976954f17ac5294d72d707bcba2cf4c32b8775cc9c2d91e7a2fa7366a7312587baab757689b70897760e65c06049cca36e92d4497559fc42b973da2a5921a97e9e1bad762d590cd4acd7c5d9544a98ebefde795b1d22bd50a3b575c56a91a8d4ad142d3e41c7fac70ad6d6a192380cc4d82c455d4be5772a3173f41eaa0a628a4e95ad0dcad542a1372c226f90b8e708f08a24a641a1b406ded2ae556aa459525ee7d4787a7d52e193d8184b9d771eda7c14d55ebbc22a0dc8bae6622b45372ade18e2b998b8453453045993d144d668df9aa5afa87bec64ebb0fdca9492021e225f2ef4a357399a8cc139779c21112222ca3947569d2be8aa8d53c1a5a61f32730d965d74b0c845cd397088bc42512b6108c57ca55698c479c32f84222cc57166e622d5f4ac9f13cbe26c7f1fd82e8bfc3e87f4a49add4347dca14608b946d32c0291606d15932ba3345d3585997825f327c5c1d43cdc4b90734a2ba703536ecb0ddf7457b035172a286dcbcba8ad4f32636972e5f69364a7435092f2f766d2a6e87246e108b624445c2288a0d25c9979b6dbe2b46ee51fc797e35f4b747db0b2d4f644b0c5c78b53859bfdaa2d45408c29f474864373b2a6ec16c13f68baf8dbca2b55a5d3c5a1d39b9bf954a310215d7878445543e42e372af9913582c101539ac36c8b8446ebbb3fcab27da9da2a954089aa6ca8888dc2534e16522ff3b496ad35b3c53795c2b5be5e6ef7f0527234996951b445bcbd91fc17d29c8886ea52646dfc217cda7d12d6e64ae7e619b9cd5d6385ecf9205bbcbb93533d0cd6652e75b71972db6d11d5aadd24be8b7ebed095a368a7e5eb0d965cba53a2b1c1477500decbe6dd93a93ad3f853d2f86e1161e310f9c22ca58a45e21f9a30878aef46fdeb6890a20da39474ea1b7eeea5cdb3d9c6a70748ddaae1b44aed22570f143eea3360a41d618c275c272dd3770f647d36ff00dd2657b5fa84e44c747a7444334d1b91f3543c7929c6046e27a5ddc3e2eb47335ff50451c6d08dca1abbb72c5306e75c1bb8475112453bdd1ccc91bbb0823d46a856344d03e33b1041f422cbe7892ab936e10165212b487ed23e627b10943748138c3f527a6a5b2b33458f6e9c375ccce8fb7747d65ea7b9957a5a99cda9a764edd9cd07e636f82f3b62945c97161dda48f92b4522648484856f1d1bd4711b1125f3d52dd5aa747152b48456738868f9b0923709bc02b0d3d5869d9caf5b632d7665f3bf4a0642f08dd68afa66b4024cddd95f356d9d35f9ea8da0de5154585543e487960d8dedf0eab418853362abe638696bfc7a7c507207d58a31b5d6698e0ba2c0f58e728f0abe50f63842d2992cdcab6cea88a18c6bd34f3589a989ef95d71adf55519494373cd891232b1432625c9d7cadcb95b5a1409a6b2b6d88aceba57a915b6aa2c471291b0b9cd16d15960987b24ab6026faacaa7637384a06a03d65aa65b73320678445e1e65cb5e4b8dcaed4d16160a4261dc360454442779531b5b364222d8f128e68b0db1e64de54acca7a9e79ae51fb40c9139885a53b4731d4481ad4e93ef088e56c501ba33b2b552266d6451b293775ca022786ce64f509fca92423051509fb5ccda6e52cdcd5c4245a478554ab1762651ca2a4696e110a16401534ecc621223c26dcaa0665fc34dcad42e2456477579923ca8b71cb47b4aa72156122b6ed2a5e33a24905a940a2d87b32b0b30cb72a841fccad92077362b69c20f22422eb07c771034c1d65c76088a0b9d7b7de434c124525f117db222b46e5d1a4b6424f65caa8db77b7d512c128d9e8f589e61d434cc732ca715d13e68b30d99aaddf0455c503dd19f79e52de9cb72a8babd54b8537327738b9372c36dcb92e5d575b2ed146b7384934b9a2c6ccb8c8664ed3d9eb128b524156039a11151d47a762bd885a5727e368af48cd5a98cb61a27af73aa93ae3c22368a87948da2449a9f98270971f73ab46d6d82273ae5333ce2ecbcce5439c32e64cb51e54e5b448bea8a00480cae0ae34ff0a726050414ab8edc22a45d7bab1507251bad147cdbda44522c9c054d6cebb9968f4f98ca2b37d9b6732bd4b95a22ba2f0bc0f101738697d1732e39a860918d1bab081896a50d5fa30b828a92754a6eb856943dd11bb563e00d93754ca3ec9b43d639692a774d2db6db0263e704ad6c48b86d2221f8bc56efdfd98fc6b4b7c086e11f69537689b177100b30909097ac243eaeaf2aaf930e3570c99ac5c76bf7e8aee4c67d8eaa1732e1adb6603a8eaa0362f600a6d965f22c16dc6da749cf842bad2b5a1fdf15a8d0fa3f9211cacb84e7339fd5f1ab26c2d185ba749e92fd1d8cdea08fda564956ad25c7e663c38b5da169b2eef4d2b1cc0e6ea1c01055664f649be212b7946d1fb2ac52943001d2223ca36e6b79b994bb0d275f8226c5d529f52e26c142cdcdb4c0093a423a8b71681f54752a5d4ba4a926dcb711c7adf911b87d52ddb95836a6891992cd75ba446ee6d45fbbd651927b1b2c037136d8908da3cb6f37792b2a79805aea226ba40c511c265e6c4b3623c3abba25c3f3f8d1125519c7f3036e39c3688e137ec92b0d2291272c77db8ce0db693c575b6fc909789a1fa14fb7526b947ba8801d4a04b86cd2540539f7472bad93645a73097efdca441ee1fc0a38082375b688f2888da9a7d9ec8ffb91e51d1273eba8481243be9e8024ba904271bbaa4edc501b71bc56c6d79bcd974b83c425cdff00dacaeaacda3deb8bbb6e52fbbfe4b789e0ca5c4b24db191b49c21e12275bed0f177785298e4d4f1f55419f6ad226f94b57787ecfa7d6507390b7ab2e22211e6b94ecd3b7397096ab5a7397489097d7e4fdab951a21ba22e35ab28b997490fc265ecf8a2a4075b5504c65c6c1521f86aed0fbdca5f4fa228aa6d3a65f66e6a5e61eb6e1226d927044b2f10c397c70fad6b7d19f4420eb9e1950704a4c730cb8dd6cc3836da4e7a459872fa7e65b5b2ecd1088d2a4258d96f48baf14a0908fc80b41180e9f296e4af68ec97ec3a5dc6df2007a92be79d93b8659b1212121bae1212121cc5c25e31fad4b391f2ad3f6f687e172c53783833d2e3fa43394ae6b8b30ea21f8fcbe8f89654f9655d9f86f108eae8d9937600d70ec40b7d579e78bf08968711787ed212e691b107f0b48e85dc107aee25b55583c25bd4b01e8e1ec31b96b1b2557b8ad2254f8ed3bb9c656ff002abdc02a5821103f67280af5089b2254ca84a95cb7aaecb893375ab16da97ec7086d4fe0f5ce98653bacf715e10ca6f1f42abce37b92a5008934f3c8ba7ba2afe4710d590c3a1cf301d1313a16a269b3c93598e550edbb6a4b07319aab2a9bd2cf60aeadb82e0a0a6e16a8fa7cea9175cc415172961f2560ecb34771ba7242791efb62fea255c88da4a464a692648f5ccd4aa498db23d446d2ecddc395667b50c6010b6b7969eb86d596f49348cd88ac30caa39f2bd5a470b002e6855ba6474ab53f42c5671153e4636ad4f662685c630c942e2c07d9f30eeae38488156e1dc2a254764c9c64b2acc7692904d92faa7c04498f5567db4fb25882568ae68dae1b3974d7d1e6171baf9c9f3b5018eb41db0d9026848ad546fcd8e72a9b16478baa7a86cac7590c2fa441d4b989421e1476cf50dd9b745b6c4b327c440eca3191d7b2448cb9384be80e87f66c5896275c1cc43953fb15d18352cc89b8388e6aee92b5c80da243c2adb04a78df7901d8d87e554e3d54f8ad05b71727f65a8f47559c5a608e527a4de29621e226cae26aefa6e2843fbb43b6d6fa84c66d4d81088f0e621b4bb4b2dd8eda42a7cf917c0bdd53dd91bb2ba3da12f1fed87a56cb47684df1742d71b719bb1874ba44512bbfcd6578ab097d2d67300f049e207a5cee16a7833188aa690c64f8e2f091d481b1f45155762d516dc737655aab6c6afc5aab4e37a9659dbadcc26ed44cb38a4d9732a8697225212ce10a5b5c9c214dcb3e8d6df50b2eea7c0ff049c0fb2892420a928be87987ed14c1b90b5465426c44525f2211c172b953a8fbbf8caa04a62eb8b87854754a6c9d734eae1fbca4db952c1e6251ceaac03430265a6c4bdeb975b0b5552b7b58328db8e10dd6f08ea55ad9ae9965665dc299129170b2b64f7997397acf822fa7c48d8c2764a79202d9e9222442ad232b1ee8e9eeacd69b59e2121704b495df64855ae9d5d6c9bd56f327a3206ea14cc73b56a94a84ae4dfa79551f6819cc5fccaceed406dcc4a95b51596da171f75c116dbf688b8444788a3f121258a54571a15234876db4bda53d2ef8eae1e159dd06b58fa728966b7947b48e66a0e30e5a4570f0e6fc5a9906ca43a32568ec965f5b3226263cc2ab94dab0da3ab376b4f791f07c6dcb98b8b35ca4b4e9a288586faa20e3da48978698ff00b7fdc838be229e68aeb737abda49714f65d15a367630bd62df945cc5d5a21f9395961f749cff00e45b5ecf0e9bbfda2be7be9b66aeaf543f56e34d8ff86c323f68496e381a3bd538f669faae4ffc447fe835bddc3e9748a5c3f46540da5a7b857583995ee887732ac7b29461265c7086e70b9b856971d644c8df249d36f32b3bc3f2cee9590c7b11a9ec17cdef4a9b195cd576641cc4ee2b8d8fc18ad47a4ca05c4587eb77964ef53dc12b4564e38c3d81c16da62e8de5a51c550b8bb2de9ef263c2f291115cbcc515cb7329dd8dd8739978713cd8a4bf971b6ee28d91cb23800143d0696eccbd944896cbb2db2186de9ccac941d986a59b1111156aa4cb65b6d55b2e279bc0cd02b8830f118cced4aaaeccecf034e38eb837170aa2ed53f74c384b49da5a90b0db83de591cf3d88445ccb7dc151b9c1d2bbd16078e2468c910f550ae19628c075112dafa3dd94061a1997c711e2cc225a45671d1fd1bc267c48b4b64b6aa84c88e41d2236ad3631526e2267c5655a1a2305df04e4e4e72a83a94f5ab9373568a886ae7dcecaac8611b9d95456d49f759ef1d91548609d72e2d2a7a6e66dcbca80c71686d151350a82539a657797445006d2c66e753b94baacff08a0a486e71051737a3a931eb14dc99186caa5af35150dcdb5d4ccc4b5c39b4a15b645153cee5518130a3445c429d8bc0c6bc0b27769d9c3a74e188dc432e44d8db775836e165dd1879cb7cbe2f8d7c8b3d12271cb8ae2b8aeef5d9b4f8bf62fac3686a387213c568b9fa1cce52d25d595b7766eb57c9d350b5c2ecac5711822a1b7edfbae89c0c5a689c1a3671fb04fc9c72a3a4649d997b0986c9c22d22d8ddabba82970bad6c75169f597d93d0c6c20d1e9ccb9097172a93422e138e0ff676c86ef5770f8e3f1fd4b2f3ce226dcadfd353ba6361f15f3c0f4295e26b17c05c11b6eb4b57b3e554e9fa53f26e614db2e365ca424bef692a6be426e9541f7ad1b8b2b42c8ff8630df6fd31dea0b682892d57942c4976fc225cad2cb984b99b22f1e190f8f7a81fea07ab55a0c319d1de47cbecbe2f629e256915c3c5f8ff00ba2a12971728f2f77f8ad6b6a3a3dc312c31b4445d7c8487508e56bef47741662175a5cc397d6e24fc7387ec9b9a94c46c55b3a341117db22e121f697d214c22b4786e15f3df47f296cdcb89697087dd2b8bf6f917d23210b4472aafab3772b4a365988962089182ed975bca946d9286a51212265fb0728daa8bb53572b8844adcb9888844447b445e2156caa915b96d5916df6cf3f38dbcc37e71c11b48aeb46dd4568f88b7f937c77ee4b6f88d894e306569213f4da835324e0cb0b93d83e70a4e55f9b11ef3a3fb92e4ab22d4c6175cc97c24bcc36e34e0f6845e86fb7e8df0511d08cb4cd36bf282d49fe6d649e7467261ca83afb2e4a34d3988c109405a228b84d9095b7409b86ef4ad37a7399969a31881324f3373824db8245856e6badff21f4a9d2d344d8eed3aa830554cf9b238689ca23e24372b04bcbe5b8553b62848844b84844bdd5a44a4470b70a82d0a4d41ca555e75db8ad59ed63618aa8fdcfb842de96db1d5de2ecab56d854703ab1b7ac22cdd9e5ed21364ead739666bb8ae121bbb5992daf2dd424ba3ce2dd1605b6fb30e53275e943b8847ad65c2f8468b8bcbcd743d543d34969bf94dccb653f26d0f9c6e4c49ef59c22687bdaa3eb4167d4895cabd0dc259c61317377209f813a7d170ae2c922159264dae3e76d53f2efee2575d8fa8dae0aa1cf42d2525439cb487bcac6ae112308f25932db16c8de8bea2a73d8b2deaaa1d6e61b936dcc36c719cca24a73a3d9ebd8b7b2a2b69a4071ee2e1d22b9bd2465b3be1daeb715b35e08e722f6fba8ad94a70b0d91966987b31385a949cc3896cc32dca32a334b46d67458eac9ee4b8ee75487a6332ccfa4e2b95e8df54fdbc66e6c8937885219612d0978057b61aa0e72ca64deeb924b33e4e170a61e770c8add49837ad6cae5ce2684b1e5abb2c3307b43828c9f7f1667ba8b2693524d88dce16a242cdcef08a6084e828b7664446d143d2a1988893524cdda93ae17c18f124908eea465cb14b3165145373622568a1a5e56c6f36514c350b9ccbc28ac8eeacd3cf362cfeb0901253568f68947b879b327254f322ca8ee9ea9dc424482a781619129a9d21c3b7890f857376f0f123ba241d1b1387da56269c21b57290c088e9ee8a6ebb304d908db69122f78d91df28ba9964eeb55ce40ad64552f67e175aadc11caba0708e1edc8663bec173ae38c48e94e079929532ea09a3eb052a62286972eb056d6a5bfa2ef42b0945180f6fa8528cc1333704eb51499851712a733c0e60ea148c16a79156c79eeab33970929995a71131716a503b573587a5597a3b98c7972ecae215703a1796f62bbdd348d9403dc2acb31c322b975a9a16eeb53b5a96ba648786e41bd01b932e6dd18364f0384e26e65eb6d1e24d494c8dc49b85a4f26cb2c941ca6596b2a606dc45d9f9bc36ed151cccd088ddc49b0d29c2e08da93776514cba386dda826e7c88b3275c99b92b2909398143371b53d2cfa171335a9e0b4528849ba94198c315da5b9715ca0aa337765152db2f0b8853f0405ee0d1b9290f9836e4ec15fe8796d5341399943cb8da297025d9e868c430359d82e07c43893aaab1ef1b5ec3e0acd2b34a72426ae543666094d5366d1cd028d4753ad958aac7d592cf6a859895ecdcc46d51b699bb493945a1b27f1019ac55969fb7a525456c4445e98f087d8976c8ad1b72b9d6172c310958f602bd36f95cf88896a2111b446ee11f1c6e185cb1aa3d2df9b9865a686eeb0b5110889108dd75bd91ff0055bad2a4ca58444adc411e1cab8ef11b03311940d3527e6bd09c28ebe190df5f081f2d15e1998b8512217432aab4bd63878958687377dd0552d7056d3465a0909139154fda0a95a56892b855c795677b47264445c44912152e90022ea25e9e75c2b44847989cd223dd1f1917cca3676a4db5882ed59b649bd57130d5bca56ee28db11f1f8e2a4e93b3a736f8b0e1136c9669a212b5cc3e2112e128f937c3c9e3568e98f66e5a4e5245b959095092fd2731754d8d49c6ad917675c112226e17391f1f8888a10df0df04ba7a712024a2adc43d9886dae5caa340da522b702a923501badb5b72d7aed56fa21a455da8f59c52cd97b25c2b34d8ca23efbccbaed3e5db1f0726a6ad271c6de2bae69d96271b12ba0e5be4f1405b8f8f32d1a994f06dcb85b16f86d122b47dade9b9e3119d12e094ccccce165630cc9b7c17a5a29f3148b5c241395ca2e61bca4b34e91a48ad2706ed25eaf67b5bf2c56aee06550b5da68bad90976becff0056f481e129ed1c2cbe576a649b79c6dcd368969d56ff004ad8ba3ca78893656f56e0e9f5bf95b1542db5d96296982111bad12b6d2cd9b2e28fd176e8c3b2b48d8672e97971e216c47d54a95f748819676aaff5896c596834d160df96e1e11e22cbc5f3ab0f47b4e26a5c448ae2212d5709108e91cdd95509c95299645ac67a5fac12c464ad71bb4aeca5c251b54b52a138db76bd3273369754e908010b63a45cc3dd0badf892e37006e42153197c7cb040d7aa7e6ddb26c9a21eade12d5cdc43f5e5f6560bb4327853330d70b6f3a23ddb8adf756f15f023665df1d4db8245da1bad2fc765631d2142da9cd7f783ff00b42b7bc0931151247d08cdf22b987f136983a8a19bab1c587e5fd93fb2ef5a36abd6c9cedae2cde84e65256fd816c8deb8b4dcb6988c60b5c4ae7785bc80d3d6eb6f68ae67372ac4fa46b4660bbcb67bed67d5582f4873774c977965f8741352eb6cafb8cda0d1b2fbe8a08dd45d29dcca18dd49979cb5c5b97c799b65ce70f66499a5596b8e6555f17d2f69ea36b639943493f950a78c866aacf18803a4cc3b29a6a66d527295255c8b8bc2f237c21cab6091d1ecadae4cdc98666ed2508ccc92593a99e45b44ec93dfc415c24a710db532f8ede55ed9ca2ccbe370b642df312b43528d303d615c4abccad8dfe13723b2bba791ed66678ca0f75884cd28db2b444894cd15c742d1b485686e94b5da534c0cb5d71694fd64e6a6131b9a85162b15254090394f6cecb9392e256f0ae4ec888ea4a857db11b46db544546ab72c53385f98fbbcfc02d8557f1163899fa4dbf99509b574307474acdea9b2cd8dd68ad423171c51d53a715a570a7dfc36f8b48dc9fc338da3abff007996f358ece6cc0dd9855bfa36a1b62575b688af55a5dc145d0aad80ddb6dc48e4c22b5919b0baba662b40e901cc07aad4a49f126f0d464dca618928cd939e371ccd955b2af8642223a892304a7a9a4932ca2c0eaa0711d65155333c2f048d164154caf12b974215a71aab4bb044e133318ac61dc568910dc256792eeaf77aca2f6aa8e439941ecc4f9313b2ae86a6e61b2f786ef76e5beab8995948f65af7691f1b68b9ed1cafa4ab64834b381f85f65f5257d9d4aa136dea577aec224375c5c25717d9ff00b2a9cd06625e7d98657d97a46824cd182a33b48a60d34e07bc92d7692029775220495172d4c3505e70cb85025286a97313568aafd4a6888ad1520fb05c44bcc4a88f78936ed52d84043d229d863710dce17baa42397516a4e8438945566aed8b6e1eab78b87f1951a02ee3aaac6daec50ccdce36e60972ea12255498d891b45a9b9365cb74bcde9ee9296abed55c56b7e70adf84e6d3ddcaaab57dab71b26dbbae1bae70b85cb748fef4a053ce790354ff00e6f3932ea1b2c31f831222b7bbcbf42726f6c30f48b9771652f791144ac138df10b9988aee21fe5865ddde4d549db848f2dc22370dbc5fca9d6b4150a49b5b84b636b48873b85cd6e6caa35eba79f1277ccb256b2ddd96ef952ed47e3f42809e9a6889c26f134e61b6eb4bb5d9fa13543aae115a39aeb72fde12e6f9921da2722985f50b68a14936d36386239b52455d8b86e513b3fb4e2436e5ef76bb4acac4c36e0ea1eeea4d68a41758a83a2d4c9ab84959e5aa375bef2ac55655b2cc39485769cea30524d9daab9b4fddf8d2a624eee255ba71e9f79586546eb52b322b68adfb311b9c15f2d6dc4ee3d4e79df949c9921eee395beedabea3a03d636e1fc9b6e97b2244be62d96a13b32fe2b836b7762e6e2222b9749e042d636595c76b0fdd71bfe205e49a38c799564d9f91b586c4b539f655c2a13232d282239798945f56d90938594748a83da5a9bb365972b63c2ac318a19f11218cd1b7b9255260b8e50e164be53776c004255845c648888567b09112708b2ab3d5255d21b78547c86cc3ee961b62934dc2d2363b3a4002b5938de8e57e76b4dd372526d91662f6732beeceb42d8e51b7bda915b35b16d4b0dc6588e7ba2a666196c794513700a40eb38ba4fa055f89f195588ed4cd0c3dcea7e4bb271c4560931116c9541da88b7a50ce6d0b9c29f9787e090785a00598a4e38ac84932bcbca8ddb4a4baebc5696ae15132db04eb9c5a94fc2aa7ab2a298adb82af29237d2c22386c005575bc446b26324b7523b39b2e14f62d0cce16a710152749bd4a5a46b97652528c507c27baa1be62c7174bf353629fdaecd8b75994fce6216e44b5362d36a776a363c9accd8aa3ce4484ad2e15650491ced190e8ab66a79a99e4c835e88e98a92062f5c85225e81a9ad8c37650de5cfdd178b6a7e8b3373ca1a65f4353a7f0dcb92df15da429b86c204a1c55fabd3a2d8da3a894203ca2ea353bed4a967f7a622832b51e2e1d24a4a2768dcba42787ff004733eeb445f757cdb3639ae5f483d0bd9986f291392ef888969b89a2fc6f5f39d4a3d612c1f1536d50d3e5fbadff00017868dedff9eff31fd94f74592c2fd629adb9a4a71812eedc25f757dcdb5154c21201ca4e5adf75bd3957c09b2b52f049b97991ff00cbcc30ff00aad38245eedcbecada6a90cc948bed15d2f38cb6e8976bab221f67c6b03895c5975ac0dad7920faff9f25a3535dc36040009cb87376ae50b4baab0cd44a4f104e60e588dc11f36c41b21c364887c58b69146df40a9937a36b6c01105c024643a85bb7317ee5461911a7b8e3e2d8e999c1e6222f377116a2f4c63e95076b2b08e3ce5de7f5eca42aad364e3997b25fcabe78e90763c98a8f5636cbcc5c597e0c8ae2f546e5f4cc247730c918f58f362e17f7a437117b4b35e9082d2b873397356faa49513cb5c96e6b6469550d8594b4a5eecc42e13a25c2e31974fd04b7295774acef63da6c846d11b750f093644599b2f59685270eca4ca6e53cd686b54c4a411510433228d652436ea33cf550550972e1ccab3579673e45cb8789b25a145a141cc495df7524c56d4279938eab269bc72cb6e51d3882811a33ae1708f7456a731494d429e23a90d4277983a288d9994c3b4797da2fea56cbfabb5473622da262f5c280487f88aa66d7bd2c3332a532f0ca8cd38322334e324fb6cbee79ac4118c30848bc577a0bca85db4a5d4282f4bbee94ace48b8e61938cb64c3c3c5c671869f1c23e446ed9515b9c65c967728b84243d971b21744bda11ff3519d31ed14e3f4c109c9565bb1c6c5b71978bce8890f9b721cbe3f2f0ab5c3299b552321b789ce03e7f855789cf252b1d35fc2d69247a6cb23db5aafe70a9cd4cf0b8e5adf65a6845b1f7477fac8b9166d150f4f6b32b0b3a57a2e38db0c4d89bb30003d00b2f38e2b54e9a42f3bb8927d4a85ac36819372d2535536ee1510cb799380dc24c0f063b15b774413b70daad7b4d2fd62ceba257ed70455ff006c6a83a47d6580a8a77331225a370b52daa63b0db38ea0e8a02a93968da2ab5393a95529a2251118ad1430802e5606b6625d608827d465702f6c91518a49e95272051227163b3058fed1cae1912aa94c66b568db7d2b94ad59644485c25cdb1ba531541b6c576cc02b84f4add7508baabe56da2879766d1b8b52f371b8ae2489c76ed2a89ed5a16b8236985729160444ae250ec3f86daee3dc9bc974e67b2999d99bfba8890316c72e622502d388d9399cd68a2736c835d74fcccb9095c48d6602db7771212aafe91e22499b9c116c5b1d45a89200ba59d13b2d71091123bc2328888a19a3eac447d65334c95c4b6d1ca814b6b6e15eba33a03782e4dcce6b4728acf768e745f9f73944ad15ae49430e98e70e558531714db9de4dd330ba43df64baaf0b1a3e2b43d99695a4a19542eceb76b637297892ed384d18a6a763476b95c27886b0d555b9dd01b0f821a6208666198512fa6a50ad7054fa93fa2ef42a1d27bedf508a034dbe691024eb01710a7859466f84dd42d67675d75b272d537d1dcb14b30e092d3687200e31690f0a84ab52acbad5c538808358f6edaaef5c3473d231fe4a83332b738e12af394f71c70add22adee0e62144b52e36972a8a18dd1594ad5994e813449b957ed2b894f55292e3af915b94543d46530c937253902ea307eabd3934449a8472a61c3e55e032151f9764bce94f15a85199cc92fb97244013fc94d733546b314f19215a4b38a472754bcfa2510ab8ec3c8712ae50e449f704474f112d3a4a50586c4456ab86f0b7493735c341b7aacb713e2cda6a62c07c4fd138515edc90314ec17485c55eeb9bae420a4256282822da4dc9b27e93de5352132a1769dbbb3225835cabe66d311f85f75712b73c6a2ba3fac37293ede2f997885b22f932bb2b9ed78a2b50e932a4e302db60438cf5a2d91691bb53a5d980dc4b01ab3837eeb969bb313a7529216cb34d535bbae2d4e49e9bbb44056fcf6ee591e37c04c91fb6c2351a3bcc743f05d2b8071e10b9b473ec6f949e87b7c52a324d30c14e3855298c1cb313438a2224442222d78e0d9146edd0108463f1aba745f5f174a6309e9879b111fed4ce138375c5c3e22188f8fff00b44f495019aa1cb04b132cf829313232b70dce5ad38d107c589d711437f9487e7509d0fc93ad3339e1330530f3d30ebf7382d89378e44e93022d00888c1d71d8c21e8be1086e8421087377b18c602d3aae9ed9a599ee0f6d9aaf6e4e5ca26ac1c4b8531992b52865c4ab36441bb2807009b2b9bc412b89cb84b35df8f4791488cd1ba36ba530e0f2b8e15becf93e8f178bea526d4a0a50cb0f2a1770d929d90ee17652256db75a3c223f788bc6886e593b252ff691c2da50613a9511f2869b04cb0da20c528194f8b69ccaa23e4d5454c0a15c252934da8d9814d38594b85d70b26e902588a61b2b72da4d77b55b77bab9d1a3f6bd84570da4259bb42377fd95cf68181cdcbf6955258b09f173b439becff04922e9e045d696fb623845a889cb6d1522d4e3617810e520221f6545d3658e789b29721bc46db4aed3f29974ee56d2d90b592eb88a6087ce70897647bdf1a9b4b4ce94f87e676555896210d332f25dc7b0dff0ab51648a446279738e1fce375d766e1866f1ac336f66712a3345da1fb22b41afcccd03a4c4d1162365a48b297687b31f2a8916da22b89b1f6574be1ac0df40f33b9c1f99b6007c0deeb82f187f10a3c4a3f65642e6063cb897100ded6b5956762c2f2b56c3b114d1baee1154b9497684ae06c44bb2affb1b3ade19069707de153b1f964e4b9cc1ebe4abf85313a5aaa96c4ff03ba03d48e80a9ada5a80b4c3845c22be71ae4f62bce39cc595693d2f560adc212593c5278628f971195dbbfeca7f18d7f327108d99bfaa6de714594d7588ba83968a86633111170ad735ba2a0c3e1cce053154a913b319b48a9295715641cb9e22ed29e60b2a7dec0d0005615edb952edba9e12518c9a398251dc2ca92465916105b07457d1ae288cdce656f536cf3779553a22d9ff0b9b12707ab6cb8b4afa420e088da3a446d158fe20c59d17e8c46c4ee7f65afe17c0d93febca2e01d074bf72aa5b6d322c362c3022d8f6565d5668895dfa417ad2b950666a08610cb4408f8aaee269419dcd71ca068028a75b2149c544b8edc85986d5f35d7dd625d4f7d5bb26cdf4984c2688526104ed826c314b48d46d5332d3a2e6a551b53ec3a429892269d42b3a5ab7b34e8ac53b4769de11cca15fa1034595b146c8d4ed52d882e0a69b2c91e84e8a7d4013b3c27555c686dd395192b385766cc9334d5a4b9627df95c2e551c7cd8df6b9d149cc5af8e64dd3b6558c66dc2b8445c12226f50da43697d5e54181daa6e8b3f6b8ddc568910f687571287217b187215a5a3aa0f70122d96b81d58e612cb777bb5f5dcaa338de6ecab5c6631659bb72e5b487846d11211eee655da8ea5c67108b24ce1e6bd1781cf9e1691d42827c3526991e1e6522f96551ae1da4a1abc251cc86514e4d10b63c22bb286ab5d21cfe1b62376a12221e61e14876810dcd90f395d1bbab21211d445a5454d6d08e261dc4e7f7798aecbeefcea8158abb7882245765cc852a99da22df5625947e50ade2cba77dde44405d1175968f3bb4c42df5775da45bd571711117cc2aa958a8ddadc226c47ab6db2f74b9b7917912f66d9121eb087516acb717108f28fcf14a98a5e24c32d8b76b6de297ab6e51f68b7ef42d746c93554cab9bb88e11652ca225c45948447eacbbd44d4a5712d1b7336e15c3fe16abbbcb436b67ed7f10c6e6ee12b7bbf646efb4a2ea54122cd68e6c511e6b799ced7c496d4725caacd2e68db6c47569122bad22b6dcbddd305668cd1089108915c396dd38b974f36514216cd0b44d88dce088b57171117c25deb5aa726653ab6dac3b6d72eca5cba46e1d3f8f8d3a1d61a28994aa3d422e36588d5d865d51090e5212cdfe45e44131284375d987d926c8bfced8110f8fb4ad555670c8aeb887334597295d9b17b2e43c9bfd2a2d894b730e621f3825989cb874f76dbbe8b537a94ee54d36e1b6f08e9e1baecd9784be9f447d2ad346ac90b7cdc39b2909710fee84545c69786e110f58dbd85696ac321cad176b2f8a284dae9b195c3c571b6ee1212cd9bd9f2dbf4a439a7a23ce4056676b25713775b97147dad2a5a873175b715d7665940564084485cbb0dceb2dcd6b443c25c43e9f555cb62e6ee2648aeb74e5f74915adba11ca4b96c14b0566a7b7a542d0dacaac34a1cc803aa7deeb34a9d9e88b54c9c73ff004e43ff0037aaff00e458f4c4fda3688da3ca2b4be94a6b0a956e9c679a6bd51b9d2f79b158bcc3eba870ad3014d9cf527e9a2f3ff1dd73dd59cb69d80bfc4dd2a61d2325edd6a5b10b46e4c946e2b56c58573192225da6e511252a4e95a39478895924a2d3036b7eb12aeb93d8622db7c490ecc15a9991ae90dba2b8a50ca56e6dddf65333f5b11d2a1a1384e911169514f9290906ed6ee4eb236b068a0d4d44b29d4e9d9333cf219b25e9c24cb069f0a064d11a08f919323ec8a169cd897585a518e4ff002e54dbe437cad4fb692cde63f6eddd5869724d35ab312b3516a969088aceda9a2e653bb2f3173c2abaae9eed2e76ba2b7c26b5a256b182daad966a90dccb1a735ab13e92765f08888456f54d73ab1555e91e9e2e3245d9596c2b107433e5be975d3f1ac3593d2e6b6a02f995c85a8579c5255c6ec70bbca0e60974b8ce6175ca991eb6290e9a84ab396a9338a86ac29908b956b48db3c291923b9b1252f4f7540529dead49d38f324c8cdd2b10881d558e43569bb565e61b4ae1fac7c4be78af8daf3976ab8aeec95c5708f660be89a59758df7847da5f3bd73ce1778bed2e73c5e3f5633e456b3811dfa528ff0099bf641b50ca445dd5f4ff00e4dd591a851fc05cfed14f73abfeeb53443ef0fec5f2e44eeb456a5d11cc4dc9ccb733299b0c6d21bad1704bce345feb0585ad6831d8ae9b85c8592ddabecb912df84ec2e2dcd60bb6ea1e52b7fc9436d2c962b6e3aee236cb63d5da245ed5ba77fce81d9eda76264723d82f10e665c2b4bb43f117d3056fa7ccbb6db6897e38b98552f92d010587337eba68abedd5bc229edbf96e65cc1b87e1044752c87a59a810bd2a23f08443aadcd70dbfb16b1b437064888b6398ad1d2b15e95caf26c44ad2b4bbd6f37ba3e44519bbc272c1ac36ff002ea7f6548848488b313998784bb5deca4b4ca39e92258d50e7044b1312d16db1b87572dbde2bae8c56b146991211b4b57da4a9410e4a8dd999656a0fc7e3ba886a3950b2d1bbbc28d6c513532fd344f349e11149b7d54932ca9e0a29d764975b1509549811ca3988b48ff376608b9f9e10022b942488115cebb949cd3d914d487a052e18c8d4a0e65c2270407873117e3c4a5645822cbcbc44aacebaeb53244d5af36e165cdc5caaa354e962b4d4c93434111645c21271c98212b6ef3b70c3708fa7d28319994998168047d16ab334723555e98a864ed1f1446e7255e689cb75131986efaaef1c7b2acb41da617659b99ccde20dd69166e5f594b6cf4e35322e3043736e0934f096921772dbeca9f85d50a3ab8e61ae570242a8c6299f554724274b822ebe57a7b48f28a2aa74ff0006999863fe1e61f63fe53843f750afc17a1d92891a1c3676abccb500894b5dd344deeb9458c33a2a60f77890471b7316514f8dae53d0b74576d8e78a0595582a73572a86c3cf0b9a47d65629a8aa37ba39242e6ebe69f31c91b32bee3b0423f142ee459410c6a43152d5b6daa46e4834e4629b38a58510282da692c46c96395e9226dc2cab79742e547db5a20da442a9b18c3fda19986e16c387315f677e43b159345c4d9b829ea8cb1011205619f4d6d1cba5b2a89176aebce275924cee5d2491081aa33338a936a2229b6de212ca9a948dc9d2cb9945733c56531921cb74eef2bb36a444acb9115c914894374bbc4b4ea56c9f56de54931007529e8cb9c3641ecf507119b95a24a982db6ac34fa3e03399474f1a60c8dbd9aac18c237444d9fe884d8f10a6360ba33bee997f28ea11566d90a213b6918e55a04cc05a9721eca8f4f27fe21ac66e484aae0d6c0e91dfcad2b20ae4b883d688e5141c4d4a5786e7089441aeed0691b41ecbceb3482590bbcca6de34d4a9758294704d83798522abfda7fa14fd3d83c7aa28051922198530104448ea4f7450247685685b393a39454e542405d1540a6cd5ae0ad129b357362b93f195018e4133575bfe1fe27cd80c2edc2ce6bf44b4b2a6e9329765257faa4a8b880a7d24449645b506cba03a3d55766e8836e5159fed450caed3956f5192151952a036e0e94f36acdb54c3a0057cd73b244256da83786d5b95536447315ab38dacd9e26cb4a723707951e488b42a4b61997625994acad24b892a6a976ab10cd2ca092544dd6a7a9d2c4fb968a75ba3b865688abc50e9432cd8f32b2c2b0c7554c1a741d55762789b69212f77c119b314c161bbb894a3aedc85c6488baba653523206063068171fc4aba4ad94bdff00008c024f4228069c4fc0d3c5aaa5d1a26248a68d45938bad4c24399709ea7f01534dc5375c708582b795352ce276ab0b982eea833821a6dbad05196978cdb2c8999afd24aee65a3745b5cf04ac48b85e65c73c19efee267ab2bbe8bb7faab31996c9b99222e653ac3da4850c3dbcfa57c521bdee0fa156f5c44552d962e9623d42fac6b3426db71c116f8b57372a1a83202d8bd68fe3894d84ce3ca49bbc4f4acb3e45da268492684c8137e32b7315ded2e153c06399ccec48f92ef14b57cca76c9dc02aa93656b85de454acf8f2a96da26e5404b7477970e5ca5fbd502b3d2251a9e586eb8e3d31c52f2adb93243dec385a3f1ee8c77a63258d959c7207b6f62af7275160b8484b8bfdbe547b5168b4b82a8c35809a65b70187a5c9cb499c66c9a78aefd5f9455a25a9b0201cd86ef30e9f587c88ae522689ad17248faa9f60451030559969a368ec778b49709777f829e96984eb1e0aae9a27375dd164105e84522f5d124bba8d629a9b82889a0533351513311d498914ca62aabb40a895a76c12cb711691e622d2af95d865255ea4d14a72a326039871048bb23765fe3eaa28db9880a44d20634bbb2d83a1aa214b53db373cf3c37117e3fc95ee229b61a101101f1088888fd03e24ead1c6c0c6801622794caf2e77559cf4d3b3917a53c2da875f290c42ddf092ff000a251f4db0cf0ee47e358742632afac9f6e0424250b84a16c611f24605e2ddb97cabb7347729d3cf4b97882e27188f3b2445871fdd1f8a23187a16eb85ebb38303cedab7d3a85c9b8e7040d7b6aa31a3b477fee1b1f8af4b4c66561a44e9038263c3f6789532566d4ed3e6568eae06bda411a1d1732789207b658f4730820f62145f48d358b31d9553272d5a1d4a9a2ee6542da69026ae4c511646d118e9a2da4bccacb541ff00d400aaed5a65474c3d86c973126661eb8903507b7f895fc71decace922c9609a91d4ac2cc72aaf496a53eca5ce754aacdd12d923e4e371088f128c12564d8797be604b954099f95a4aad7479b45b9f43f2380c8f312d3230549d816ed56ca84ce1b645ca2b9662ae325492ba8604047463b0598f4af51b5cc31d4b392714aed74f62cd384a2416d70e8393035be4b8ee3b566aab1ee1b5ec3e09c134eb6ea1dc8a8f999bb54bb66d92a95a18355306da1de1b50f4fa85ca59e0170528ddbba44b100e2028f034e215e1b53707d15d06c6112456a3e9f376a853984e4bcc20754fb5b955a66c311bb87528c0984452e678501510b5c486e9e1499e30eb3915124ec8cc5a59b30f2a0a51c4ebd0b7320e00e8847a1badcf636605ca71109692d3772da3c5de1424fa82e8aa75b71b79b02c37ad1271bcc42422595c6fd6b61187d0a53c2f13107887de1ff0077ee5c9f88e9cc7527cd7a03832a44d46d3d9324da87a9872a9908dc2a3a747fa96796d8ee9aa4cd732a074b388e3c36e516c757789591e9b16dccdecfdefde85da671b21bb295d68f376936e4b6d81598caecd93b9846eb9cb845cece51fdbe5415568f536fcc4bb6597ce11651e61cbc4b52a3c95cdf64becf2fef53d2926d88e9cdcdc3eca0d29242f9f25b69e718705b9ba7f9b1b7a92f7885cd4a79cdb9708447c0e68486ef831bbdadfe9f22d72afb38dbf9484728eab557a3b246d915a2242a5b1cd3d14da78e176fbacc1fdb470b5333c3fe1fbb6fef41c76a4789e79bcdf08dba23fe9a96ac546212ccdff4a365a82c16b6fda112d5c5993ed6b0f453840cb5d66b47db1604734c37eb6af794b4bed74a10915c25dab86def2d0dbd9d911d32ac970e665a2fb50433f4694b8ad9397ecb9e0e3f651985a93ca8c9d1ab1cad6d462110b4dbcf172b6c910f7aeddbbeb51412f5270aec119712e270b30faa3fe8b779d902e11b7b222223eeff00a2816b675c222cb6e6f551785a95c88436ee5409aa74f3ad8b45344ddb96e971b4adef797eb4648f46ed16672e79e2d4e3c5717b44b4691a18b5a87f1d95254a96cdc2a2cb25b655b26426ccd964731b1a3299806de1d3ccadfd1fd1ee6c48474e5b7bbabdef1c15a36aa45b36edd245a892f669826c7de2512f73aa60340d42b2c842d1563a08ef21556099b8844787ce2b851c6d1f1f2f8b87d6eca799ba6677780aab74e93842dc8870893e5de2eabfa96552d1b8bbaa6ba4fae784cce52b9b6ee6dbb4aed256ddde8ff050f230b4575ee1e045032e2dbfd4e87e2bce9c5e07fa94a01bea07c6da8f8231e71306eda3da49895c4839f77855e82b311c7ae64448c2e2270916514ccb42d6c578cd1dd2cb6e839a3cca59b2ea5424d9665332c5d5a3ba61ec0a2aa06861344cd359946cebb60dc9c6dcec996b4175948b93bc228c948dca9f2137712b653dc1b5118f2a955573e146ef521b3d3186f0a8c335e65db484921edced20aa76130ca1c3a1bafa33656771191eea5ed6b77305dd553e8d2a37376ab7d78ae64973c962e4d55bcd774a5a8f69c3f37fcabe6cdbb91b4889509c8ad77a4697ca4b1f72398974ec3a4cf102b99cd16490a4c543d5e0a623150f5556f09d53b4befa6298edaa565decca01b2dca41934f48cbeaa6543332b951267ac6fbc23f8fe2b0cadca90bcf37a885c21cbc598856e3d1ed28e69f1b72b6d909117752763f645b6de9e9b996f1305e75a6c487293b8a4575bfe6b9e713d23aa2a238e3df5bf96caef87aa5987c134b27bb716f32b2ad9de8d6a538388dcb90b7cce651f796adb0bb0df9bed2749cc4e21272e6eef57c56fd30538ed41dbb2b8423ca3945371987355c45eb28cee0f6491e57bcdfcac9b6f1fcb14b9a360b79dff002a766694dbe375b9be51bd577faa5d32b55391ca2f0b83c23319bd6121f1fd4abd075ce6246426dcb6d22221f6bed6f54153c053b3585e0f91d0fe16aa87f8ab4ae196a6223cc1047c94a53369671d71ef0c71b72ef3786de160f30e68c6efa565bb73561766dc212b486d11e2ea8b569d3bbe2579981ca563823973620dbef0f8bfc9679d206c9546445b9c9a9398665e64ae6a6086f65c173cde6f807236e87202511f1c21154336055546efd66d877d0ad5d371561f888b53bf5ea0822c9ea154084adb86e22c222bb96db5d1f696e1b1f3195b0e22b7da1d25dd8dbe55f35ca4c88b770eacbeae62b87eb5b0f46158c471bbb85b1bbbbc36fd1e450278d5c52cdd16eac9895a5a72e6524c7da551d9a9fcce347988733645a486dcdfb14ed167089b122e22211f54adf6a2a2354a95a6ca661a50d38568a29c559db3aa8cb4b3857662c83de2fe1e54b71b051e26dca8aa94f0b8e5c56e0b25c4595c74757aa2b35db3e91ed226db211b49d112e5b6ec2cbc431255cdb7dad71d2161a22b6d75a1cd9b99d747e955fa4ecfe293d70f9911b7d511222fdc9c8e21bb93ae9dc5d95810d33d284e34e0dbd9cbc3daef6f579d9be947c39c6d871b16eebbacb46e6ed1cc45d9fe659dceecfb737364db4382ce51171c2b6eed0ddf1f921057ad9ed8594961c4709e272db711bd223c436f17d29f91b1e54208ea4bbc94d4d6d10638b0d4c377115adf688b97d02b5ae8de530d96c7888b1088b888b55dda5f28f4834329421758789c65c707316571970730e9e18fc6bea4e86eaa53347666dcd587697689bcb7265b4e5c5b93a9b7c5375355cb8de2416b0bfc1659d2135ffe4e78fe5269f2ff00a84a11b6ae56edbd97eb08b98aef69565a86525dfe8dd681a3b003e41797eace7aa75fab89f99557aa17596aafed43e565aa62a05d612ab6d4be4442d8ea224e627286d2927b595f6190febb4765a1f44cddacab84cc5446c053f02506ed442a4271c557431164607549c56a04b2b88d932eba838ba87997d3206add91d82cc4fe228ebd36e1a6e049b749186a8ed66a9788879f644c537134e40d2b283a2901a5a6e167bb55b39a88456753d24405a56fd34d0b99557ab7b2e25c2b298fd232301edd1741e1baa96705aee8b1b0689111922b6eb56912bb243769444eecd5c3688acaf306d75ae14ceb5cacc2586d569a26c9bae88b84256f2abaec8f47d88f093839456d546d976c44728e55515956d63ac0ab8a2a2396ee5946c66c038442443688ad5e9bb3e2022ad3274f16c728a7e2c2aa7d5972b21006eca9b5d94caa1a89b3f8af5ce0e5157f9c92124d0445a48e71b689cc88e929616c4445406d9d42d1c31527e1e36aa0ed04fe2bc5d95a4e0ec3bda2af9ae1a335f8ac7f1d627ecb406369f149a7c3aa8caa95ca24a0a467890115d8dbb2e1b07ba99b5392e198578a0bac15a4370ddd951eab589de854e80ddedf55d4fcb473262294c966523a28ae170a4f12d563a4d66d1d4ab0e6951af4d10aa5c6b0f1574e5bd568784eb8d25483d0eeb4866b3715aac94fcc2b23a34f661ccb57d9c8dcd892e315746f81c596375de61a9648dcd7d14b8025e025b663cc283a956da6872e624dd361b5550e0c63092a2d6e3345491992591a00f3fb24ce498f12a76d0d25a73953d52ac3aef6500589de5b0a6e0d99a333de01ec1602a7f89d479f2c6c24773f85549fa388928d769e3caaeae491170a066e94429d9700a88fdd3752e8b8ce86ab7042aec8c8889255442d443ae93459872a86aa6d00995b6abde1ea0aa8252646e9dd45e24aaa7a9a6b446e6e8905d282453c1f772b52e5de256fa7ec4cc90dce655a8a8c42087df781f15818f0baa90f8184fc1555b440ab7b1d1e3e5a4bdd45ff00fa7332a27facd21ffd409526055dff00e277c9509d826a10566afeccccca8dce37979941c414e8a7648dccc371dc2ac9237c2ec9234b4f628992352a1985464b8a9197d29996c4ab1a6b90b2fdb2912c7ca90c37688ab16d3447114171291474ad8c1703bab292a5f23435c2d65f5474733d8f45a79710cbe017798226bec88c7d651950a97823a5779b22f648beedca2fa109bb5829422f39d7b23da11eb47eb1b63eac54ded5d3efb9710e26a434d5cf1d092e1e87f05773e0fad65550b7bb0653ea3f2156369ab9e163802e1339b315b989ad2423ca51f8d2b66e832cd661976f9b3662bb9b328d90912279c2b6eb5cb7baaf94795ca395505d6bd8fc81225c335d6e62e22d5dd1e51f9a0a4d874925d798686e7dc16fbc5ed214769e9c3ff986cbba8ac7ba62496fb354c8ee212818ef1fc694db004c715cd9692e21ec97f14c4bd7249cf3530d9766e1bbd952ed16f1baeb87eea559427388e9a1e889962b852dc341ca8d856f0969fe5443f14b074510b4664cba6817a28b74533114d38a951d82aed6a5ae1578e8c3660a580a61d1b5e73c83e911f8bf1f1c50f42a3633ed9979b6485c2ed170b7fbe2af9e102ace820fe73f054b8ad6ff00e937e3f8442f26213229707855aaa14aff005554e917641aaacac5a3b4661bb8e59fdd99b7376928c3c76179230fa23e58415aae50d5cda89194fed134d3650e0baf7737937321bca3fb13d4c646bc3a2be61b5b52a1d6881d139b391908b1b9007d57c875e967e5665e967c49b7a5cb0dc1fe5e6188db18461e512847d28ca55474ab874c53127549d6a665a0e890b5165d23016c5cb0f7b2639a312f111c3c70879055418a488f12ea746f92589af905891a83dd70ec5594ac95d146eced074235d3d55ae9f3a24284da392175b251ad32623685b77bc9e89ce06a815bed0ffa26e5a539f334809dc2b106d33323aef6f4d36bf4594d7a409b709414c87c6b5fac5042684ad216dee52d245cbd959856648da709b706d704ad21256f4f36994eeafe9aae394dd9b7d428e93d4a71b3caa118866526d127654ba91728abd5dfa348758a8908ad53a0fa2b8fb97fc18aa9c4a56c7039ce48a6a732cad63772b71d9296c366e2e24cedacf61cb399b8548b8edb9478566dd2cd704445812cdc4b9ad235d53563d6ff0005bec464650e1eed76161e64acfa6662e222ed2f36f28cc55d71fb5744034b2e2a19775ca2e7272d55ca9cfa66ad3cabd3336a5410ab9a6a52fd4ab25127732b953e716654b755aa9d38953b05ec99ad832bae15a276170a8578912dcca0e722a264b286d7a444929b7130d9a2411e54f07a95a73d9851b5a2ca24a2a9d0cc8badbb95365baa5dee1354f794a038ab74f7b329483c8cb510d0a9fd9a986d8996c888846eb6e12212b4b290e5f1ff009c3e6dcad10a89378d32e890b8e3d819b290baddcddae08f8b38b625038788ad8c7d2a84d9dc2ad9b4058921882444db22244e089110b1945a27447c790aedf1878c43747c7ba2b19c5542648c48ddc6fe8ba4f00e2a2199d03b67d88f5feeac0dcf0dba874fe07bc829fa909365da1b6eed69b7ea59bd33690ae6dbf831b9be6baeca2e89796df4c63da52b55a9618da4370b3859874e6e62e6f8bbab9a3ae345da9ae0e4ed6a60712d1cba5ac42f84cc244223cb01fb49876644aecda4ae111e5b78aee1511529b276e2121b6deadcec8e622ec94484503235337310844b2b39b2ea74b288fdaf1a41053b70af5b24e8e1e5b8b96ee21e62ed2b1b50ff006aa4d1dc21644b4e6d23dae1ef2b9d30888798becf652414602908730dc938e3c495865c2839912e5fe9e624e0722ca9f2b4b86e5c808db9546bb765b48bbb77bc829f9fc3b8448bf97ba9d122305edd94bb96f30fe3eea15f1111cce08f6adcaa9155a9908eab46e1122bbcdb4570fdedfeac50b5bda0ccc8e20da4d8bb94aebb2fda8dbbd2b39446a5e0eeb41079abb33845d9d3eaa626ea6d8dc3c36ddfcdfc567f4aac13a45715d6b77116926cbe56de2f9e0a469eeb8456e62b88b370f2966ee979136e92c9bcce90eeac330f5c4437661ca56f6b492909367abcdabf1fea83a7c8f15bab2a3dd85a256eab7d6ca9b26e53cd6e50a2ea6f652f587f1fc50a2e95a36e6d375a819b9cbadca589885a74db6ea2f7a09b6086db48ad6ee1eb04add5c25ca3e8482115d59b635cb9cb8846dcc44445a6d2ca3f58f8919b7fb562c30f08b974c38d908b6dea6dbd36917cff001f6942ce57d89461c7089b11111bb9b94487fd165cfcfbb36f13ee79b17316ebb33823e63d58e5f12914d13e5788d9b920050eb278e088caf20000927b00a429f715b77088dddeb6e2f7ae520f4cdaa3e42396ee224ccd3d99770a5844313631d001f20bcc75d3fb44ef90ff003b8bbe654ac662d140cbb988e2126a632a768e5a89490d5109b29a7de4d41c51d37339934c3e4961a9973d113c7994b535fcaabb32e6652324e65479532f26ca42749553685f5233d3cab7587ae52621629fa382eecc50d2337b895929f51545172d25274f99526486e15a555203a85a1353570a5e2a83a73d954813aa091659b9e3f12d3ba31a8da422b5c896236be6dd96aae1382b70d97ac0bad8e6589c7a95cd939a174ee12ae6be0e438eaa95d2cca5ac95ab027a39897d5bb6d4bc764b2f0af9b76be88e30f1655a3e1dae6c916427555f8de1e6194b80d0aafdea36a51471c5474dad747baa88078ae85682e252f292845688ea242c934adfb1f2b73e28544d95a4a7a592ee0d0b4cd88a60ca4b0888e62d449cdb76db6d8116c6dc47315cef108fff006a45b85ad8e555de90dd749b6ed6dcf64b856461767a90f77994ac581f662c6f70aa1724b8eda80274c5371722aeb98165c41dd4a8cd7653a2efe0544ca16ecc5c59559ba3fd9d72af506e49bb859875d36e09089332825012b4a3bfae228880f8a3e32896edc249b9aa5b1466479b01aa761a074d288a31724d968bd04ec5f85b90a9cd08f82b2e5b24cc47cf3ed9669a737c3c6007088843c7bcc4a31dd68efdda7e4d97d9365f65b799706c71979b075b7023c2e36708c0c7e68c122465db9765b69a116d9641b65b01d20db63016c47b30184209c379730c42b9f553191df01d82ecb84e17150c0226017ea7b95f2af4e5f93a392d74ed045c7a547ac98a4dc4ebcd88e622a69166996edf8028c4f2e5896f800e57b05591116c7e4dc76e2fd56af57378a3bd7dee732b06e9d3a2b171c7ab348644670848aa122d88db3c25e766586bc833de98c21e77bfe32ab9e1ce345a0a3aa31385f6fb28ed96a8115a5ffa77484b89cb887ebfa95c69076b6c97c1f8417ba259bbb8972c73a35ae8932cfeadbcbeadd6dddaf46e8abe7e74b9b976c74dcd3a5d9122222ef6f2f47d2a85edca56b18fce345a58bf78fda158d74e7552bc586cb35a5eafca17c7e21f12d669a7d5ddc3a9641b5345726e65e9b2226db65b2cdf28445a46ef15bfca8afa8496b370162d5aa84a4b3f7bae5ce60f9b1cc4243c368e922f2c231f22fa0ba35ffc3aeb74d13ab4acd4c549c11f07c611b5fb317c19c6b5788444637ee8448b743cb058a6d2f43c4e893ac3c4e3c57385896dc44b379fd8b9c62eeacb2f784bde566c6c646a557d54752c3660d3cbf75fa46eecb499bae45c96972685b16c5bc16adbb517a3d197fcd64bd2374620d4a4c4cca3852ef13844db6ddc4db8c662eb1a28f28efcbb97cebd11f4d953a35d2eebd31352e444452ef75e42e5b6dcdbae46f6f7da308c37eecbe45b74b74eedcf324d949cc36f60f5623d6364edb68b7e8888c7c9747c50f1a12b1a99a37d531c0b49234b8f4e96fbac5f6fe731641bed109710e6b7f7793e65ba7464d14a6cfd365b89c127cb872ba4443ffdfa56293f24ece4dc9d3c447109cb9ce51222cda748c3347d55be3cd0b62db63a596c5a1eeb436fdddead787a904d36676ccd7e3d15471ae21cb87233793c3f01a9558db685caa6d357092b76d598e1aac4ab9a85757a52796b82d500da917546acb56ba4a2a469624f8b859b365560da76ed71054f8db1568e898f8c671703556cc95ed0721d4e9f35a153e36b23dd41ce457a953224da5cc415731ed71b84cd4c4e8c653ba8771b5e0691270cc8995a7bae691f694b2f006aa93c44d820ed4c3f056897d9d22d44898501a1d4a39ab60eaa4454921d4e9eaa900da518daad350836d0e5154aaa1991115a9c8aa339d9386119ad9823196ee2152d332d94552a0fba25708929fa1d16a1385a49b6f98954e3986beb1a035e1806e4ad8f0ed6c140d73a43725130607b2a429d4dbb84bd9566a36c7b6d0f585717b4a54e9e3c2b331f0e457f1bc9f453abf8ef942d0c773dca0a92db6d708ab0494f0f65447e6f4d3a187c4a43b85e8dc2c2f759dffee3620d75dcd16f257461e124e1b6aa12554b54ab55d1e6598c4384e78ddfa3a85b7c23f8834950cfd7390a3a660a95b5151c325667aa8242a81b4b2ee3844e70aae8f02aa61b3d8b4b1f1250cc3f4e4081a8d7c85bb6ed4a3655db9424d0b9899872f0a97a7aeb581614da0a603f98ea7f0b92f17627edb3dc1f0b341f94f4ec5089e9f3cc8618abc0345958dbe14a24904a48351aabfda77a152203678f54a25c6639925c8a4816652c22636e14c979b51f2f4b766dcc361b222f747bcad3b3db3ce4ddbf06cf1385f755d998cb49b7630223cc5c44ab26ab0c3959e23f41ea974e396398e360abd42d8d6a5044df2c47b978451d37562d2194450f3f5227100577292af651479b3bda2e7c947c43882a66f046f7651d8d91331523e64193e99709357a9ec8dad1a0f92a4924925377927d4dd18dccda8f979f6d4191a6ef41ccba28c65e8ae32efb648b80b65aad54e959bb54c4ace2852c642bca391a51550d9a69f4143a3361a2175de1cd6a97959c4be9067dd261b31ca2594bbcb3b8f62953470de33a1d0f92e8fc1b87c15d53925274d40eeb855d9161bb5a6c6e150b52db92d239553232a6e66454a511c7097319aaa494ddee2577382860845a3681f0571a46dbb96ea570d98da339974456652fb3a4db83769257cd889116665bfd6090fac986bcdc6a9d96166526c365a5f81b534d38c3a224243eb2c536e7618a4de2b46e64b336e2d56973a40fddca4a7aaa2d3ad5ae0dccb9ff004c96b303c75f46eb13e1ea3f70b9bf1370cb2b750067b687bf915f31c64c857261dc36c89681b57b34528e73365a5c55a9da78b836ae9515636766661d0ec572834fecb2f2e41620ea164738f938f1124ca43ac1ef2b656f67c8742abbd2ae3459855d51e56c59735ca39a5e63c9b596814caa38c392eeb659992121f5784bb31f2456d9026e6d86e65bf36f37883d92e212ed095d0f557ced437ef15a37455b4e2c3fe02e9753305d4ddc2ff2f74bed0c3e358fe2cc23daa0e63078e3b9f56f50af78371b761f5e6290f825b0f47742a40265b94f082747538449ad9bacd42aae9354f645b9712c37a68b4b656dc3e9b88a397da44f49d4470ae26f8730f74b57ec259cd176e2a14a9771896976c6605e27fc2350934442584e37c5b8bd308e9f178972363355df439ef67e98b9f35f43ecbf4572ed962cf3853ee65211732b231e2eab7e68eff8d513a53e9df66b678e669ec49f86cd36ddde0f24dcac25315e1bb0df9abbab2865890c04a30ba1e2f2af9dfa55e92b68e71b217ea8e6095c2e332a3e06de1dde6ed663bcdb8fa6e8c631f4acd287b19333a5730d961735ba4b8b28f6ae562c6c6d1b2a29a8eaa475dee24f61b0561dbbe9d6a75396976232b2126f32e5e53b252e4c4d3d689088b857c4461e3df1b610de43bfc5e4467473d3ad6a44845f73c3e5b8997b2b96fa70df186f8177b7c10d4ce8b265d784046d1e271ef7ad11d4b49a7f47ac49b638a2256f115bed5a8a57c76b650a4d2e1f3875cbcfa745f407473b5d2d589219996b8474936e0dae32f8ea69d1e6cc31df0f14605be0ad6e41667d0852c5929cb5b2645c160ade12f3842e08f74bcab4e746d504e89e98657d93090fda0d919691cc9f621712a56dfce4ccd3bf9ba41b2987be12dd2df69c2f208c3e38a9986d17b5cc19b0ddc7b346ea971ac4fd869dcf1abb668ea5c760a0a6fa587645e730ed7a5c8ae719732facc17c195be88ef87cde956aa5f48cc4d342fb4e1136456f9b74884b88484611b4a1fb3e746ec2742926c0c1da9c067a64b31365fd99b8f6423e7230f8e3fb167bd27d3c29d5471862e6d97045cb4728e6e1cbf17917418a8e8ab66e4c5e0c83703470161fe68b93cd8962786c1ed1300fe638e84ead26e7e5f157d6ba400b884b132f64737687c7febb92e7ba4916edc36c9ced1382d363feb122f9b77d6b18272e2b974a10572ce17a606e493e57fc596764e37af70b00d6f981a8fb85a655f6ddf991b3c2305be2197226eeef39afe6dd08c21155579b2e011ecdbf8deab9bf77125b53863c4ad20a08e9c5a300059eaac425ab75e67127bdf6f447bd02bb3268629d6ea22595c1f592675821cc39854b6c963670b280ea6b8ccd37fbae8192325aa263a4894403e9e07c529d1876e996b9cc3a29e09e69cf3acfac2a236f7628672589f942c47991d3c4e37cbde87a175b2152747a8134570eaed287244e6eb19b11d3a2b3a2afc9202fd7cfaff75f3e3ad45b708486d21ca42489662b67db6d9162aa24fb16cbcf710e96deef7297ceb2c96a0be333e0ceb64d90966b87ecf36ff8d3ecac0e1e2d08dc7e3b85ac12b256e661b8521b1bb38ed426041b1eaeeeb0b86d5f4eecdd2daa7cb0b0d0db973171112ae7473446e5181211b4ad53156a961b64e170ac06398a3aae4e533dd07e656d304c39b4f1fb449b91f209adacda26e4d92322eb0bcd8ac36b15271f709c32b88bdd4eed456dc9b7c8c8b2896555f9b7d5de11868a665cfbc77f2f258dc7b14757cd91bee30e83bf9945b2ee6499b7f2a0e55d41552715d8dd51b29f33eca3ea8fa898c53d32edc843356d10cad5a2823cadb29690714ecabcaa94c76e253cd1a8939f12835916b6565947d12f16f150926f29283995472a8e58ac53227991ec128978b322e5dd40141eceaa6d831143cf3b7200df2247341d5924948d428d9476d253107157e31b4d1c6f654138ee8a59898ccafbb03342e6305dd6136568fc1bc242424d172ee1228acb255fcca6a5ea44c10badea1d3f8e5f46e50eb69b9d1960ea14fc3ab3d9676c845c022eb3edaac5a7cfcc34eb643e0b3036b6457160175ad15c3e221b0bcbe956395da91296cbdad43a6ef35def8be6531b774762aec954845e6e6887c19c6d9cc24eb1986dbbb2e6fddf4c3c7b963ef4cb8394ae1c3b9a2211b6eb75628f32e355d46609df11dc15e8cc36b854d3b276fbaf17fcfd55f1cab5cdb636f9cd42d9661b46eb6def78b7a2e9136de2385882244de512baeb8bcd5de8ba0a832cf5ce3657179b221e6eefc65994b373878d2eddc3896e9b735bcdf17d0a0b9bd15a365bad1a83516eeb7846dcbc44edb9bd5bbc7bd68fb3af65eb3290ea1e6589ecbcde5e1111eaf0c755c457093a5c451f2f8bc8b41a2d48b29626acb6f3766ee11cbe54c916521a6e169cd0dc236a43b2aa0e8d5ab848b570888f372dca45aaaf1110e5e11fbc95616462e9d724c554f68de69b6c9c11c42e51e51d445d9829f9f9927046db4aeed5ba554abcddc44db62444e6a1d2368f6b99240d13add7759fd7a701c2221b899ca23faeb86d12b7846045e9e5556a83ce0da62236b2398bfc5706def41b26e2aff3943122bb55baadeceaef16a86ff479507b3fb358b8989e6de1cbc36e6b86d2f2095a94d289f05f55052534ddd8a3a4ad112bb3095a3988797d1b96b3b3ed364cb656da45abb25c5eafa567948a20b6f0b6e089364f3b690f672e15bf3f961182bd6ce98b622d5c596ef6478bbc89c8d8cca15bda672a8bab4cb7697bc45a4797321aa154b04bac2b5b2ed5dfd43154eaf56ae22cc2370e6e1d5a73792d8fa512493643d75d26c712ebad2212f5bb43c3a7c6a2e9f596dc71e12caddb75b76522b737747e751b5974b3613842e5b7392a4e5d2ef08eac2bbc6d396fa3c91f1aa59548844b0f1305e6c86e1b4b2f130e8978fc456f8e09c1192a1baa2c54eed0ce8cdbc2d3656b36f35c3ddbbe6245d3b2b62d0faddacc568f76024ab945a7910e279b111eb2d2cb6dc23688fce45eec558a990e25bae12c35a5c6a1c36d1bebd4ae65c778c383052b0fbdabbd3a05362e5a28175dccb86ea1204ba05d728b6a9730ea96a6e56d409966538cc2d6d1b4a4c8dd021df712197132f1a4b649cba464d11130e23e51dcaa1665c4fcabf9518dd1f26e026ea4e6651136e65475449443d152233e20ac208eca3ca39915286837639929a715a11a2b3736e15b69732a609ccaa9f21316a9b666b2aab91b62a86aa9aceba949698ccaf3b1fb464d908dcb346dccca4a5a6336550aa69db334b5c934f33e9640f62fa62855417db555e90b6645d12211503d1ed6348912d3c885c6fd5586797d054e9b2ea103d989525cef65f286d2d2898709569e82dbfa55a2ea21158c4d05a4ba461b5a278839622588c129615d9382d57a32a095b8ee651e1547d8aa314d3e2d88e512ccb760a78b4c08e261b6397b445cdf57e3d0a362955b44d3a9fb2263434195db376f3280ac54f0b2b643776750fb3fb9575d9c9e7749396fe39a0a55d9961bd0ddc5f28e20a6aa465c5ea8e54dd353868f0b7e277598acc41f23aef71f20360a2df973212176df6737b481728cdf35aa55c70a29a28ab16b00e8aa9d532137b9508e506dcc24b79e837f3649c88b4d4cb319e9826dc9bbba978a60a1925c05ddc4e32ddd101b778c63794331c5648dddc2a49a6c8b29e190f10b8225f6955e2b87b6aa2c998b3ae9fb8feeaf704c6a4a29b99903f4b6b7d3d2cbe8b7e7147cc5456434dda5725870c26089b1d2dbc44fb63a47291471046023ba0302b61f122a5b6cf12e171b11ed36f090fac2e5a625f342050f9d622a702a98f56b738ee3f0ba75171650ce007bb967b1dbe6b447aa88472adda5407b6986e11b5c2bb970cbd6ca7bcbe886f8fcc80af6d5b52ac13efe236225688932e89385c22d09c2176ff8f4c3d318280fa0a86fbcc70f8156d162f4925f248d3ffc82a4f4cfb3c52337f9ca446d979e98119c6c472b33ce1088bfd96de222dfbfc87e9eb210193f0d6f124ec73abc3c2cdc2e8e922f7bc4a9db41b68ed42e6dfeae5cbcdb2d969212b849d2f857204231f44216f8a1e951943a918cc61b998badb8b8712d1b7d58dbbfd655f8be18f80079ebbfaabde1dc722a873a26df4dafd4792fa45899b6408878846ded5d68a0aa72b6c83c36dc56fd9b52a41d172519cdf245f6494ac445c1783984bd959a61b95b2b5b5f359a52ea2396ee6b737de15326db0e8b82422575b6dc3ed2aced6d29d6cb1581d2e0b4e37dae61f1fa3d3de424bcd4c83e32852f31e1459859c32271c1b6eb9a11d4dda251df0df0560d566442e172eb7aaadf4cfb1f2cdb92b36d36225e10d30f088f9c177497c5743c9eb294a7d19b6849c21ca375d6db94446eff0032fdaa0b6cb688e65e6d826dc65b65e1b85e1b5c70b84844be0e1f1fa5697b174ff0916d82cc2e5a4f1716172fd7f1c114afb31450d63039ec43f449b3580cbd547c6d9898b865db2f8369dd45da2b7c5bfd1e3568a83b95155b9a1c41682d16d91b444748da36a87adbe20c9385c22ba070dd198a9da5dbc9e2f81d9712e27af1535ae6b4e91e9f11baa46d4546e72c424b4332ae94fe2be45da53cfbb63045d95bd0cc8d0d5cdea22324f7559da698127ad1e1518575b951b4ca5bf36e75624571662e157ca0ec436d5a4f95c5ca9fa89a3647909e9d37564cf0588e9dd466ca4910b3c4444a7d8a338e662ca2a7820db636b62bd18916a55024ca32b05826aa2a9af3776a503294a68386e2522df672a46f4e026dd776e541e791b0b2705a48765d2a2f214a609c2b43320d614ccb5276dca8da9ca0a8e97d9f71d2b407d656f94a70ea74aeeca9284c088da3952dd539059baa4c144f73b33cd876eaa1a8db1ec3599d1171c53f18888da3688f6506e4d20a6a6d4476790ddc55a59ac1608d7e6c45013351b5473f34a2e65eb9488a1baadaba80d1a23a6ab05c28029822d448725c8454f6300d951c84bb746c1d4e0388012444b3665a44928d826b964eca498714bcbe1ba3692024e90e96aca8e1a7382a1cae63baa974cd9e139803651f59d996c872aa8cd5289a2ecad165df21ca4b93b26db8284752f8f476a15af39b3b75d0ac82a11cc9b6e2ac7b4d417331b6395560236e52575148d7b744f725cd60242260bd11b92449392f1cc298abd2177a1488c78c7aa01e79699d0e7464ed48bc2e67ab931d23c4f7f4aa1ec0d24aa13ecb56dcddc372fb5e894f6e5a5db61b1b45b6c4551f1262cea4688a2f78ee7b0fcad8e0182b67bc920d06c3b958cedb5b28584d0dadb79444554040dd2d24b7fa9ec930fb979a666b649a16fab115474d8e46c606db5eea1e21c255134ae79366740164323486c46e713ce36c70a3f6b280e8dc59952261e71a2b495cc1209c660e59aab67b11e5ba3b0eea62729ad92887690988cfb9ccbde1ce7329cc63dbd5554b55138fba90f536de2411cb929084d9279b74493999c374d30b1e6db285dc8c967d48b926242a326a589bd28670fd14a644e8ce61b2b5ec7322e9111179b1b92768aa38a24c0e9555909e71bd256dd9494a4a34e966b4967314c1c544b9a57f83b2de70ff00137b1c0594f1de5bfbdbe8bd2322222a6b66d91c6b490319577e4c934d3a4d971092a9aae1aa49a3221d1dd0dd68e838e6be0983aa45d9d45adf11e6afae4a810dbeca829922967db31d225eea6a46b044422a52a2c6286f5cfeba865a3939720b1dc7985d7b09c4e0c421e6c2ebb763dc1ec559db809e71d25997a4ea169611692caa0b63e68bac60b8730a939e97cd72643b4ba0f885cb1df046c5f6cb1259fcc3fcda55076d68de06f0db99978715bfbc3f52b557048705f1e2eadcef0e9416dff594c97738999821f55c1fe615a8e18c41f1d48849f0befa79f4581e37c2229688d53478d96b9f2bd8aa19444b50a88aad241c1ca8e89ae112e9cd25a745c604ce0ab3254db08943575c2172e12b484ae12ed0ab9cd165548ae81115a3a8894f8497ee8365cd205f41f4715e1acd35b70bfb54af55303cddaf5ad18fed54ddbad9f16a644c86e9521b4add4243cdd98897fd38a1ba2c9bfcd586e0e6c4b7c23b4d16affb2d07a56644a54a65a2b9971b12cbca56fe3f6ae41c4b860a4a932463c0f26de47a85df782f1e150d10bcf8d8003e63a1fcaf9a36c68c44fb2c037884f3c2223c2e0b85688f6775dbd689b1d416e4c7c134e0dc2596dc4e2c5eec6e44745d2b4e39a9876a4e0b6f324d8c9e2396b7d6890b8f8b7f08e434fcd72d45c76840f0cd3b74db8d8e008b6244d888dc424db23b80b795d1df18c752a1cd75b7a8a9c921b31cef41bfa74555d9ed9c7e61fdcc4b91626978849b64447516214376af8b7efba0acb5ba2c9531a61e77f49a98dc3e09172e0bdd1cc587bbab6c47c87bbc777ce883e902726b7049c9f81b2197c25eb49cb7870d81ca397e38c777c48790a244dc8bae913ae115c6eb999c2ef172fcc9598594573a7908335a268fe506ee3ea7b5be295d1bc91342e1b9a9e2bcb97d5f408e6f1415b66a3ca9a976f0c6d11b4789114d9227cede11d45d9ffbf93726402e395aa0544ad2f321d02e4853dd7f2b4587cce17c1f74788be6566a0509893088b016916671c2cce3a5cce1f94a3e3fa91f2ac0b622010dc30f227e0aee9a2e53328ebbf9aca55c82793311b6de4bcb0ffca668b18c25274786e9773fcdc6f77d3b8e1fb16e0aafd27d2bc2e9538d794e0cc5c6f2dd1c46bac1b61f1c6dddf5ab7c2aa7d9ea58fe97b1f43a2a2c7a8fda689ecea0661ea35fecbe516cf2a56328c19b52124205e3b97546bd7137c36dd384ea40b88b832d2f418691673d9108dbdd330794852e7edca5a4909e08d732ec64794925ce0e1628db1e537694f5558b0ae1d248517bd647c93bf04ea88a9ca930e767849136520e5296fa70e199bf2ec8f07ff1c5eaa2189db7bbcdcbfcaa0da7d120efe3f1a93b7ba86e86cacf2d39a737f329c919a69db45f6c5cb7cdbdc43dd2fdd154307087c63987eca324e7f975710f097f2928f3d2b256d8a729ea2481d99a7fcf35ad391b5b1c3ccdf097f32cff00a50acdade1096a52bb375cb7b43c4d96a1fe650fd24ecab8f8f864a962088f58cea21ed35cc3f379563db838a7aa0f71f0f9f75d11bc4e6ae88c56b3ed6d3a8eab2e37504f66244121265db56943967226eba24cd4cda2a1a6a62e5c9c9951ee3aa540dcc55bd3d358271d779945bf3571765226de224cb22ad8d9a15bc50868b953f4653806a1293052804aae576aa9ea85de54a4ab8a4da7540cbb8a4a5dc4daa99e34eba5991404817228868922ea3bdba045331cca5d98e550cc2976e3950254670d541cdc73a720e654c54239929a8e54574f16f842798252d08dcda8481daa4a4cf2a225272dd5fba2096c7959e62dbbae6087b2e5af7b3a45665d286c8ccca3cf3edf9b98c5271bd44ddbe7088b877f956cff0093db5d4d40b99e607d9170bef277a6ad9f37e49e101fd60971769b12f9fc9e35c778a1e5b893cb7fe5bfc97a0382bc58532377991f32be478d44ae2b47f5577674e52e1d29d8cefdaf385d9e112f2da9a983c2b86ec372e2b99706d70735b99d2d5f1a8fb7fc42b6ee2b7fdde955f94382bccd94d95de95522eadbb86e2cc3c3eb17f056790ab960895c442db984e5bddbad1fa6e2fa2ddeb30939d22c673945ab6d1cd7097ba36dca728f38eb92cf69bbc285f2b786e62d2b7b238630f5be74d3e1d14864eb5c91aa1625b70e1b224e966cbca3a75129a95a87562e39766b72972979afe315933739fa5bc375ac8889136259ad1b7da2b7c7bd5e21384e5a45a5c2c5b4785862db47d914cb98a6c728215b42a3d5ddc436db769cdd9e5f992df86622b4b0ed1d5a88b53b7767e282ad4b5408ad70b315d761f2b5a46efa5cf27d4a6a48cadd571138456dda86dcdfb05208529ae09b9b012c41b6d6dcb4445bcb8776a211f2db6a71a63290b7e6c730f08976bf7266588885c2e1e12ed6621cbf276da96d4d75624456dcde66f89b22e21e6ddf1248097cc164e3520d9379b515ceb7eaf0f67e943c662eb5b12b4846e122e1e1cde9e5f1f6b7a554275b6dbcc4588236895b689108e612bbb3e3845424d4f108e2110962322d7685d2e6f4f8edf792f2265d2295ab54c5d6074e6b86d2d436e521b8756ef9f996753b32e0e6b6eb6eb44b565e1f889b8a95aad65beb1b22167a9967eeb6eebcb4b836f6ae847e3ba0a0b69a6445c1744b2e6608473137336dcd17f7659bc4959542925d157eacf913637652709dc3e61c2cc236f2c44b76f50d4b22b9eb6dcb85883deca24223a8a1e9dc9dac4c136f5d9babcd6f13645feef4795583a3ca262e1b96f5cf384368fc1b56dba777a7e7f2290eb3597516219e401586af46f05a64897c338f4c8bdcbd5372c4d5bd9b5e28fed4149e515b4f4a1b2589b3ed9b4ddae534987dc11d44c61603e5f575651eec562713b45747e19a80fa16db71707e64ae3bc6b4e59893cf43623e407dc271c3ca858babaf39950b125a3ccb22c65d19259894e3859541d335295982ca96d299946a8270922f48892e1c138d7201a9a99752a51d414c9ae32f271854c6c7a2366c945cc451ee16551b3249f66e9e637551af92436e24cc921af575138386aad5acb85312eea93947d5765dc47b4ea8953158a873c1756764ae474b280909853b28e2ae768a8ea232d568d979fc270732d9e8151c46c57cf60eda424b48d86ace91598c7e8f98ce605a6e14c4396f313b62ad5b73262e324b0399d9f75f99c369b2d4be9271a175bcda7f1f8dcab73afb12d70cb08e2713c5abfa452387aa660c2d68bf99d93dc48e82194485daf61ba8fd90a3354b961bad2982d43c57769375aabb8feab7b39501353d766baeed7f2a897e7b97d62fc7fa4169a0a4b3b3bf571ea7f6580aec524a8f00d1bd86df145990a1dc7c61f8b89066ff00abf6bfa5304ffabf8f79586815508c94693ff8d49f92608b34728a069ad1385d9e644d4e787406914873c9395aa5474e1a333be03ba29d9f16f2b63eb201e9c32e240e326c9d46180204b9c8d846e4a80a085d5e8be97709be594640e176f569e8a2402a1566da7448d96c5c73766b616fa3ba5e4fad525c3cab6bfc99e89180cdce971db2adfabb9c7be7d516e1eac5556335221a57b81d48b0f53a7f7577c3f41ed15ac691717b9ed61aebebb7c53bd27f40f213c04ed3c5ba74ef0c5b1b655c2e57591f13718f38437fc708af9beb1449aa74c94ad425ca5e69b1b86eccdbc3f2adb8395c6e39bc708c730ee8eef1c17deca0f6b765e4ea6c604e4bb730df94088471193dde7197376f6cbc5e58797c91df08c60b9c1aa32466297c4d3d7a85d85b4020944d0781c3a743f8582ec84f13928df69b1b7d9568959b202ccbceec03b4a1b5a2298951f3645a847844bb50fafe3dfe580c73f1b8736a1e5d4243d9158fa9a674325ba743d085d1686ad955103b1ea3a829cacc1b2b9d11121704b104bbaaa1b3fb64ed3dd169d6fc3a4c4ba9c4cb30cb7c4db733e51187c49ada79e7e4f30e922f548551dadaf949bbb1470dc6cadcd94bf8127a195d6b853ef0e5e5cc2e0ec5593a5cda193a94c489352ee36e3656b8e3975d843710cb0dbbe16dc5bfc7fbd5ef62ff0046a73932594886d6eecbc3fb87c6b3ba6d3b1de6cae121221d3e70adb6d1fe3156de91aa22d0b326d97991eb2dd3715a5ed7fdd58e1f466bea9908ea6eef268dd50f11e290e15873df19bd8786fd5c7401092d51b8888b890fb54f93ac5a2a2659f524cc6e1b49760e4362b587babce54d5ef7beee37cdbacd65e5c81c56e959217c444b4a12b54e227b2e515354b62d1153e47e660726ea5e5b27877fb2949180b4ddad8888f651103e642369c89a8075374d6627744892f45d43de9b13b8bb22936448d64b8929f7ad4362a69d3b892804cc84ec13e024e6acadfda4634f0b6368e54199a45e83cdf4e89da788375ea8e8cd2ec5e51c26bcf3f6a68354b325916f4ca8a9c9c43cd4d28e71cb93f1c4a054d4e9608c37d2a5db22d23712e51a9c6f95a39447512b5409a961b43573271d20668352a336074a33b8d9a3fcd1430d18b5399538dc9343a926727c890512400791a950e5998d3660bfaa9702611b2d5169bd22ab518ae6f497440ee89958e6ec02b7c2b629f6aa824a98c09115a224445a4456a1b0dd1d1b96bb37d58ea16f8940ac920a666679b7dcab9c322adaf7e489b7ee7a0f52a2db9037fcdb645da44c9ecbcc93823cc4b63a653d8686d6db1145c007945669f8fbb50c6e9e6b730f04c7a3a476bd6db2a84dec5345298768e25b997cdfd26ecf7823c568f12fb05635d3dd0c49b2314f60189bdb5195e7472b8c57098cd3d982d942f9c45e4f4a3bd60a897cad221e524ec8bdd60ae895b1de071f23f65cfd94d6900f35b1fe4c74e0c7c535f4c0be25a4857c9bd1bd41c9662e156ea76db3fda58bc670b96ae77480f92d252f134144d113c6abe87b90eebeb24a1edc9115a44b44a454db7c5652af0f969cf882d561b8cd3d60bb0ea899d91174730acff6bf6346d22115a604129e685c1b492292b6481d7694bc4b0a86b185af1aaf976ad4e260ad2140c16bfd245006d2211591ba16910f2ae8787d60a98f32e258de16ea29cb0edd1237ae44976305cb5582a609f979a2147e53151116c91b2512151a5006a15e50b9cff0bb6535b314568b11d70bcd927e6ebed3656b63a54513a4225696ad4a026a3995056e0f257485ce90b5bd005b4c3f88a1c1e10c642d73c9d5c56a145afb4eb8224239958e729b26e8e61b4961d25324d9090966157395da6c41112ca4b358860d5b43fa903cbc7d42dc611c4786631fa554c6c6ed87637f3e8a7e6365c5a705c12b851201e2dcbcccee41b8974e39964b10af96acb4ca6e40b2e878460d0e1cc7361160f3742c946c9b6cb84b297acae44c5c2a99511d25ca4adf4d98b9bf554484f42a55683a3820840481c60f4969ec970a89accb9153a71a2d4d88be3fe1966f76e52f558f128f6e6c5d6dc1e2c375a2ed090a9d452f2aa637f6703f0baa7c569bda28e567f5348f8d964d135cbd347948bb2b9125da46abcda5b6364b7145c249bc6c42e1521124cbe3727a37db448b106e114e4ddddd56cd89af0bac3d4d7f3620978397da6bf7c1670fb84292d4d13642625690909097290a8788e191d5d3ba2775d8f63d0a9f866353505632a1bd0ea3bb7a85707765f0dc1b9b1211d25f795998926ed1c42b796dd2a7f65e69aa84836fe5c41caf0fc9be3f763e58275ea685d688ddf77fa9717a98a4a791d13c6a0d8af4dd0e2ecab85b2c67c245c148a3b61a46ef655818141c84bdbdd1f57dd5211888ea24cb4129ba89731497ced1cda55d68f282d35018796398bbcb15e912b9690b4d979b2175ccdca5708fef5b5512705f9765d08dc2e36063f410c22b491e14fa7a764eff00fd4bdbc8696f9ac24b8eb2aab24a48ce91017f371bdfe48f5e5e5e469d5e5e8c179790417cd7d3af473e04f3950951fd0a60f7cc3623e2959870bce888e960ca3e3dda48be782cc825c817daf3f28dbed38d3a02e34e0936e014378909437142305f30edcecc953671c962ccc95ce4ab9cecdda4bb61a62b77c3b89f39bc890f886c7b8fc8fb2e5fc5d841a577b4443c0e3e21d8fe0aa7b6e73276104f3ac0a66c5acb2c2660ed97224ba26b91824c51201158d70e6cc8e95745f6f09df54947cb3f6f0a90969868f50da5cca3ccdb8d94ba7790edfe0556aa7284c39692536f6f572aa5286658cb99c11cbdaecace5c3269c26cb849478aa35ca775613d2dc666eca79898f6bf19575de6865eca8a65fde8d65d535afbaac7c594dd4849cdc75095ae0fbdfd4ae1b29b4b9ad2cae7bae7f292a01e5fba964f69214dcb13646d9c8a226376662b9f481b10334d94dc8888cc6a7a5fe53989bfd67cde9583d61c212202121212b484b29092de7653684c87575cdfbc281e93b6242aec14e4988b7516c7ac64728cd08fd97be28fa7c8aa72ba03677bbdfb7f65a3a1a98e4700ed1df75f3d387726a6208a6650b1084c4848488484b29090ea124ece34ae29dc02bf0e01c02817609d9515c7c5392d05265914b71f0a96928a304d012f1450455738eaaa656ea8c649484b9a8b651ec4524b94099a8f38a7a5c90867952e58d365daa82e668a4d98a9289655132f1473c7950ba885baa8b9d8e64db6e2e4d92658249275525adf0a2f7a909175469a764dc49ba2016efd0037fa14e1734d08fb2c3777fee0abc56e5c49b2eea87e8e6965254a956886d79c1299707949fcc225da800b7053b325bc5719c766135748e6ed7b7cb45dfb8629df4f43135dbdaff3d560dd276c73532e3cee18e56446e6c446d76ed4576a1f8e30e6583d56884c095a44e36245d60f088e5c4ed0fa17d815f91c422f5484bbbabffa598eded08899c36c5b221f8111b71074dd978a1f1765408e42d5a19a20f175f39b2457652b44adb84bb25f654c493d865c44237620dd6888e52fb56fd3723ab74599608ae6f35d98b0ed707846e1f208ff00aa8808dd882ee527ad2b8b2e25a5987eceeeea941c0eca0905bba59542eca396e70710aecd9748f6461f12b5d2ab8e38cb7695d862fb4e66d424570dbd9ca508c7e8542971b9e2cc39adff009a375a3974ef1f4a93a7bd688f0915cd365cd70f5b9797d1be289f1e8951c962b4599ade6c4bbab2c0cc3c584d3642223c59ad82b24d570b2e6c3c39722788472dce8da36dbeb6f595483f7133715c2c8da436e51687b5cd0f8d2aafb484e158de5c42b47889c6079adf15aa2e424e8a609801aad1a53690710846d16f044444bb4398bd91f1214b6b3ce7ea5912b8b4dba47ffa5994d5448488aed2368e6e515e1a8961eab88884446dcbeb737c69de49b26bda4ad3a7abda6ee121eacb515c396d406d4d5c45bcb7659a16b2e9f31766fa154297070de2370babe62733165ca223fbd37519fcce36d8890e196aecdbd608f93c6236eff2f9520037b2374a6cbb5b9a27449c1b8bac6da644751342396ef58772227c6d96b9c2b9e7269a27044aeb49a1d25f40a8997bed6c87291110dc45ab2f0fd1f3243842e36de18b836dd71116a1f95b79a24a4801442e37b84bb09cce45708e626c8b3108dc4369737ccbe86e85b675c6c71dd11112f32df175a2373a45fb966dd1cec2bafb0de20da2e162b84575c2245d55a3f38f8fe6b97d2342645b11111b4446d11e5ef28b3bafa2b1a76e517567a644446d21126c849b704b4b824369097d22be7de977a337e9ae14cca094c535c2cae0e672548be026447e2f41f922b7a8389da7d5080add425a84b30977854ec2b189281fa6ad3b8fdfd567b1de1f6624cb9d1c362be3576395086e2fab36d3a3e6e7ae72466069ef6ac3c161f9378b95d61c865dfe4df08c17ce15565a39b9a917c5991a94ab84d11365fa0cc3836e51c4f1b051bbe85b9a1e2486a4dad65ceeb38567a66e6043be850b4a46cdb9950e124eb0586eb64d976b8bb425e421f9e093347956958f045c2c7cb096b88210b88964ea1521c24e35c95cb0535311496e29971d4a68d3cc7298184046c0d05371440c50d32a4b5c94d6eaa266a08446cc2123056503959c4744f4a0a92c343d31b5306c654a9a4be8a1d44a03ac8595754f484caad9c2d4653dd222111cc45a455748d5127843c5c2b5b4e6f5a5f473b30edbe12ff52cea112d4e777947e75ce8db6085a6c672a039b29332e5ed0939fc14e6d6ed28865e2e16ff009bb3f32a879350796cdba9fc2aecc290e727c5d07e511b475c1b6d12c36c7deeeff15489ea8ddab4f0b7f78bf820a6e7488af32b88b48f08fabfb90211b8b792b7a7a6640d0d685455333ea1e5ef28c75e23cc5a7ed264dcfe9fe94dbcff00f48f2a11c7d492eb269915d3cf3dfed4aa7cb13ee5a3eb120e41827dc16c55a5d88cb3784d66738894674a49caddd4f6c018dceedbee9334786384d7ac4838498f192e6210a62249d64761ba8af9b31bd93f80d7797620d72a1a115d8c52b2048e6bba593f1835ca849e8808e55c70f953319422432db64a0ebfbc8539cb7f1ecfbcbec3e8e293193a5c9305088b82d0939742d2c577ac72050f8e04650f1fc4b1ee813a3a83ce35559a1ea192ba45a2f8579b2fedae6fe012f1043d311897a077fd0ab07c4788899c2061b861b9f5edf05d3f84f0830b4d4bc58bc580ff0094eb7f8aeaf2f2f2cc2daa69d6c486d8c2e847d0b19e95767ce44a132c0fe8f1baeec91737bd1dfe95b4c1476d0cb41d967c086e126cb2c7d3180dc3fe70822746d906476c506cef80f319b8fa8f35f30ced55b9c61c6cbce3639798ae1d25da812c8a7b639c1270b88b15ff0057b4af1b5d27f9b6749f1b8a4e69b269bfd595da6ee1dd76f4866a6d13171710db696acb9bfcd53cf4cfa679611a85aaa4af8ab606c8d370750a7b619b6e4e50a71c1f36d8888f33f6db6e6d4312b7c9f3aae3f344e99384571115c49daad671d96da0cadb2596de22b4848bd921843bc48069743e0dc339313aa1fef49a0f268fc95c83f8898bf3e7148c3e18b53e6e3f8524c1a91979cb454240d2da0270ad15b52c0edd73388b98eb85200e93ee7654a0c2dca98976c5a1b4538d47894691f7d06ca735a4f88a748926f5c0811165cca6a99b36eb998b2a873d5470b7348e0079a994d473543b2c4d24f928379ce1144350b455ba99b3ec09759ef2919ad9b61c1eafdd54e389689cfca1df15a07f06624d8f3967c3aacf77ae32599596bfb3180ddc24445c22ab52cc383a9b2f655b53d64538cd1b8154353865452bb2cac20a25c4dba568aeb84829a7549dd356b25c5e423efa499260d2d8d51677d826dd3b93b28c5e422998a9ba0b768dc9f7bb236ea1d3c466900f9a986ed69bc31cbcca1a6dfb8948b8244843945162206a54daf638b72b7640c62bb04fb8c5a9b802940dd671ed2d362b914b97649c21001b88b288ae5ab43e86a858b318e63a74dca2d6d48a788bcf453f09a0756d43616f53a9ec3aab8f46fb08d4a362fbe22e4c166cda5b57838277726c85734a9a992a1e5ef372bbe5050c345108a21603ebe6533727fc20446e221111e2251d579e6e59b275d2b5b1585edaedd3f3ce136d91372e3a4475176894ac3b0c96b1de1d1a372abf1cc7a0c363bbb571d9a37f53d82dadddaf941bb35c23c5fcab39e9676d587d826981122e659d45f226f5121db1b9b25aba5c0a281e24249b2c1c9c6551524461a003b9598d46058857732553a1d60f79395f1b5e25da0c2e787bcb6150fbd3b8ff00ca7ec903de1eaaf9423b658451928794957e8931d588a9965ccaa039b6bacce21774ce3d92e0e1095c2af9b03b444242244b3db91b4798b1e12512b299b3464109385d7494b335cd3d755f5152de171b1246ee557d819cc4607baacd882b9a4f1f2de5abbd51cdce89afee1446d6488b8c17757cedb432f86f90afa52b2e0e0b9dd5f386d59fe92e77969f869e6ee0b9df1fc60063baa8adc96c825b0da7ac5ab73ecb9dd3d3b9daa7596053b16130069e17944792b494ad0344d90284a8c3329d225015673327a9b74ac563fd30530049e1710046bb1753ef65d55412962d0766ea188dd9c4dfd9564933cab34d939ec3996f94baa2f5bfa9686c1da4b8ef14e1c292b0968f0c8330f5eabd35c058c3b11c30090ddf11ca4f523a14f3d99cb54fd3c0a02abd26573cad9243955046d5a5a975828cac915a4aab4a99217d5c2ba1d592ce6a33786e7694ea1a47d44ed8d9b92a9f16c463a2a374d26c07ccf40a0b691826a65c1e1b8887ba44a3c4d5bf685af0992b87338cf59dab7887f7faaa8c2e2ecb4e0e400eedd179b6692ef2eb7bd73f345112445d4393c9971e4e10900a76646e516ec6d466320a6a29e89fd0a6a48c6eaedd0d6d30ca4e930e95b2f3838645c2dbff0000efb5e28f7be65b5783d9eaf17657cab05aa6c6f4ac2db032d50b8b0c6d6e686e2cbcae88f8cbe2df0dfbd6338a7037543854422eed9c06e7b10ba2f0571232941a59dd66937693b03d8f60b4e9a9e11e215093f5e112211d56ddf7ae599ed6749f29f0588f775b26b37f89b939b275127640a6dc1c32982b5b12d5843a8beb2fb2b2f8660753354b1b2b0b5b7d6e08d16e31ee26a5a3a192589ed7bad66d883a9d8e9d93b549a271c232e2570e8676fe1245e013656cb139fa33a5a588b85e69c2f928947c51f42cf26de514fbb74175dabc3e29e0e4b869d3cadb5979e30cc4ea29aa7da5a7571d6fd6fbdd7dac25bfc8babe65e8b3a527e9ee0cbcd11cc48651e67a57b4dfa5c661e91f47a17d232336dbed83ad18b8db82240631b8484bc843b9737c430d968df676a0ec7a1fefe4bb2e158bc35f1e66e8e1bb4ee3f2116bcbcbcabd5ba4aa8f4a1b2b0a9c8900da332cc71a59ce574786ee528658fd30f895bd7b7272099d0bc3d87506e147aaa765444e89e2e1c2c57c5f32f9364426386e3644db8d96a6dc12b484be824c9cd8ad97f282e8ec9c12a9c93773c23fa6b210ccf343f0ed8fa5d1f4c3d23f42f9f821caba7e1f8936ae20e6efd4762b8d625821a294b1df03dc298f0a4a83c826584fc0372b104aa9731a364f5cb8315c818a542d469bd91f4fa8b8d165d293b594c09b6ca658f3c3e7079bb4851455326ec2bbda51aa29f30ccddd4ea4ac319caed5aa8f2732425692946de4bdbda56138332df9b73dd250f253595448663b1565534e0f89bb2b203b70a4365ef28e967d1703539afbaab74597444cb4c934e0989661576a654c85c6dd0d2e5b72a13d1fe6521499c2b49bbbb42932343822cbb1561e92763c279b29e946c467046e98647ff3023f083fac87f9ac3e6e0be81d9dab15a243e71b2cdda1541e98f6745b73c3981ea660bae11d2dbfcddd2f2fed50e3bc4eb74e9e5e4af286b33bb2bb7fbac7a72199725e29e9f143b31535f25c2d30376a926228a6e2816491204a212a148d47b648b68d46b468964d12832314811e54b9234191a764a2924eaa2b99e12a765629e9871072ce253a68eea172d093249a64948374974c710ad659f9678b09bf548b57d03bd0de114d68bad9e27887865d92b7fe6b9bbfd157d4e234f09b39daf61a95754984544edf030dbb9d07d57625bf28e62ecad8ba1ee8c9db9ba85406d6c7ac97952d4e10e9274785b8796d8f97d2b1295dae129d95969367c1db7a69869c788ae982127044ad2f82cbcabecb9d744445b11b4446df67f1bd63f1be257b5992216be973bff65b5c0b84185e1f31b9041b0dbe29b7deb8971e2ca85124e41cfc732c00b9372ba888836c07440cdb376a55fadd32e1c46f5090bbde11d43de56828a1e698ca49fb205c6eb1cdbca19663c322116f35a3738e093b70dc3e52dc5f12c32af2e444420d9383e7072e92c5f34e8969e2f12faeabd23733769b7517c261172f6a1e5598ed36cd5c588d8dc45a89cea872dda9c6fb25bf7ee4a63c3136f6670be7cc1c0b9cb46e2b728f0b97692b92e56e2cc5e644b2f7888baaece6fab2c16935ce8f05cb4fae222cb6b64259b9ae2d4dc7d31ddbe0a8f35457e5889b26dcc41cc5aad16cbe14bc5bb12223e28296d91a458286622147c5eb870f4890e6e6b75166e642cb399726a2121b7847d6e6f9976698b9cd243715b68dc56f7bb31f2a99a650c89c10c3b6db8b565bbef0fa52834048372540b9022b6eb8b28da23f7bf1c28d94320b4b510e6bb99dfba304f4f4a16361b794b35c3dabb3109790452d8a6115ad8b99ad2b7e4f296612ff004f1258b20014db7364e1618f9cd445c5fc047d09736d90b98994b37aa370e9ca8c8d34ad2c3b4471045cf94cbabe721f4293a66ccb8e88db708966b6dd2eba56b575d1fc5a9a3946a9c0d27451acca1bee0d8db8e5a3cb6ead3f30ea5a0ec2747cd3a42e4cdc42d9095b717585f04d172b70f4fc6aff00b25b20c4a3222224e165122e62e222f5bc90574a5d2c5b1b4478ae2ef28ef96fa052a38437529ba4ca5b96db446df7444455825c2d14dc9caffb51f8698ca9fcc9b71de5419bc887906e365f8e54c48c52a170ea9da96d1b723253538e15adcab2e3a5dab4728f7a256c17c4758acb939333138ef9e9a709f73b377f01b56c1f94feda0e1b74660aecc2fcf10f088f9a96ef44b347ea583c1c57986d398e3cc773f6596c5a66be5cacd87dff00b2b950b6c9f6045a74466a57e45ebae1fee1df2b5fe8ac32d3523383d44c782bdff0f39a48b95a991f17b5082cbe2eaedeaf69eb2584f84fc3a2ce5561f0540f1b75efd7e6b467e49d60ad75b212e1e52ed090f8887e78266601406cfed84e4b0e1e59897f91981c41f57d23f5455a64eb34f9bca42e48bdd9ebd9f64b38fd518ad1d263913f49743f4594ace1d958ecd11cc3eaabd3305c96253d59a03adb78a16cc33f2d2e58a3eb7a5bf5a1055f0caafa291af199a6e157189cdf0bc58f9a3624989834c93e9a8b8a534a48626a610b0866443b148647329f13ec14a6e814ad3414c041474941494b8dc4223988b4a6e493555150733930ed34dc2116c6e222b4447896d5d18f478d535a19ea80894c5b736c97c1f68bb4a43a3cd946e45a19c9b1129821ea5b2f83ed176bfd12769ea6e3ee5a45978955991d54728d1bd4f7f44c55d6725991babbedea9eda3da12b49d22feec78567ef4d138e119f78976b93d8aef647288a08ced1ef2b18636c62c02a07e679bb8dca7eedf15c79db74a1e0f5a3defb2827e6138e7d9064249443cff120a2f911088f1206a137c22ae1b1349161bf0b7f56a644bed7f0fdaa14b39272b7756715286b73bb6565a05246598b9ccae3839bb23cbdef8d0b353cd0dd86371731206a35171d2cda7950049e8698b45dc7550aaab03cd983445bd35721e104def5c8bb6a982c1579b94fdabb06d0719b4b19e142e1118dea41b695afa3bd962a9ce8b1986599b5e9b707e4eecb2e25c26e5a50f8e02271879153641e374db06849c79e705965b1d4e3845688ff00dfd1e38fa17d55d1becb8d3245b62e81bc5d6ccbb0f85983dd7461bf8210b4461ca10dfe3dea8b1dc5052c3959efbf41e5dcfe168b86702756d4e7907e9c7a9f33d07e558a5d816c440044404440446168888c2d11111f108c21084210827b72f41757375d95a00160bcbcbcbc8234955ce912aa12b4d9a74cb77544d878f71138f756d88fc657143c5f3297a9cfb52ccb8fbee0b4d3637386656888eff4feddd087963e282f9bba48db772af32300dedc84b95d2edc751b9a7c21e1f25f11894047c76c0a3e928ab6c1f0e7d54c34f0b4824fedea567788f188e8a99c2fe370200f5d2e7c828caa53c67241e942d56dccf65c1ccbe7d61e7f19c69d221c3226c87b4396dfdfbd7d074998b5c1254de94e8cdb53b8e2d888bc377addae657f8ee0bed12b5ccb027437d965b83b891f4d13e392e5a35006e14653dbb1b11e2d45deff00b088c3d5460c546ca4c23a0e2d0d2c02089b1b7600059ec4267d44ef95dbbc93f34f095c5b854e488080f6943c843891a7309e95d7160a235a2f728f8bb727e2e28b9773893a2e5c423da5188b04f34e6759689b2928db6c6290dce169ec8a2aa156b4755a899596b5965bfd5aaded653ed1baeb8b4b63daff00b2e2b8a55beaea9d9dd66e623c801e4bd218261f150d0b396cbbf283e65c7cd40d7f68c85cb5bb88bb2bb4cda09be624fd2f66788b3116a2474ed38586f1155160bd99f0eeb44c91d941908bdb5b6de6acf419a236ee7caee51e55272cf4b1398656ac9bff0011bbf07ed2658a93e4e5d71292da89e9ce56bad6ec540928e96b407c8cbdf6246b65a86d3ecd898dcd7ab6aa0d5694fb1e7072f329dd9edab36ed17730f6958abce8cf4b1610e5e6ed2d9e07c4ee2e6c530f2bae79c4bc10c6b1f3d3f417b2cb2314d39144cf483ad175825de41384ba5c7948bb4dd711a9ce1d95c2dea93bd5969619553ca6332b751dcb9b48a9f742b1c2a2f113e4a5db04ccc3dca997e610e4ea86d6a9555a2e3b04c45b44b704e38168a90d7d9504f497f1140420b76e88991196cab088966f596e9d163dd40aa6e2127d9fe2afb81da3db49f257d5c24c13e879e99b5b22ecac2375365d91e6c2eb22e9a6ba4e398025d58ea599c14d6db4c5f36e12817174dc369db0d3b5a3b2e098ed5baa6b1ee71eb61e8112d9e548076d124cc1dca829c98ca4a765be8a1c0db39a553b685cb9e24ad9d8f5c3de41d44ee22245ecdc3ae152aa5c053b8791fb2d85b6f823a8738ac8cbea9322e8b6a76526ee49919d55357d378b37756218a7db8e614053dcb91d14cb95148ccae5bbf45aef502ae7bd517a2902c0579082e5d897fc43bd5779c0ff00e0e3bf641ed03d6cbb85d925f39569fbdf70bb4b75e91e6b0e50bb4be7b70ee222ed2d370cc56639eb05c7d3e695917617464a388e25077a36566168e56f558ea092de129d71351713ce4534409857f036ce4e36eaabd6e6bac56028da24b3eabcedcf92974acf1152eba2cd180a5c1f4e19a866661158d994870b2cf3e0b15202eda570f0ad5697398acb2e8fc208fb5c5ef2c8ca3955ab602ad94982e1eb1bfbc3fbd6338cf0fe7d2895bbc66fff00c4eeba3ff0cf16f64ae34ef3e1985bff0090dbe6afd4b77ac2ec92b6d35fcab3c6e66d7aee615223b402d0ea5cba1639ee0d68b95db6ba68e26b9d21ca0752ac3b5d51169922b962b50aa623d776917b69b504f910896555969757e19c04d2b39d28f19fa05c1b8c3897dbe410c27f4d87e67babfecc55adca483db7a40376ccb1e6dc2eb0794bb3d98aab4a4e1092bcd11d19b9771873e1072f64b84bda57d2c4637671f1590cc1c2ca82eba8637d393cc13644d965212b4bbc285b12cd9240725c5d4d3af2ec41249a4d17805486c2e70439baa3a76651d34caafd448853cd70729105378b54d111384223a88847da5b94e00b12d2ac0e9659687d6b732c636325b167e5c3f5825ecad8369ddeb6de5114b885e6f417f9a6b1cf0c2d60ea7eca2279c513bd133a698152c95430b72b53cc02bc747db75334921b6e7a488ae7a5aed376a725aed27e9b7c9154f9505e9c8e54cd453473465920b829ea7ac969e61244e208ebfb2fb1367aaec4ecb35332ee0b8cba37090fbc311e12847c51847c8a457cc7f93eeda9494e8c8ba5fa24f39688c74b33a594487945cb4463e8bb747e35f4eae6189509a498b3a1d41f25d9f07c49b5d007ff0030d1c3cff05757979794056c9050847cab29daee8564e6a61c9861c29427331b60308b51723e570423a631f4c21e25abc17548a6ab929dd9a27652a156d04356cc92b6e3e47e6be45e9136127a90573838d28456b7321a6045a5b747e0ca3e8dfe28aaab446bed7a9c83532cb8c3ed8bacba24d9b670b8484a1bb747f8f957cbbb79b1e74c9b2962cec95ce4a3bf28cdda0bf5c1e48fc7e28fa56df03c64d51e5c9a3c6de7fdd738e24c0850344b102587437dc1e9f05488c53a08d725450f01b5696cb1e240e1a2e8452e02b9088af4608d20a93680665871873972f7966334d930f1365c24aff2ce9090928fdbfa5e2b6332d8e61d4aaeae3c8ecc15f61f387b796e5599799528c4c655576dc52b4f7d1452a7aa29f4ba9a8b8972ef5a48389a501a961cabf97a2b1ecf4ee1bdd92ca4ac13822fb2f4a39e6de1211ec97097d44a992c4a5db9ccc3eaa32c0ed1447bdcc3986e3558f6d1c91b0eb8d1e526cadfeafafcaa25b5a7f4b94db9b6e684730f52f7ff00197ee598414775dba15b9c3aa454401e3e3ea8b6a29f18a15a24f8c535992de114dc512d45023144b3145994591a8f044cb21e51b23211112222d223988bd953b332d2d22de2541ceb3864d921278bfbd2f2303fe6a2d455470b733cd9221a396a1d92317fb04aa449b8e965ca2399c708ad6db1e6222f10a12abb57292970cb08ce4c0fc3383fa3897ea9ae2ef178be655bda7daf726c709b1197951d32ede92ed385e570be78aabbae2c9d76352cde18fc0dfa9f8ad7e1dc3d0c1e293c6efa0f40a56bbb473736573ef117d91ec88f9047e6828983a8775d4db66a98eab421b646ca4d934f36e8ea65c69d1ff088497de321541999766640ae179917c4bbc377fd97c0908afa87f258da6f09a5148b8573d4d2b6d2d452cf911345dd815c3fb156e231668ee3a2b7c2260d90b4f5fb85b2b304f14130c42e44c153b5ab40f76a904092504fee5eb53a1324a1dc6fb2a26669ba86dca5c3daecab0c5a4db8ca04220e54e8d10448b86ee1b7abbb9bb3bd4354366b13109d11eb32910eacba7d55a13b2a85724aee1121ed220db23bdf758e54365735a2d8e9d5876f74ae1828c73609f2eac6e7395e22ca397cd97d3e48456e45491eca7bf3765b4bdd46d2e088e55f38c7a3575c2271f7304748b6d95c4423c245c3feaa4e9dd1f0965bb0484b29383c36f08f12dcce92de5b874e9feafe29e0a60f0db770e5b928b9c5100d599d3f63986c733224e0da242223abf9a3f1a9ca3ecb885b896966b85bb7cd9768b8b77c7da5756a9823da2e2738893acc908f0a46a774ab81b28c9691b444446d11474bcba330b2ae8368ec115d32db69c214ec057a2da085d474cc153ba4fdb7628d244fba42530e090c9cbdd99e74b495be5c3879625d945f4b1b7b274496c57cb1261c1fd164c4bac982ed72b30f49457c77b555e99a94db93938e623ce691f8365ae161a1e16e1fb62a55352190e676df750ab2bc4632b3defb28d9f9b71f79c7dd2c479e709d788b888b37fda104c4609c8c124f2f7bf1995d2ceaf4048bd54989af17e0b992c1041785d24b07dc48888a55f6a08297a3ed04e4b15cd3d6f30dd94bbc25e221f9959a5ab1273dfda5bf0198ff0088971ba5dc2e6758f28faaa8cde6e2d2bde1c23947317653f4f552c0eccc3651e6a68e61678babcd4765a6407102d9a67e5254b16def08e61fae0a0e104251ea136d95c0f38df2e192b9caed20ba36ce4ab3305f28422d3dff0035bdd12fa62b474dc4400b4adf88fc2a49f033ff00a67e05551c8a5ca0e65682a6d2a67cd4f148bdf233438ac9775f6bc63f5c1261b193839805b9a1e69779a76ef5463bff00c96869717a79859af17ec743f555951413c2dd5bf11aa0a5d6bfd0b6cd808954a64728e59512e221d4efd5e482a0ecceccbeeccb6d3acb8d8ea708848727adf1f916bd57a80b4d8b0df562d88888f28a75f79bc2dd8ee7c964eb2a8417feae88aafd6ae271d2d2df0f312a0cfd408848aecc5eea7f68a7bab16c7bc4ab13333e8f5949635b18b054ed0e79b9dd3b07179e77f954778421de9ad48dd3290da724a366a6946cc4e202626b527a9124734e88434f19728ff3454474c49b05651d2868bb95836128be14f62b9fd9dbe6f842e5eefc7fb15baad39795a3a4728a7a0032d2c2d065caa2a2a552c3ae72ab310a9cde01b755e892e44852493242a75d5535a13917d2776fd49884092a2dc4915d3c1a02e9b2280742dfc7e3e8dd05a37455d19cc55baf74898a7091062eeeb268877898cb5de2c38461ba2e47c5bf7c21bed2b770d99e8ba9724f36f36c45c799ccd9bd1c4b0fe5061186ebe1e88fa3cb0f445505763b4f012c1e270e83bf62569b0de1caba801f6cad3d4e9a7701567a03e8e4a4806a13adc0675d6ed976487349b070cdbeed33270d5e91865f49416c305cdcbd0582aaa97d448647ee7e83b05d3a868a3a488451ec3e64f7294bcbcbca3a9892a1b6b768e5a9d2c531347680f88407338eb91d0d32defce71dde4f243746318c2108c509b7fb58c52a4ca69edee15d84c32394df983bb0d90bbc43a4a3128f920318f8fc8be65da6afcc545f2999a72e723941b1bb065dbf93644b4c3e32f297962aef08c1dd5aecc7460dcf7f20b33c41c42cc3db9183348761d07994ae9076d26aa8fe23e586c097512825736d0f0939e4c6763e928c3e68420a0997ad4d3c29918ae87040c81a18c1603a2e57513bea5c6490dc9dc9562937917d20cbf84d285ce26543c93b954fb457c94d37ccd924d63333337506e9ac324315406f47e8b1c9699b54ac8bd777555c6ec4b38aeb55de8721688dc8dce0d175a3a9a7e8374533a525c247980a185bb8947e6dd57be96c129a2caa476683166d91ed211c6d58fa3294ba6f13e4c543c4aa4454b23fb34a9982d03a6ad899ddc3e57b95a7cd08b7eaaad4cb44fbd77c1b7a7b45cca5a705c2cce17aa88956c6d5c364249baf4dc2035b6510fcc8b42a9b58987e79cc36c49b9712cc5f29d9eefceafb51966cb2af1d305b1ca29b09e72a57e65c36d44bf322d15ba88b48fdeeea99da4acb82580d3788e17b23de50218728246ff5930e7e2d1e56e0a45353c951208e31771d8051aaeaa2a589d2cae0c68d493fe7d174e6313e0d5e3642a06d88895b86b370a99115d957676aeeb836dd68f656c60e07a925a5ce03bdb5b2c0547f12a89a1c18c2fed7d2febe4b47e942b9264c36d3199c2d45cab2f9998439ba809a995d2f0ea314d088812eb753bae3b8854babea5d31686dfa0d826e6a6f32baececd5cc8acc27de573d8798b9b4fd4b3c2ac68e1c8adb75c9cb138c3768ddc4921cca05d31542eeb044b30b46e2404f4d5d9572766501bd3b133a9543884a078027af5aef4533d96d58eef57fe8aa6ed704540c662cf0153385a7e556b7cd6da480ad1f50e7751c3a4503596ee64bbab9dc5ef8f55db67d633e8be74da52fd25c514ec54d6d6cbdb325de5073b1b46e5d5698831b7d179fab58454b81ee5073531c2a1abf3796d15c8cddc456a839e982c453628f31569454be305dd35f8a0dc527b3e56b8a34c919493b492aa87e9bbd0ab83bfc5050253f4a688814082b86cb0dc2a554e8c512b0f85768cf9095aad4c37710f6885465228f88ff006455ae992c253223c224a9a578683e8a8ea1a247b32f5202daf606530e507baace0da13671911976fbaa44cd72eaa76695c4f75dda81819031a3a00b39e97605836ac3622b75e96dcea561918adc70ff00fc3fc5726e36bfb6fc122305e6892b727596d5e9d964e0759e112d453904a660b8fc5442b5303f358a0eaa56b64b2b9b7bae2ef2be6d8cf61cb92cc9b76eccac695ba5d5abfc414b4bbbe34734f6650ac1a329ee5ce254aaba58b753afb968a452e749979b31e12cddde2414e4c294629e42d0916a707dd51a68c4a0c6762083f14c4129a6736506c5a411ea0dd5f6667c487104bb43dd2557abd4c88b29209b336dbb6e4214332a2c178663a125efd5d7d0f9745a3e23e309b15b35be065b51dcf55ed5e345b50ca86822dbd2b5ac0b132141efccac3b2f3e4db8abe704ec8bb692664666164eb5d6d569b56a14a4e08ba4582f17c20e612fef07f7c154ea3b1b36de811981e664b37fcb2dc5fea9d8550b0329661424aed338df12ab14cfb6854ce7107450b392ae3795c6dc6cbf58243f6931bd5e1adb1b86d3b5c1e52cdf6908fb74f99f83c122e26728fb3e44d3a278dc29715534ee1526609572b20af15ed9d71b1c468b19becea1ef0ff054da9c32a285d95cac1ae06c423fa256aea88f644895febcedce9176950fa20fff00a8ff00864adb3cfdce39de25614e7c6e3e8aa71e05c596e881998a6db4a7219921a8fa14a54c068a41b24d4caeb6b8e25744c016282dde912b4873097290e612fa897d63d0f6d9b756a7b66450f0b6202ccdb7c42e88f9cddc870cd08f93c7187a17ca510531b0bb41334c9b199962cda5c6cbcdcc33c4cb9cbf1c0bd11ddf42a2c670cf6b8bc3ef376fc7c56a301c5fd866bbbdc7687f3f05f66af2af6c5ed54b54e5c5e972f1f91d68bceb4e6ef36e0fa3d3ba3e48fa15877ae73246e8dc5af162370575986664cc0f8c820ec42eaf2f2f24a75262aabd24eca054e4c9af10cc37bde95763f06f0c32c0a3e5c32d250f8a3bfd1056bdebc970cae89e1ed3620dc262a29d93c6e8e4176b85885f16545c361c71a75b26de65c269e6cb536e0ea1eefa611f4a64664497d19d32746415408cccb5acd45b1b44b484d363f0331f3f29fa3c91f1793e5f9d9575975c69d6c997992c371b21b49b21e6fe2ba4e198b32b19ff0030dc76fecb90e2f803a864b7f29d8f7feea4e36ae4546b6714602b70ebaa3747953c24a4641c12126cb4928a8412da3b4913da1c2c51c6f2c7660a99b5d4a2967cbe4cb3097328d957f32d56a326dce3186e6ae12e52593d4654e59d2031cc2a8e46189cb534f2b67679a9d6def793988a3d97328a56366525b228862d54f53dc47b4ea80907d48cbbd954b8e455b3c3a95609b6066587182d2f376fadc25ed2c3a6d926dc202d424425eaadae9efe51542e93e8e43342eb4d910cc43488ddd60ead3f1f9526ac7873a9dc3d519267407676a3d47f9f45516c93c04a5a9bb155477cdc8cc5bcc43863ff0053729486c2bad669c9a93911fd63c24e7fca6f7c552cb88431fbcf1f7fb2dab686593dd6955b08ab16cfd05c74714c865e547ce4c3d947bad7a5c2f9a0b8ed4e95223d40954a63e59e1c29712ecb1bf797d7155aafed1ccce1093ae651ca2d8e56db1e51687c4aa2ab1d6816885cf73b2994f81b9c6f29b0ec375729edae9694126a9f94adb4a6887ae73ba5f063f30aa0d4677108888ae22e2251ee1a15d7166e699f33b33cdcad0414f1c2dcb18b04fb849b224d0c571349f4e82ec6dbb2a44229f1811651b5041370566e8d76adca454599c6ee7047ab9a647e1a58bce88f6a194a1dd55f802ec0511008b146d7169b8dd7df3b335262725999b9673125e61bc56cbb25c25ca50f2460a5600be37e857a4f7e86f136e094c52de2ba625f8992ff008996ed7a623e95f62d06a6c4ecbb73328f0cc4bbc224db8dfd92e528792308aa79e98b0dc6cb414f58241e7d53c03d94a114f882eda98caa4e6486c12ed4ec012e028c04d97214994c130a4b0d21c6d02d46244058bb1045c5a5ec345952b3a0a2096db68a802e4010ca8674c134971693f6af5a8f2a4e6431b6936226d489b7db6db271d705b6c46e271c21111ef112196e8f3d93240b36e99ba5694a1b7840233552707a99512f37caecc90f9b1ecf962a9fd2f74f6db7749d0c85e734bd5021eadbe1219612f3a5daf2417cdf34e38e38e3aeb84f3ce15ce3ce15ce385cc444a6c347d5ff00255d535f6f0b3e69cda1ac4ccf4db93938f13d34f16622d2d8f0b4d0fc1370f4420a3e304fc457a0dab11a2a826e983cbf752079b9bf16a2630b7371260f523410c69318a78dbed268db2410498ba9a3985c382534da082488116a5212ad08a434296e920822ce68474ea433b3a45c48328ae6e4104441f45ca54dd6f303c43dd2251d04b8451591aba50ba47a9cb175538e774b3097784b7c0beb56695e969f2fed92b2f31cce5b80e7b4c6e87f92ca0492db8f3291155cd11f03c8f8a873e1f4d3fbf1b4fa80b6386d8d2a6757854ab85c59665b1ff42b529ca6e2e6969a95981ecbc2c39eb36f6e8fecdeb21c6b74ae4268b9959458ed537720fa8fc2aa9786a89deeb4b3d0fe56a1394a9b6f54bbddeb6e1f68542d45c21d4243de1b554e4ebd36d15ad4c3cdf75c2fbb156693dba9c11b5d70669bf939a6c5f1f68a1bff00cd4a1c40e3ef37e45443c30c06ed77cc26a425cdf72c87adca23cc4b57d92a484bb575beb7111732a4ecd6d3c8b8422e4a8c89385e705c2c1f587744872dd08421e285de85a24f4c0e0893769365f0824243ed0ef82bdc32b609f407c477077f82cce3545534dab9be01b11a8bf9f640cfbd79262092669224b4c0002cb16e25c6e52e26b911b9722e8a41ce88a048441a7a04734c0daad1d1f6c895527458cc2c3622e4dbc3a9b60aeb5912f20bae1090c3e21132dd1dcaa34683f34fb4cb0d93cfbc586cb23c45cc5cad8c2e2228f88446318c7c4beaee8e765429724db102bde3eb265ef95982d51ec843740461e81187a6318aa2c731514d0e461f1bfe9e7f85a2e1cc09f59501f27fb6cd4f99edf9f256091956d96db69b116db6801a6c0728836d888888c3961080c112bcbab9c137d4aec2d6802c179797979046b8b918ee86f5e5947e503b750919529160a3e193ad90910c7fb34a16f171e2fd616600843c7e52df0b53f4d4cfa89046cdcff97512b6b194b0ba57ec3ea7a00b1de9876b4aa75271c816f96962725a506ecb6895af4c43e77223e5f2da210f4283942caa31b0dc223c28f978aeab494ed8182366c059712c42a1d50f323cdc9374b9a8204918e12049482a2443446491ab2ecc46e270799b2554973561d9a3b5d1ed244a33464792369c9335de6165ec49db3f31770b85f695ae4dc51d5c0c39d98fef1152c5955739f99a3d02d6bdd99c51c6e2549a088d1b291ca901477a7de8ab66c34c8b0cbcef16954b78d5b64404650479b32ce714d488a8cb7fac80b55c174a66c403ba3013f8560a45409db88b8919273aa2699d5b6974f8dc4b9515dcac2f75392f1b89484c1e542c9b29d38e64947b955aa94984b0bd32e0e511bbbdca3f5ac7ea1384ebc4e16a22f67b22b65e9684869dde2ccb0e8c7c6ba870461ec640ea823c4f361e4d1f95c77f8878a492548a507c0c1723bb8a95972cabaec50d28696f9adfae6192e87987144ccbc8a9b71454c1a53429b4f121675c56be8de6b35aa953a6a5761e72c7bbc84c2ed570d659970b6771de15d30ca87933ca29f372e555655350eb1ba01e6d350146b8868c14961d165aadd775d2210576e8ac3f481ef2a5462ae7d17396bfeb28789ffc3bbd14fc03fe363f55bf34de514ccecbdc24bd2cfe5145c2372e69d577bfe55f3df48f256cc1779673b57896e18712d93a5863afcaa8d392036dd6ae91874b7a765d711c4a36c788c8e22e01d3d55269d4cc36488b52a84f79c25a5551bb592599ce473177968290dee9ea02e75deeea988c511225990f1827257525567fb4ef42acda2e4248ab9ec645531b82b5ecc39984451d51f026a48b3b485a351d8e5e2560a348daf377732e52191618122d4429ba3bc4fcd88f0dcb312cb98388dadbaae640d8e4603ef122c16eb4c2ea46de549334997cadb623cabcb9e486ee2bb4c0dcb1807b059bf4cb396b76ac7455efa5f9fc498c3e5545182e878343cba66f9eab89715d4f3ab9d6e9a25413cd1262314a08ab572cf423c48d83a9b71d421ba982984c16ad152bfa2acf48659550d83575e901eead505b35614fa3169226dd8a4d9711d4d3d44a1a06a4e563682276e98999a22e2ee657ad9e9f099645a2b45e646d1ed0f0facb3c69103304d909015a43a53198b4e60aba7a6120caaf33ac6651cf411f46ab0cd8d8795efb491312242457298d903c2a6e5ba236720608c6872a1a219918d694b604890e8817f5248c7c69d9af2a62290edd3cdd422a5e66dcaa2678f3221c8a0e71469342a54564d94c122a56609464208b6e36a69a6e754fbc5868ac34dad90ead2b9b47456e6db2765ad17adb89be173bbda55f8453d295126cb2926e5881d5390c85a50dd17c70ea7696522121f594d4e3f6ccb83da24dc8404a7e5e6c3295d6bc3cd76973f74535b530b275eef5c9a8de5af27d13d5c04a1a7c8a9073e343c23997655cb9b4828e65637d2ea8836d70a41b8a54609a6229e8c538a2bb748215e015e722b8dc5043a2b06cdd6df92745f97730dd1f65c1f93707c843f8f12fa0fa33e9058aa0c5b2b599d6c6e7588c750fcb33ccdfcde587a7e35f3011aed3aa4fcb3acccb0e61cc3242e365dae212e66c87c5182a6c5b0a8ead97b59e363fb1eeafb01c6a6c3e4def193ab7f71d97db0b8ab5d1e6d53555916e69aca5a1e6b7e665e1f38d97a7e787c708c1595735923746e2c70b11a15d8a19992b03d86e08b8294bcbcbc929d5c59674e5d1e0cfb5e192adff00f91971d2397c2981d4c9f31c3ca31f2fa3c7be0b535edc9fa5a87d3c82461d47d7c8a895b471d5446290687e9e617c3a2cfe0b55c3a84b94a1e48a77056afd3eec2f8338553956cbc15e2be75b1f8178bff3223c205c5f147c6b1ff0cdcba75056c7531091bf1f23d971ac4b0e9a92731bba6c7b8e8427b7aec493519b15dc6153ae157653d423a9d324249adb6a10cdb38ad8f5cd8ddde1e542b6fe65334b9e51e7883c2974f33a270216540568da5c2950715df69b640dd7b1581116cb3384442d36df6888bc42abb38e5224fcfcc393ce0fc1ca8e13377293ee78cbe984167aa6be2a6395c75edd56c28b0f96ada1ec6e87a9d021655d5354a947dcb6c65c2ee897f050135d2038dff639595936f9adc77bd675edff00e5b944cf6dc549d1b4a79eee89618fb23b9561e24cbee37e655b0e130eff0071ff0021fbad46626a529ad894e9623c59864d921bbfc72dfd57d1e5552da2e97270b2cb4bcbc9b63a70c449cff9ae712cfce75c2d457735dfcc9a7736654d578a54541f13b4ec340af68705a5a4d58c19bfa8ea7e7d14bcced54dbfae6a61cff10bf8a8b7ddbb5128a762425952f7dc375c3f794056b74538e88e9439bd72e0268e08905d234c9274a3972a62c4104e045757012a028209d6ede24531ddf6904d4112d399bf16a0822e2d2e5894db8bbbbd9448246e56ae8e36f6a14498c5937ae65c2ba624dccd2ef7787e09ced0aabee5e140ebba00906e17dbfd1a74994dadb6380f0cbce5b73922f108bc25c587e87c7e28c15e2c5f9d42e5a426d9136e095cdb8d910b825cc243e315a9ec5f4fb5c91b5b7c99aa4b8e5b66b2cc5bd9996fc65eb6f50a4a40756ab18abb4b3fe6bec30825c20b1ad92fca328d3368ce0cc52defd70e3cbfaafb7e3b7e982d3685b5b4b9c1ba52a52331d9198684bd928c22a2ba17b770a50a863b62a6f72e4609d068bbdddcdf65708516428f384cc457a209cb52a0d172924e44bcd64c4017a0286aa55652586e999a95971fd74c34d7da8ef59fed374edb3b2794670a79cf93916c9dff00a85b852db138ec121d3346e569301499a75b6db271d70596c73138e10b6223de2dd05f34ed37e53532e5c34da6b72e3c2f4e162b9dec26f743ea8ac7b6b36b6a55472e9e9e7a63f5375b2e3dd6072a7db4a7aa8efab68f757d3fb79d3d5224448250bf3a4d0e5c397cb2e25fad992f15bdddebe71e91fa46aa56cbf4b785b97f839197b9a971fef7d2f97ce5fb154845761052e385acd9439277bf74d8af5a9d84172104ea8e522105c8f7574c937124104834d9c12892091a09045ddfc7e3c884280a2700897499111b904109014fb2df32e80f127860820b96a6dc14f4229874bb282098214a80a503445fcc94e4104135bd7a114a5d802082e42097bfd94918257e34a082438496cc50e65715a8888da2820932f9893f175352b0ca44b8104112341c53fb2fb4cfc9975657365e7192ccdb83dde12f9e1e3558b9284d1b5c5a6e125ec0e1623305b7d06b12d3c3d5161cc714ab85ff00b45c5f4228e16dc25a96212ef90909095a43a4856a7b19b60dcddb2d3c58731a599ce6e5199ff4bbcb05b0c23884dc45507d1df9581c77855b633528f56fe11ee8a72954b7a69f665e5db2766260ac65b1e2e22222e16c61988a3e28406318a32725b0c884874f2e6baed2236eadfe8dde5b97d21d086c17e6d97f099801fce136037f8bfb2b1a86484bcb0dde538c3c513843cb68c55de2d88b2962cc352ef7477f3f40b3b82618fae9f21bb5adf78f6f2f546f44dd1db14762f8dafcfba2307e66de1f11783cbeff001b72f02f1fc65186f8f906037e5e5e5ce6699f2bcbde6e4aeb54d4d1d3c6238c5805d5e5e5e4da7d25760bcb1ee98ba4f8cb3854f9021f0887f6a99d432f779196e10d5311878e31f2043e38c7c52692924a9904718d7e80772a0e21884545119653a741d49ec158fa4de90daa68134c88cc4f90e46aeeadabb4393443e311f4c06198be6df743e62abccbb32fb8fbee13cf3c588f385a9c2ff41180f8a030f1088c210ddb91d313247714488888ae71c22b89c22d44445e322f9e28035d1b0ec222a2669e271dddf8ec1723c571e9b1092eef0b46cdedebdca1c5a44b6bd04adcad42a573ae90ea0ca39914f450611cc89c9c88689f675293a24cfe92c8f69458c6d1b97b651cbe75b4d4afb36c9f862cefbf651fb4ff00dbdeef2589262ae7893b305fac24a89aac07c216800d53b03526d165508d1e6527071184cc8548522531e604787512b78b37b99748e550bb0ecdd88e72ab953a51735e2eaa32548886cc1f52bae7015108a90cc7790fd06c87742d1b4789174c974f8cbdc4a4025ed593b2dfdf444b1a52e5e5ee2b936ca97a6b6816dd107d82cffa7276d9465bed5c4b0f7496e5f9420dacb3eaac29d5d93859a1b40c03cd704e2e797e26f27c9132ee271e7102d9a7e04b4e166837541cc928c98352734a1e6a29d0a6c0d414d9a2f648baf1ef28e988a7f679db5e1ef2126cad32fe995b6cbbb9452fc21414b4ee5144b2faafc8b335926b652f8893bd0ed9a76114a6aced485d2829dd8899c3981ef2828f91134976d7853750ccf196f925e1f318a76bfb15f49d2dcb9b12522c9aadec64c62303dd56008ae613b3248479af415249cc89aeee1669d23c3aeb9559e604855c3a4f6389522993370da4b6986bf353823a2e598db032b5cd775552db1eadb215974d6a5a974860443d95964d4732d4e1efcccba11c423600988c53d2ba85309e968e64f561fd377a14f33de0902ae5d1bcb623e245a4552f7abf746b1b50aaff0068a46a355a3d666ed1eea90e8aa5b166710b99556b4ead1fa1896ca44b2f88bb954ae23aaafc1d86a714683b34dd6a5143ce15ad917653a4481ad1f50e775606317701e6bb24cecac27c9601b70fdf36e2838a3b68cae9973bc805d4a99b96268f20bcf788bf3d43c9ee572315db922290f1a78a6a9dbadd3138f28a766f327675d50b30ea5b5b756b4c0deea276de6eeb45559b252bb50ee650cdc5491668b2d8d337f4c22d98dc4a522e70a8b938712240d36e3a26e66dd483314b8a65b8a705304282e1aa92902b732ba506b625d53fc5a5c54795478b889de4a0cb1876ead957a7936e5da84b30920c52b66eb17fe8ce95c25e64b94b97bb1f22f4db64d910a97049986bbaa99e3caeb20a6629ab53b6af25908da6c2c86720817d1cf4504f4147914a893220bb05edeb9bd32a4a59450a49e38a68921c52982ca43676670e61bbb9854b748b2d6bf78e9211255669cb4c4bb42b43daf605c94973fd5a8e35932f71f64a9eec635fd8d8fc553e9130a51f0b8556db8da4ac324f5c2a553bee329506aa3ca7384e4b1e5456f40b1c48802525a7450646eabb18a5b71484a04b48294e450cec53ae4531bd24a5302be741db465235669bbad979eb58784b4e2fc0383ca50f27cebeaaf897c39233d8130cbbf22f34ff00b0424bed7a34f04c4bb2fb65026dd6c1c128792224302deb09c4f4e1b236403deb83ea174be0eaa73a37c2e3eed88f43bfec8e5e5e5e5975b65e5e5e5e41043cc322e0901889010909090dc2425e221212d508fc4be5de9b7a352a63de112a2454e78bbde08e17c197a7063c25e8f22faa10d51936df69c69d0171a70480db285c24250dc425053f0fc41f492661b1dc771f95558b616cad8b29d1c3dd3d8fe17c2a304f8b0aefd30f476e519fc56a04e539d2ea9cd44c197fe5de2f8b94a3e5f22a241d25d1a96aa39981ec3705728aba4969e431bc5884f08a79d9a6981c57dcc36f9b88bb223e52511b47b42dc88db68bd384370b65a591e127479be68acc6b9587e65cc475c22e51e11ee8f08acfe29c42d8ef141a9ea7a0f4eeb4f8370b3a5b4d53a3770dea7d7b0565db6db97678b09bb99936cbab66ef39fad7edd45fe8aa73657216f4b83970ac53dc5c4b9c6e57438e36b1a1ad160360121a7edca49c72d4dc5ab931bc9bed0f2924a5a7a314eb6e5a9b69f12fe54ac2411a4be28464f0cb4dc8f1cc3dd41be08208e0212e55c397eca0e59d214736f5c39850410c4c90f0a1dc121e15270710536820998412c2090dc538304105d88a500254209d6d0412872a79a71356fe38570604890464079732e6e4db4e10a782d4104924adcb9b8bbcbb014105e84120191e11b4bb397ecee4e8af6e4105274bda3a84b7f66a94f4bf64669cb7d928c559e53a64da5686d1ac3c5fdf32d39ef141519791100a58715a23bd386d390dbf9daded0cab172ae55f6eeb737e7eb550707945ec01f65bdcabcbc8b284798f7497c310ae709c78b99e71c74bfea462ba036e9ca94bdb92912e45760bcbb082082f417372ec12226820949b28a4c4922314124af19242e1126e248224a28ae8c5260bb0468255d6a0e2579254d9e91f692da1b50412b72ec20bdb978a36f7904124cd3430bb527060971888a082f44850a514e3a7ca92d8a082eb3dd4e1413908f28da90d8775041270d2664ad1ed2243bca3e69c222fb28209720df1222761a453b2cd5a3dd48b2e24104dba16888a436de5b910fc33243d0e14104c112ec22bb06f992881041704912d3a82dfc2886dbcb720896e3f93ef48926cd424c6ae388db3fd9660b30cbbe595b79f1e211cdba3c31dc50f242dfb825de17044c084db318109095c24250de24243e2218fc6bf2d01e1e15f567e46bd271391fcc73657653769e44575b6e67653c7c36dc630f45a50f8a09c7ccf7d8389361617e81351c11c772c005cdcdba9eebea65e5e5e494e2f2f2f2f462820a85d31edb429323bc334ecd5cdca0f8ad1218431261cbbe0db12847778f7c6230dde3df0f9684c8ae8911138444e11115c4e38e15c4e3845e322222df18c7c6adbd35d58a66b93712d32d6c9b6375d68878cade5b8ee2fafe654e6d747c0a81b4f0077f33c024fd87c3eeb91711e24eaba82dfe561200fdfe2896e2b8eaf3515c357cb31d575b8a737a62097124102136fc50ac8dc953249ddf68a6ceea40d1a83aabd68da8ae8f86e9922e56cc940d41eb895b763d8c2969a74be4ed50277df31ec0ab2859903475242ab19dcf3c5cce17da5e75c4283998bbc492fbca30dacad0e9aa225dccca4a2f283942cc8f81a75a14096f75a1746ce5c2e0ad0a4e036ac7f616a386f10f32d4a8d3425a8972fe2ba72cabcfd085d9f816a5afa011f5612a7e5a5d12f8655d94889254d4566eda2d966518d16653f4e35599b8db994bd01db922faa72d70a93f9469daccb8f32c19d35adfe52154172759607e05bcdde258f192ed3c3b19650b2fd45fe6b82710bc49884847436f92704d3c2e212114e422b400aa5ca95324a1a6a2a4665c5153514eb4e8a640d40bf148912b4d75e4db3a9192ad00f0ad0299319454c4abcaab497b2a9b927530f16591ac8752acd2ee22409454bb88e60d33b15493b6e11b05d6a3987bc92da54129ca1b3472dd3a337ae6055c862a83d16bbd4abdef5cc7136daa1deabbe604fcd46c3e4ab3d21cbdcc112c5987ad7887b4b7adaa6ee60bbabe7fa8c2d7cbbcb49c3cfcd1b9a56178da2e5cec902eeda42e6089637331cc4b5adae77a8592cd4332d7d0101a4289078a30e4cc53b29a8531bd1b496ee713b55fedbbd0a7c1b143370576d8876d254b961b95a7669cc321547c458a7b346d0377b80f44fc5097b5c7b05769e3b896cbd13b56cbac52057447b4b78e8ddbb650555e3b25a91a3bd943e0d8f3573dc7a5d5aa31517b50e5b2ce77549a82db63b659ceeac8528bcad1e6ba8573b2c0f3e45601553b9e73bc8428a7674f397790c64ba9462cd0bcf73f8a471f32ba51434d9a7224a3a75d4b0354fc4c205828fa93ca11e75153eea879f7ed028a7e31d5682921d00503597ae34242292477477a54bc332371bad4b5995b6ec8e18da29c97431122a5a09b7151a4d023db8a79a821db45309bbaaf7846b79521d984c3afa180ae24879b26f9775272ce15d72beb6f0cdb22e8f9e1caf0f6b9beb5406236a7e9f5471872f02ef0f30a26bcb0dd439e9f982cad316f5211e85a8c6e741f1bc3d61e541ce9655619c39b70aa031cd7657208c90af1274e2872828cf2a7c613715d5d24d9453253e355d8a6c97524c924a580987169aedc54a66f1b4adb955f61e89e12f5e43d5b79bd95a0d7404a43b425eea8b1ddd3070d8684faa2ac958d88c64ea6c47c0ac9e6c3327251eb5393ed46e433704f1f0b9360873149b2ea2c0944b668969e52592289244a4b7a71b8a0c1c4ec0d4805447313866998c5748934ec511294d6a6ca3996e7f93c6dd41980d2e69c11122dd20e17c65aa508bc976ff0018fc7bf77c4b0e68514d7e3f1c250f8d40ada1655c46377c0f63dd59d0622fa29848ce9b8ee3b2fb917962bd12f4a908c1b93a8b9b8f2b6c4d9697395b982e173b5e48fa56d031dfe35cdeb6865a5932483d0f423b85d6b0dc4e1ad8b9911f51d41ec52d79797944560bcbcbcbc820a3eb54d6a6d8765df6c5d65e026dc02f189097eff4c3e25f12f4a932c512766a5259c19c79b7085970b360b7c389e827a19877f9236eff004afaefa5adac6e91499a9b22b485b26d9f9df31c9fb3cbf52fcecacd509f79e75c22271e708888b36a25221ac9a16398c7583f750e7c3e09e46c9236e59b28ca84e1b8e11b8444e38444445a888906668a9804244545535277a7a5f953714a6d0469c69c212b49186d5da93132d5cb94e7c872a082166e5ad4a947784ae529320a1df6ad2410460c2d2ec9243cdf0a6db73991476908920828d282265dd2e6b937341992198a082309e2e51f6524e0e7288a5b6e88f0a49b8e17650410c416f1092f310cc92e010a765e08209e8b64bc043c4bb697095aba44e728920827461ddf6926065c429a19921d428809912e124104c93bd925d17c7b5eca760f0a5620f3224175b7d3a0ea66e15e84450411305d8410dbd777a08221750d88bb075046885edc988ba4bd88482527d7b7a1f7af4628209fbd705343024a812082511da9a89a4c62bb1412495e845262bb08aea0892222b9869718a4c60820bd00e5493888e64b80a0669db8ad1d22820b92e376644422bc0168a5402e468248a4c4bb29e888f2ae8a24133034dbc3727c8d30e197aa8d04dc0514216f08a69a8712588dda90417a39b9adeca5880e9b57610f552823de4104dcd15a3de42c8b79aee54a9e3cc89926b28f690413a50b44479b317dd4a6c525bcd71737d914e9432a2410e45c4910873248c6e443608d04dda878c48b28fb49f8b589dd4fc60223ca23eea0821c444450ce3977dd14b763766f831d3da4c8a0827c22a67656bafd3e6e5e7258ad989579a7db2ed096668bb2437047b2e45418c13a314105fa85b235b6aa123273cc15cccdcbb4f8fcd88302218f6a05bc63dd52ebe7cfc8836931e8b312245d653e608879b026ee747ea818b90fae0be834a4949515b55586a464e626de8ee6e5db238fc65ca03f1911c4461f39411f32f0b6246642202246444568888f8e24445e2118421be318f9372f993a6ae903f3aba2cb170d3a5dcb9b2cc2536f0e5f0821e1647c760c7c71df128eecb085961987beae5000f08f78f97e4aa6c6b15650c04dfc67468f3efe81675393a6fbef3a7e71e709e73bce15dfe5e45e4397953c24ba646328b2e4121cc6e896d28d320496649f5188d5777a41924dc9971c4826c94d66abcf1e943d4a6f2a69d7502fc77a8d24b6d029d1420904a44b05c4b407a3854970b995269c39855eeb94f71fa608872dc23cca14fe184f991f75322f154b47604fd165a0e26dd35c8c087296a14cb84900e8ac0b75454a1a385c51727156bd90a3784b99bcd8a597868b94cbe2cceb27764a549c991e51cc45ca2ad72d59b663565b916e4cca36c94b4b5b89c45cc43f75541c97705c5ceb8adf2baa0676d801a79f72ba8f0388052b8c6fbb89d476eda2d928957b875296299cab29a0d4c9bca4ad92f5712594d96eb75333877655314e986e5259e9974ad65912748bbbc3de8f914152809c2ef2cfba78daec421a5b05d5cb95d3443f08ff00c9f747ed7d0ac708c39d5d50d8c6dbb8f60ab31ac51b414ce90efb34772a85b595b29c9b7e64be19c2211e51e11fa854244924a29adebb543188da1add9a2c1710793238bdc6e5c6e7d4a7e0497bd0c049e8453d74d16d932f928e988a3a65473f14eb4a990a15c4d4138714d452aea7b558690ee553d22e2a9d29d56195344ed42a3ad8b52ad12ae29060d414938a4d93518acd4f1eaa65934f28f97347012355ae6d8ad73a29732ad1f7acaba2b98e15aa409739c69b6a82bb7f0c3f351310d581b992eeaf9ef69c2d992ef2fa1e7bcd92c076e5bb664bbcacf86dfe370541c7515e26bbcd56b690ee656713f0ccb40ae42e154ca94b2918662e0e292404e8140a3a577b131d650d153b4162d1b943b4d5c622ae92f296b622b653b8729de85439dc5a40f350b4ca79708f78b85154a21172dd44afd5f061894c36c4472ea59bb5316e9e65c3f8bb189a6c41ac3a3584587ee56ca1a66369cdb5242bec81dc4df7857d09b1236cb37dd5f396cc9dce36be90d941fd19beead962937328e23dc2a3e10872d54aa66e554e92666d96256982cfba5c77a9b5546191e7a868f35afc765e5d14847658e3a598934e457629b38ae9cb845aee4dbc6a267cd48bd150f5024614f805dca1e70d572baf7a14f4ec5572a237127af66ad4d0345c151649e6e368a408665e38a6c395d1d53ed23d851cdc516c921d1469429166288892125e2baf3c907c214073355e3711526083971b94846368a680ea89e3a253ce266049b89258c124a6c846d3e722d38250f5879855a275bb845d0ccdb83ecff54152ca2a52815ac2eadccccb9abb3da14192e451a7a7e66a3745c5364a4a6247880ae12d24a3dd04fdee2e143d8d90ee24c209d8c120e29053a0a68e28738a7ce0867629a794fb16b5d1400fe6c982e2bad45bc7d4380a1ba139ab989c638b2baa46a196e42805c3879aa6c58964a0f92a3d5a19d4798296a88e72403809e91b7253f03bc210b08275b25d8b6bd014d8164f120a7da34fc1c43412a29d0484c168289838bb1428925dc961e90588904e4090c2e2589a58726cb51ed1ad63a20e948a59c6e467dcba54ad6d89a70b34b170b4f971311f142051d3bbc7974e42cc5333456f74b528d5d471d5445920f43d41ee14ac36b65a2984911d7a8e84762bee708f93d294b12fc9dfa40c601a54d1f5cc8fe84e11667e5821e64aef2bcd8fed187cd15b6c1731aca47d34a637f4fa8eebb1e1f5d1d5c225675dc763d975797920cad1df1f428ca6af933f2e1daabdf93a6816567af787f58430b3dd25f2f3d157be9cf687f39572a133775653042dff0074d15a3f65505c8a4a52489dba53b180b83eea1ca094397ac1cc3c42820951652377ba8b8732f4404b3710a17412dad372166dab7322e487290f297fb52cc38491209b9376e1b4bd54c4f369b20b6e1d3ca8a03c41bb98737791a0a35a8a325b3090a1b0ed2440c6d2ec9208244c0dc284520e4357b48128208225b3b575c7fb3eeae4be5ca43772a7625da41041c229d6223da4cb9a9152b04104ee5e24e06549b57a28904ec450ce0b7ca57730a744eded27a05720820af12e1f592847ba8c8da9042820868c3b2bb01ef27a305cdc8ee8246e5d182ec204bc8905e84176105cdebbb904129286d48dc9482309508aeee5c14a141297ad4c992538ea64504452a09422bc2295bd0495edc92515d4989a08252e422ba004bae108e6241043cf3b68f793124df126c624e123603c28d05c1827925b15e8c112091bfb2931f592ce29ade8d05c22ecae41be6cdf752a105d82082546036af4172104ade820bb04a8965bb95705727636b689051f08dc4a45e8da3ee8fac86906b327da8dce765bfb48d0453616a6a7a396de6cbfcc9f24cbd0cdddfb448904869b4a88dc5d915e6c6efe64e1908e54105eeca15ceb3fbb1d5da2fe54b77316189778b94797bcbcec2dca2820877737aa9a20455a997051a09a845381148825422820b73fc8bf68fc1768c6588ad6ea12eecb7f8cdf5ecffed943d65f6d55ea6d4ab26fbee0b4d370b8cce36c061be10f5a318ee84210df18c4a1086fdebf33b616b052353919c1d52b34c3fea8ba377ed1ba0be90e95b6d9fa9cdf13726cda5272f76ab87fb5bf6f889e2bbc50f200f8a1e528959e15879ac9725ec06a4f97979aa5c6f151410732d771d1a3a5fcfc8292e943a4476a912602e62404b2b3f09336e929adde2806ff001c1bf279231dfba16e74ec52dd343c62ba55352c74cc11c62c3fcd4ae435157355486595d727fcb0ec134f02e3296514dc1c4e1b5d205c8b27a115e2243138931710ce8f969d75d41b8694714c1265ee253ec60092469b88a5ee4eb6299b5d3f7b22a952d712d300ad96976d67b4586782bcb4e5d87d9524460b42aaaa9cb5fa1d7a2a374ab451967c5c1ca2f6654438ad53a777bfb1b7c586b29dca8d86d71e6b57092e68251949648dc111e25a84d5b23242d8e579e1f5844bef4541f47f4a169b29b7f48f9b1e62fe5821abd5127dd232e252616e7398ec36f33dd47ab932f806e77f4ec856a6484ee12ccae340a834f8dae6571528493ccb9b8b7895b6f1215b411564663945c7d479848a1c466a1944b01b11f223b10b506b67db2cc248ca65306ecb9954a87b4770e1385865cc5a4bf9495882ab80d911e511122bb9bba5c4b9b623c2d5103ff4bc4de96dd758c238e296a1b6a8fd3775bec7d0a8edbbdbbf01c49694fed16da4f7c8ddcbda58f5d7111166222b888b51116a5235a075d71c7487ce1117aaa25b8adfe0d874545086b4788db31ea4fe161b18c5e4c4662f73aed048681b009e701304089492157a153842460ba269c3043b91b52ac9d1aa6e61c51ef9221e341b914a054d85b64d12425457a1042ea584f494732b248928094694fc90a534f455b5a41537244a55a8a879382966932e599a81aa9195247b715172f147b44921554add5681d1a4d5ae08ad95a2ca2b08e8f0faf1ef2dd65f48ac2710b009aebabf05ca5d4b6ec529e8e52585748d0b5f2ef2dd5d8652587f49eddaf1124602fcb213e495c651e7a516eea815776ecb720a568e6f95bef0a54d10917694d6cb4ee1ea5cd1d884831973c1ddeac30d818da26876d954431b3584e621faa9f9b746e525599ec422255d71cb897a11998d292edf2fecb9dd6cc24a9f06d7d11b5b709c1cc5979557ce5846decab03a178a897a5f37f5665c678f30e753d5f386c56b303a9e643949d55a363333cdafa5e8036b0df757cd3b0d1fd21bf557d3343f323dd57a67e6d1444765238762e5d44bea8d59bf4b90ead693159cf4b9e6d3b847fc43559f127fc13fd163318a6e29e34d6e5d2971166e867d444ec14dcc0a899c8236a9d0e8e5013d05053cdab1cd8a8d8cbdc49521d82d0d2c9655f986ad1426e52b500b8900629175771c9709b18a218242c53cc452814a78d149625ab8dc2e242016f52b24d2649cc54478ca8961bb521f25d75c4c449139d651774b1825c2299bd2226a3b9e865ba75c34dee5e0825c629824947b292a3568d8ca599be5e55627220f8e2345de154472288a7cc9b4570125472b9a74d93535335e2fd558de6b7218a08995ab03a369e524dbc0a6891afd957e4730d9c857507311443c482789332152a26ab5743f3a4153111d2e364d10abc5772b843da59cec0b9061d6df2e17046e5a56d107597709664e5136ce27baa9c6887385ba1b2a6ce433121222a566073920e61ab54c737aa622934010b6ae445391498413564fdd2372f453911492822b200a6a305edebb18a4ef4da712a069626998af422940a22d4783a9a71d4c0c57772597929b0c00a224a68da36cdb709b71b2171b707536e0e61215f65f4735a727e992934e841b79c6fac118dc307072910c79636c630ef2f8c22d12fa4ff261afe353dc9232eb249cc90e6977ae30fa7716243f62ce711d3e7803edab4efe47fbad5f0a5564aae5df4783a7fcc365b12a874c35cf01a1d4a678865dc16fbee0d83fb2edff0052b7af9e3f2deda3c0a44bc88975938f5e43c580c66fb56c161cae92be349a72e222e222b8bd642b89d749351824a52f6e4b64adee924b629f18208249861e61f365a87952f7db9b84b8bb296c95b9572db72fc1969ec97fdd1209c80da570f17e053c70b86e41b3d5dc05c599b2ed72f7918d1a0821275bcb721a54ed2b7849493a3ef28c9a0b6d2e524104f4c0665d31cbdd4e3f0bb32e370ca8209a8c728fb2857c732202194bf1a5266608d0496846de5f593901e2f66ecc9211cba6e4e0c6ef382482085464b0e5e2493b74b636ddabb228914104c9177bbc9508fe3992ca295b912098b938005ccb8715cdc4820bb13ff725422b829518a082e44972315eb97a10410b2f45760a3e72aad0651eb0b9454fecd6c2d66a2378b63272e5f0d31d5ddda11d449c8a17c86cc04a8d53570d3b734af0c1dc9b7cbba02e1d3c5cb957372d1643a086eceb6a6f637332c8e1897ade3251552e85ea6d7f649c979a1e572e61cf7bc4a6bb0ba868be5f91055445c53873dd979807a8207cc854f4b14f54f672af29e7e9f3168f1363883deb9b5171a988eb126fb3c5eb5ca13e2730d9c08f5d15cc3550cc3346e0e1e441523080a4b869a62605c1b86eb7ba9118dc9b5297775c95b974528450492b9014e6eecae460bb7208936504e342290449708a08251128d9f7eeca8a9a76d1403217123082264dab46e4ec2172ec6294d8a082570a6ca29c8c520a089048dcbd182edab91146824c01777254057a0820b908a5420bd04a841120bc3043d463a4518dc1033599c4104f3195b22eca72941d5ddcc9a9cd223cc4228e085a282090649a20bb2fac45d94b08ea4a895bde24105e70edca3ab8534656f78b4ff325651cc5a925a1cd717fb4504175b1b47ed7689212cf32e120826c93450e64e926ce282087215e15c7497051a09e6d6d7419e17e9d26edd985bf0673bcde92fac6d8ac4c168fd124d5eccf4b170b2336df79a21176df55cdfeaab9c0ea79354dec7459fe24a4f68a377767887c3756e70d0a6e26c9d4d44d746748b93323b2748d22249adebd08a6f327836c9718ae8a48c12a104020570926d4e6e5d82164574dc012c052f72500a30d445c8ba6653575a1c2e26c7b4a9d20d5a42ae1b2be73ba9e7691955b380e95bea1517a6aa862d470c7ff002ed8b5eb286d92a26395ee6565bd45cdd91fdf152558a393f3b30e995ace21779c4e4cd42d6c5b6f2b63c22a962a771f7b41f7fecb50eab68686c7a9ea7b7f74557aa775ad3795b6f2888a84b6e48285c886c72a9ad1d14271ebd522009704a182ea7004d12b908a95a7561c6c6c2eb1b2d4db9987d5e55196a523b7749bf656906e5a646d12c12e57330faa4ab55dd92742e7046e1e61cc3eea2250d4d955bc1651c748b48dad8f3385a7f8faa9524776e6bec9b8a6747200d1b9b587e166e624394b50af5c90ecc1384445a8b312446290c26daabeb6abce920de4f391433914e829e60423f143c53efc50e94ac19b244209f65b4901464b349374247d822651a52d2c086956d49b2096d2a9aa25464a4149b22a3e4d4b30290e54739d538d22da8a1a1044b290140982b8f4703d78f796f12fa4560fd1c7f691ef2de25e1947bab11c47fee8f45d43823fe18faa51c162dd2f42d716d45158a74c5e7156504bcb2e71e8d2ad389199a9c0f30b267dcb4b30ddda44533317126601715b9ae52128cd8dac6f09e1dfea38b6723c2c25c7e7a2858ad47b3d1868dc80131527945626644548f328f81665e8699bfa0479158181bfa80f9ab1c89e542548ed2ca9e91d298a905c5fd56ac471ed0b66a22fb7baae7039b2cc077539b111fd25bf557d33448f523dd5f2d6c197e923de5f5250e3fa3b7dd584c2662fa2683d16df0d8832679eea4372ce7a5c1ead68d002540e95dbea55fe126d52d4ae216de89fe8b1328248c1391149182e92b8730d8a43e2a12a2a75d55fab451b159462e428971226c2c6d11261c483ad3a8e43aab78b7b2837c547cc411af1211d8268395cc3a20c85737a79c14961a4abe965301d11724d2918b88512b457204924d9449354f91a49452052f728ce24a66c0244229d6c1281b4f405232f74973d37b97372760097868ac91743589508276304d9223a04eb45c264d15295121ca59850e49a28a8c5c41b840b43858a9575e12f18a01e34193d6aec1fb92fda336850653e5d95ed9a7db24df35b712b06cb56f1d9f06772bcde56c8be10797bc85948f54df745053524376f1ca5c24adcc4459cce8b30256bf33241b927d149cf336ba2259579f62deea8aa856089bb5dd43a5c44d1eb40636b8597ec92509c5f540d290dd35ec579e97e5439029a999720ed096924238d27ec0ea1461216e85476e4931461329116920b13824080304cc454945848f064d98ca79b2840c057441480cb27018404488ce104db29e06d11185a9a78d399404de72e4eb24ae1d1b56ca9d50979af83f31303f1cb3a43717aa5697aaa8f2da94eb11cbf8d292f89b3b0b1fb3858a4f3df4f236461d5a411f05f65b4f090c08639486e847d1bbcbbff00cd7c23f957ed80d46b842d15d2f2a380d97684bac2fac96fb4ce90bc1b64ea44e97e914f972966f366217c70a50be3e280fa8be269e9827089c2cc45a9729aba6753cce8ddfca7fec7e2bb761d58daba764cdfe617f43d47cd0a44b8292714def5194f45412e0932c777793b622412a09e0cc369262104e0c504124dbbbab2f54bbbf7a0bb28e5d7096521d5dee6fad3ceb62e0dbfee12420916266f383abf58d730a0822e11f77eca1df0d43cc249f7f9925e86924104c4b46e6c7ba9c6935231ca43da2440410410850cdde5c2d229d988e64818ea468243170ff4a7ccc847eca4082f4637169b90417258446ecd7116a447aa4b810b50f393c2deabbd5144893a705d0828a3ae31da2f55742b5c8cbce7744beec12b29445c06ea52105eb10ac4679df1b54d992ff09cfe0a419d9fad3ba69533eb3711fb496d86476cd3f251df59033de7b47ab80fdd33ecaec14acb7475b447ff00936d9fef1c607f7a9097e886b85ae62519ef3d77fedc13cda19ddb34fc9457e3b40cde56ff00d40fd95526df16c6e22f57891bb29b2551ab96416e56478a626085b6fd5ba3bdc2f9a0ad0df41b3445d6d519f55b70bed6e52ec7424dda22ed5e648474b62dda3ea891ee1fd8a5c3864d7bbd9a7a80aaab38a28b21114a01ef95c6de83456ad86e8ee9b4fced8b739343a9e789a72dfeeda18c60daba91732a86c3f479274c3275a7261e7886dc479ce1e2eac7c5fb77ab717b4b4b4d1e465b28679037fad972ec4ea79f313cd74de645be005cd82e11aec62bc02bb18294ab57408bd5425428b28f8f5f272ef0f6991fb43ba28d8412ae4db9a08b14a64af61ccd394f71a159ded0f45322f89781b9e02e17c189624b917f7451de3f52c9f6bf63eab4cceecae332397c225fac6cbb456f8c7eb5f47d4241877ce3625da1b84bda6e308aaf4ed0084b7cb4fcfcaf671bc25bff0096ec23feaaaaab0b8e4d5adb1f23fb1d16c707e27a886cd924cc3b3813f270b9fa2f9ca46aad1ea2c32ed294182d0f6a3a2d7a6e3bfc224c9cf94f07f0470bbd8594bf62ac3fd15d55812c36c886ef83705cf777ef543361d3467dd247a5fecb7d49c4147381791a0f626df7b2848241451ef50671abb15979bb7e5192cdeb0c37215e9577561890f3090ddec978fc4a1b9ae6e874f556ec91b20bb1c08f237fb26c4174971c704755c3de12b7da434d3f96d1f752538869876e24530d5a287966ae2eca34e08d049841116a4302945144824124c6095b97231410498c57a115d182eee4105c8457b725412772082f6e4a8417b7258a082ee9cc809785c48b992ca932a0282093085cf7747ed7f4a2de24c48c3517317ba9e3d48209a74edb47511691ed272197317adfd29adf9aef547fa52a30bbbbf6904172038998b4f08fde4b32e14ad29059504126305c5e84125d3114105c8c50ee17b2bb0cd9b852a0ddc82086805d9976304498a66304682e422adbd133d6d55912d2f37332dff3d87047de2154fdea4a873980fcbba3f06f345ec90a7617e47870e8414ccf18922730f5047cd6a8e0a6a2a6eab2c3795ba4b3097309e61fb480725d75460ced0e1b1175c55fe07963b70483f041c22bd7278994983486528b305c14f0c1741b4e88a71ad4d39c91015e88276c4f36d25e54d17d90c2da325d9b53cdb56a24e02d0dc5a92b46a6f3179b043c942e709585c9a1959471d2d4436b63cc44a069938d0893aefaa23cbc2a2aa934ece3c2459591f36df088a66496e32b774eb29bc79dfa01b79a949385f2d74756af6b52ac3f95c2156b9585ad90f64becaa94dc3ac242716011d11bbdfd938da7e1043b28904db5497af6e5c825c22bdb92ec9bba5b704a88243514580dc9c68ba69e6c9da4cbef2503b7f52c474580f372f97bce7117d5e45649c9bf0596231f38e756dfde2fa96753104d4eefe41f152f0d8b3c865774d07ee579a24b28a18493e314db4aba73754db8867628876286713a0a763433a9b8413e62b820960a941d60bad023a5c530d022da140a8d2b91f2b05203a5032a8e18a00eaaa263aa224494f4a432aaec94732b249694522aea8167270a09c6d26296090156caebab8f46b0fd247bcb786748ac3ba2a6ee985ba370586e2175e7b792eabc16db51dfcd24e2b14e9961d6655b690ac2ba6c7ad7352cdcef7329e42dfe92afb1568735a0f70b336eec4522f96551ec1dd695c8a356ff00c32a4cb04931dc9b2c7f12c9e36b0740a1e723990810cc8d9a8261a1cc2ba9541fd177a1fb2cc40ef18f55352b14ccfc2e50135527dad59548ca4d620aa7e2483994127a29f454f2d3ccc2fd2e54e6c6c6d7c7bcbea4d958f5025c56af94f65deb5e1ec92fa7361e66e607bab92608cffc19f272de524b6ab2dee1588c9533a4697b99256d23503b6437305dd57144fcb334f9ab1c52312533c1ecbe7d991b5c21ed268a29fa8c3ae2ef214975066ad0b81cadb3c8f34874d576aa4a72622abb528e64e306aa7d1ea525a8da2a16a477129378ad6d46e1dca3ca6e6caee1d0dca8ec24d3ada943690f83bd068b29cc9545c18de9c20b548b8ddaa366229474529925d377250c53704a18a65ce4b2110314f3304304516c26d479340881827200b8dc139bd19516c4ae5ab8514a8a411268a75ad4d9260e29664867c925db290364971c4399aec526d50de6e96d6809a348f893c504d3904c909e6ad528cedd2edf7453af0a8ed8d7af966fb3954b3c0b5111cd183e4b0b50de5cce6f9950d3ecdca02725c80bc4ad1382a16701469e30558d1ca424d0f69cd8eaddeb19ed70f755d2570df6f1182b87978856693ac24d22a8fc9b97b65de1e12509950f84f92b09a8a3a86df62b4a88af58b9b3fb43293c36910b331dae247cdd3dc6f50dc3ccad61a9649b2cfd4d14b09d468a3a22b9114ec609250525430537b92629d28269c820960a1dc8a1dc144b89b885c49a7052586c912f05252e7a5372d2aa6a9b26396ee614a68cad51a695a4d957fa7c64a46429ec111635407c25c6c74f83345d40976b13c70eeac35c8ad97f2b2ab83b5c1603cdc8c8ca4b7f896e297fee0ac65c5c9ebea5f513b9efea7e9d02ee584513292959133a0d7cc9dca68927725452a1050d59af4079bdae5450bbcd9bb5fcc92cc7853b87ca820bcbb0ef24b7d9ca5cbc25dd4b8444bb25ca48904a135c9c6ae1b87ce0e61fbc25d98a4c538d9a082e49b988dfb4243ca5cabad46e15e10b5cbb85cfb5ff0075c6729383eb20826253ce383dd45d883dd6bfde1fb28c8450413138da642199173039505c48209e18664f0a4460bb014104a8c55a3a07a04a4dcdd40a6c7c2099976c85b73cd8938e5b896f77c5bbd0aad0829ce866a4dc9d70b1485b6671b260888ad6c4b5377179046e53284b44cdcdb5faaa8c75b21a193944875afa6fa117b7c16dc1b3b223e6e9f27de165bfbd05252b2cd36222db6cb6459846d684bd51f2fec4c49ce31337782cc32f61e5226c85cb4bb422b3edafe8b9f7dd2996ea4f3d35c24f1108f746c8c30c60b5b23b2b6f1333fa10b9253c62779654cc63ff00dc09d7cfb2d42e21fc5ab8e38439b317d95898cfed5d2b2ba25392e3cc3e123ddb87388fcea4a91d35339467a9af4b971136570897f74e664d37118af67dd87cc5bebb293270e54db3405b3b7bb1c09f88d0ad509c221d3ed254157691d20d2267cdcf36d972bd7305ef78958989a6dc1b9b79973fbb71a2fdea5b2663f56907d0854d352cf09b48c737d414b8695114fae0bf3f352ad0dde06db78ce70f84b9f023dd1f1c7e85edb7ad8d3e9f3534570932df53da7cb2b63ed78fd58aaf742920614b17ddbbc227dc7275e70b51621757fe49b7cc79a231dae7d361f32a4c5460523e77f70c6ffee3a93f003eaaef1ef244636dd9979c872af34d73294ab2e02e80f10a76105c282e44904d39e97035c224d5c98999a11fe5d4859107dcd93930e5a371209b8138575c9ab89c2cc568fbca41b808e9456ba7b9cd8c79a7196ed4f4229a14f6ee24764c996e9c23cbcdef20e72952cff9d959773bcd8a222429112482c6b858a5b2a1cc3761b1f236fb2aa54fa39a5bf70e0b8cddab05c2b7d92df054daff0043ce34c9148bde15ff00a798b45cd3f04e8f888aef8d6bec253e7ec8a87361d049a1681e634fb2bba4e26afa720b6424763a8faeabe4b7cbc11dc0991c3981f38243a7bd77fac1150ccb68dbcd9e94a9dc2fb7d608dadcc3795e1b7b5f0a3f34563bb41b2750a415c6df844891757303e6ff00c4f4b65f347c4b375986be0d46adefdbd5751c1f88a1ac01aff03cf42743e87f65edc92514d4b4db6e0dc25de1e214e5cab568d262bd182e94572104105e84176105ddcbb1410498aec22bd082ec20820ba9505c15d28a082626492cb28a65bcc49f3cc4228209c606d14932b4488939bd0f3addd6b7c2598bba3c282086941232c42ca3c22a4202bc2292e3b6a082f1452209318a61f98e16d0412a69f11cbc5d94d0b24599cf553ac4bdbde4ec450413601725462bb124d38e2082f391b508669c723c44878a34129b827c2299827194105b4ecc4de3c84ab9f26d8cb39fe1656bfe988a92b552fa269bbb1a5b562364fb63da633117fca1715d062ba4f0fd473691a0eecf0fe1720e2aa5e457388d9f677cf7498b493809f8412a1057b659ace421e0c25602237254450b24f30a60594f32d9165147495349ccc594798943ed2ed5cb4a89352dd63da488787f954796a591852e0a39263b22ea73cd49b773999ce11fc7fa2a34f565d982e51251cf4c9bee5ee95dd9e55294e6ad55fcd7cc7b0574da78e9dbb5ca91a60116ae1534c4501260a45a82b085b60a9aa9f98a75e2ca5cd697aaaa24f5c44acf3a5b81c28f0b65f655129ee5c5eb266ae4b1685270f86ed73bd14fb3046401352208b0878d38c6e89b95daa60817228c74504ec6d4b70b2431d9929b5314e97bbf1c2a264c6e244ed3543025ac1f38fe5eeb7c5fb7c8883b234b8a4bd8e91e236ee5436d25431dd2b7cdb795bfe6fafcaa09e82744934e28572752afe28c460346c1064960490fc5362494d2a65ae13c514d1412b7ae27518d1349c6db5d1827d914b05073acba0da7c0129b04436094a23e44a6208b18a6da04fc05128323ae52988e653f2279557861994e53cb2a5bb6502ac697478c53908a6c6297048b2ab2b50e8725f35cb5b12599743ed75772d22115ceb19766a972ed3c311e4a1622625957cf7d33bd73e56adee69db5b22ecaf9c3a4b2c47cb3716a55350dff00c248ef24ac5e6cb246cee55364def5518fcc088e62b5471449bcc4575bc4aa13b3afcd4c8b4d5d6dcb63c010b19870d46a49dd65316a67d55590dd001bfecae0e4c847c849b6e3991cdec7380d0dd75d6a8b7e9ae36596e5b09e48dd13835dd0aaff00f4992220a9fe9329245e6c55529b28e08e612ff6ad936be4ee6cb2ace66639adece95c878c38a2b606fb34760d70d4f55b58a96291d99c2e4272851b9c6cadb47ed2fa3ba387fa915f3a524f30970abcd176f5d6ff0046916ca626388874b7de2f226387c35b853a479b78baa85017bf16c8c04f87a2df5e7c5bcc4423de555daeda793164849e12cbc2a97f9b6a132373f3169170dd75a809bd8223d4f5c996e251b1e0804addc9863e48cb4902e151aadb432c4f11096540c6bac7ca2b654ba30cb949651b7db10fcb5c4d910dab5f4dc5f1bacd2db2e7b53fc3c75cbc3efd55a1da9b45a5c150b32e0912c899ae3edb84d912bfec9bc6e8dc4b554588367d82cfd5604ea105c4a9899826edb512429a88ef521dba80d721082e4b7004051c2d088a8d9e3b901a27d8eb951d36e28f751cf0218c134492aca2200436e5d14e58960d22ca4a7cb979a145b4290d827db823b5930ed53c297b92013849a253764928a60a296e4536928c241a11d8a21f34326a429d0b9082f4453822bc70519da250439c10eec512e215d8a65ca4315c7a339abaf6bd61577282c8b67a7fc1a65b7786ecddde25b00109b6263a486e579864c1f1e5ea3ecb258f40639b99d1ff007eaa3e619519332ca71c141cc414d7b557c3290ab536c5aa1675a5699d6943cd32aba68eeafa96755c71b212ba19487955cf653a46765ed6a687199f8f88556df6d0130caae734b0dc2b805b20b396ef251949e6f1259c1b8b85013d24e379485627293eecb397b0e13643cbf7856abb1bd2483e22d4f08dda71384bd65329b1020e572aaadc19a46767f9ea11849b715966e8c0eb78b2c570eab556e600a056965256f1cad78d167a481f11f17cd2019b910db42292c1655d70d3aa3b8926c9dbed4e04e5a245eb7b28189a8adad9bc29278f8adb47bc5953151308e273cf404a7e96939d2b231bb881f5596ed7555c9c9d9a9973313cf3a5ef65f76d828824b24d462b90b8ddd75dfa3665680b91827182498272c494b4eee4f366996c92ed44825b83765f649737dd95cf54974570a172082f46243ab4f37f32ea44236e52cc2b9085a5974f2a08222198524b5097aa491024b224104dcd43ac6cbb443eea7c5313ba44b9484939024104a3411239c41bb040209f08a56f4d825c1041790d3b262edd7708fba898aec2195044af1f930d3a108d42685cb46d196c1bb3166c4c421e5cbbb7f696d24f0f697cc147aa3b4f9919b962b487ce37f06f37c4db83f3fc7e85f42eca6d0b15196199962ca595c6cb532e7136e0ff00a47d2b59835446f8f943470faf985c938da8278aa7da4eac7585c7f2902d63fb15340f77850354a2ca4d8f5f2b2ef7689b1bbda1f1a204bb2bc36ab97457162162e2ab730dda4b4f706c550eabd12529db89a1725c8b94ae1f64955aabd11935998a83836f15a436ff00cb8ff9ad96242a3eb5316b3de2b737e3b2a0cb87c075ca07a69f65a1a4e25ae690de6661ff00358fdc2f9eeafb3f37e1d2b4c29c7270a649b890dcedad891662b5c8ea806f2debe9295630db6da6fcdb6d8b63dd686d5996cc6cccccc5467ea20f78338070959270d91784b0c602f11097a37088ef878fc514ded3ed46d1d36e2725659e971d330d3244d9778463737f5a874c1b4a1cf735d6274205ec06d7d6fe6ae3157bb137b2089ecccc02e09cb779009b69636d05b7bdd6aed85abc46b0995e986aa4423e0b26445c2302cdef23a3d2ad5c7551ff00e8bc23eea90dc5e9cf53f22a09e06c62404b230f1dc3aeb66b937182c7c3a5ca95b77e65b847945f1cdfb138cf4c9322244ed270f2dc37138389d9d296316a6feafa1fc28b2702634dde1fa85accdbb60ddc5c2a3c6e2cd1ff006ac94fa6a32d54a2ff009a597da144b5d3835977d2dc1ff186df7812bfd5298ff37d0fe123ff00a3b158c7fb26feadfcad6a51ab7322a0b2a97e9ba50adba45e6ffc412fdc89874d523ff0937ea937fc12c6274dfd43ebf85124e16c56fac07e8b4e845383059cc8f4bb4f77e02661f4e1fb5e545c7a57a58ea84e0ddfab1fe28ffd469ffa828aee1bc4c7fe8bbe57fb2bd9126e305407ba5fa4095a47323fe17f08a7a47a54a5be42204fc2e2cbbd9d5fe6942be9ff00ac7cd27ffa7712ff00f0bffe92af703211bb55b9ad1d4a32a3501c31b08485ce21f7bba50f8a2a1e6ba49a534d891cc38d89110891325a8757ff006a8d5be9029b794c4a4e8c1dd46c3acb98533deb61d5bbe88143ebde9b92ba102e1cd3f11752a8b01ad73ecf89edec4b4dbd0e9a7aad06419c47044787312b1bccb64d936e0b6e36436b8d90dc243da1553e8eb6825aa12c4e4ab9d6fc2347e71a70b4dc3c4dddc50560a54de334d9f30e6ef091097f98927e3735ed05a730299aa6cd14a5ae058586c6fa107fc1a2c976f7a24c0229da6110b239a62575136df19325c6dc3963e45468457d552c036e9cbf8cabe64db36b02ab38d0890b6dcc38223c2224570dbeadab338c5132221ec1607423cfc974ce0ec725ac0e826372c008775236b1ef6ee81deb9bd7a315d82a45b95c4a8457224bd0b50417457772f4229508a082ec20999a3ca9e892067a28209d96d29d6e1a89332de6d75d732f790411031b9777a48c72fd94d38682094e3a9a18ae1e5cc998409cec8a34174dcbb28fb49f618b7bc96cb36a538623a9120bb18269c3b752649e22d23eb2f0b5cd989041262445a74a4461de4f9e65c8088a341306090e027dd34c141041277a75a4c8413831ff0072082b26c1d5c652a326fb9e6db709b7bfb87c4987cbea078a3eaad86725f0de70394ad5f3e817f2adea9550f0b929399f8426701efefe5baa708bbc2227fe2416bb856a6d23a13d751f0583e36a4bc4d9874394fa1d93c95082764e4dc74ad6c6e52efcacb49b64ecdbc22239adb96ca59d91eeb9e434b24a7c23e2a3e429ee3ba47d64e55e7a469a373ee0b8e70b63a8bba2a97b55d2799893522de0b7a710b57aa3fbe3fb150ca26e95ee913845c445712a99b1073f46ad152e0cd8fc522b4ed2edcccce5c21fa3b3c223a8bbc5fc1414a4ba4b2c293946530c6171bb94e91ed60b3744ecacb29695975e91654bcb32ace1882a1a9a92bb2ad290004868114c85ca7b5b654d2c9750bb4eedac10f11e5f5752a44b46d3561da89dc57ed1d2197d6e2503303d60aa9aa7e67dc74d168f0f8f24563d7556ea743ab4f46199374cf3629e3866562cd82a890f8ca7ca0a266639949be795474bb3137114bd023805ae4a90a50088919e5111b88bb22a955eaa14cbe47a474b63cad8e9fe2a4f6aeabbff00476b40f9c21f842e5eec15620a14f2e6f08d87d4abac3e932de47eeedbc87f7522c12e3a9b978a7c852015288b1403c9a453a08788a584fb1da2f412a105c18272029e1b204ae04114d4136d8225914a09891c9e64516d8269a144b704a50247271b14e6e5c0825a0a2b8a69c4ccced3312c39886e4aa8896195ab28daaa739714637128b5952e899e0172ad70cc3e2ab76595d60afb33d26b43e4b54a51b6926667336c95bcd6a86e81ba3409d77c266c7ab1d2df32fa9e95b3728d088b6c8888f6560f10e2aa88e431b2da6e56fa9381e85cc0f702a9bb1db5cfcb36236e657fa36d9bae79c114bfcd0c7c98a6dea635c236acbc989cb23cbdfd56ae1c2e18a311c7a01b29a9dda66b04aeca56ac2b6b6684dc22121b6e56fda8a73b6da259550a7e530b292b36d5c52504ad3bd963788a8676d446f6fba0a859996121cdeea94d8da388be25ab95471c3b59855b7a3c97b8ae593e18a9aa7d5b620f397a8e965225ca197b6aad338de5552ab342af7506b2aa4ed0712ed719bc6eb762a92b67c96babbed0b5d4977563d3ef08bc425e708b2f696d9501b99258b6d3cbdaf169e25ccb8d60ccd6bd5a4075d10f2a44e161065222b4bb22b65d8ba3b528c08b6d889179c2e2258e6cd43f48122d2242b73a1b97362b3b4756e7c2d86fa375b79ad2e09046c2e900f11dcf97652ecc5102866d3edc54d68578e294e0aa5f4814f171873baaeca176898b9b24eb07885920bb42be439bd913767488b2b772b9494a0b4d880691560afb56bc436a8a305da30b8591d3b48dc8dd70de20ae926aa7b1db34e810c705dde22bae9da8074c894d7bacaa236972f3f337218a09d16124c537af5529b61b211c04c932a4c585d2612c353cd9aca2a0ca50b68fc15ec0465382641589c114541a5e8b49a281953222ba69d115c7209a720d7dd08e412093e629a792094eb4a05c5e014adcbc456a6ca76e949a38a49389a3351dc9c0125d24c14138514851dc9f6a6cd681d19d66e129632d3a1500d11459c261f6cc78487d94aa59cc32877cfd13388528a981ccebb8f55b4beca0265a52b2ce09b6243c42859a0cab5a45c5d73b8dc5aeb1501302a266814d4c828e9b82872355dd3beca06642d511344a66761721024d554ad2e360afa090345ca8c0975d79952a6c5a847e09a31001496cf98a93d8adae989174731133c4d970f687f82d7a645aa8303332d6dd6e6158294bab87451527da9b11122b4b50f0a54533e229baaa58e607ebf956db6dca49b8c14f6d78b78d708da45a943802d0c4fced0563276729e5ab8d32a8fd2fcf88e0cb0966cceb9ee8b5f65c8fecf8d682e382d36e3a656b6d893845d911b89611b45512999979d2cd717b23a47dd59fe26ac10c1ca1bbfec37f9ad4706d01a8ab333bdd8beae3b7c946b904d27b71732e61f68973c5d692043b49e6e2b82c779382d9730977850417377125c170a1ccd97ab985702228904eae92edabd0410488c50a71b491718a1ea436e646829bd96d93aa5505c2a7d3e62705b2b5c786d69912e5c5737408be6828fda9a24f48b9853d2f354f7b8711beacbbae8ef12fdabee2e899c956a8b4d0976c4657c15a2b9b1d444d891b856f144bc718a3b6c2872b3d2ee32f8b3312ee0e66dc112f67d225f1460a2fb40bab41869cbbebf45f004a3c45d53996eb844ade51ca5f5a53d316b84d6a21112b874e65a27497d15bf4d279f93c49ca689661b6e98951ed7a5c6e1f1c3c705998b224370eacd697372a90c7070b855f2c2f89d95e2c548c5cb844930fa16af55b4ad1112126da2ee95b990815722ca2c9177737d94a4d8d54ccb472a5c5478bceb637783b96f35a5fc138ccf110916190dbd92fb5b90b2572dfd91e105e8a1a5a608cb2b2e5bc4e5a56ff00a27a66e1b8844887ba577b3b9121cb7f65d8fb49da255e6e9efe3c8b96dc36b8d90dcdb9de1f217c708fa145fe73fd497b25fc176350e2c3ca5a4b9bfcb7a718e731c1cd3621353d2b666164acbb4e84117056add17edfd467aa1e0932db4e0136e16236de193443f687d1e35aa390b57c8b1a85a5736530c915d71364425ddba1c2ad5d1f748254f7dc8bc53336cb8de18b1022cae70b9d67ee57f87e3194064b73afbc4ecb9d710703995c66a468600059805ae7bdf607f0be8774b76941d5e5c8dbb6df841fe5fbca852fd31cb1167929a6eee2221b528ba6a9385dfa1cd65ed0e656e712a622d987d7f0b1cde18c55841101d3cc7e569d2ecda22223688fe0bf6a5c61abde12d25de596c3a70a7ffc24cfb439577ffd6da7ff00c24dfb4287fa952ff50fafe1327857162ebf25df4fca9adace8ca4677ac6bf4198baeb99f3645fac6bf7c372a2cf355ba279d1f0e93e61b9c111ef6a6fe88f895821d36d3ffe1267da6ff82707a6ba7e9f049b8f30f565eec752aea8f6194e66b830f71fb85b4e1fc4b8a3087831b1ce68e848bdbb037fbdd35b2bb612939a48997389b78ad1ff000cbc848f9c749d2cda78728ace76e768767a7ae26e52724a63e519c3b08bf58c792ef9e0a0365b6ca66532e27844b890dadbdc43770979415348f0c36b878ee3f0bd11c39fc4433b00c42131bb6bd87d869f11f25b5372f97308fb236a71b9212f836fba423fc142ece6dac8ccda3760cc17c1bd96eee979095a2df59283afb2e974d5b4d54ccd116b877001f9f642953dae26591ff05afe09a2a6b045fd9d9ff963fc11850f693b24d95da6ee6cc8938e822b5cb47c824314596b47f47647fc16ad2f5b72167a892798bc0e5c8bbaa65e76d11cdfed51e51c42b46e440051994303cddd1b6dff00b47e142b5b3126e10fe872ff00f2c54b35b154d6f4cab2243691396f2fd9152526d5bc223def79315c9f269a2311c4e516c6e2240807a26a5a0a573ac236dbff0068fc2a6ed751a4dc7044a5db2b74f0a8363642448adf051f6890d5ddb66808b11899bbb6106ffd52291b475399cb4fa4cd3844594865dc7caee1b7c5bbf6a22f886f6f92a9aac4f01a6043dac2474118b9fa594a549b6287334f9f61926c5b709a9816eeeb1921d2576acdf660b4ce8c20e153e5cdc1b71c9e9811e56de72316c7f62c5ba41d82da36865dea9cbcc5d378e52f26442ecd60ca8893ef94b35e61911707c71e65a7ec06de4b04949b132dcd0cd0b62c158c38e3656e92b821972dbe556384d5343cb49b0e83ccdaff0065e6cfe284315749ed3450e40eca08035b341b1b0ef7375a501ac5b69763dda94fd78a5adc697725306ecadbc4e33d7b045c2e688c23fc56c4ccc8b82263766e61b4bd924dca4b885c2022388e138e769d2d445f8e182baa9a56d4001db5eff42172ec2714930f739ecf788007958826e3ced65f2b8c1d69c26265b26de6f29090da5eb0fef82237afa236d763652a8ddaf8e1cc08f5334df9e6fbdf283f3457cfdb5d409ca43f853224e325713734de665eeef297c631596adc35f07886adeff95d6303e258310190f824ead3d7cc1ebe8984ade9b03bb30a541572d225412922115d8c104170a2a3a74d1ee45444d166f591841496fca92d42e249988e914f4ae51b91209c982b7d5fbc9833b7bc9113b893ad07b4820b8db3766244842d4889a1df7f8450413b333423a731261b648b339eca5cbcbf366244c608209bb524928c9260820bc9b8c492e249118ffb504136e9a648853a50f6578db146826372e4492cdb48dc8209e696bfd039f84b33526442382e0cf37fdd15ac4cfecb65a3eb4563adc6deeab4747f53725a6fab2c3279b758b87f5ed108ddd9811097f87053286a4d3ced78e87e8742a062748da9a774646e3ea350b63db4dbc629ff00a34a88b8ff0015bc3de2fdcb24ae5526670ae7dc22e51e11f57f7c7c68026c88889cbaebb35daaee2b91ac02d897ba43aecb0ac8190016dffcd9478336a3a553d197b9340cda480616a37481e148b2d295936d012115352ad2b285b754d5325b4464a829496040cac14d4b36aca36aa0a97d97596937b4137e0f2ce1719651ef17f01ba2a45b0b55176f6a17be2d0e96b57f785abf66587ed42a24e5c64f5e89ba084d44e0746ea7e0a1595d9a86615d660baf4338aa82345a9bf895a69d0eac51508262561d58a2591570c1a2cec875250b3e5c282ac4f7833568ff0068787fe58f377a28b9a7046e75cd23a4798b84553aa7304eb84e16a2506a65d72856b414d98073b6fb9410af10a50413842a285725daaecb2380500dc149ca25b4a8f29b219e690840a65e6d066da752592a0c5b4f0b6886da440329d6a27cc8406910d827e0ca58b6969874b75c6e09e182e4052c608ca8ee29c04a8248c12c60804c14ab5465468a2efb4a5c013cd06614991a0b4dd394f3398f194f55a174594d161911115a5b02a9db02d7562ae905c571003da5feabbed113ecec1e4178e2877229c709331501c14d6a126c2e597edf339b508f796a530b1de92264b1cb490a8357298e236eba28d8865e5eaa9f3ed15d70908f796a3d16cb961dc4b2b64c4886d2e2d2b71d8a630e587baacf83a9cba72e3d02c8d591a23ea85955176815beaef2a6564d75c85b68dde856331a9b61e6b4169cb85671b6d25d65da79495fa44b2aae6da4be52eeac97155273295c4745a1a796c4159fd3a042f0f7b32d9b641cb99158ab0d11399757acb61d818f502b96617ef90b5784497710ad6114e5d6a64629b98715fad001728d6dd4256a1d592625e613d50ccd97752d8526465962fb481d71779414d1daac5b5c186e12abc1a2325d8f089f994adb765c131d872d73efdd0f864497836a39b6ad4ccc0ab2680ab4b8a09c82434ca2a2da74194764a0fb043c1b5c8b28e16d760285d173103061709a47390421c520a5090a1c8136704f126e304829c0f29a1148314fc2092704cb9488ca108509328e720817a09a5281439211d34f4c9a1c4521e7a29518d2e57173727a00b914d39a9c09921484e91264a298704e8483439a7ca2877547705218b61e8fe7b1649be66f292969b8e5544e8926bcf07acaed503cab5b452e781a4f6b7c973cc4a9b9758e68ef7f9eaa0a7e63c7f687ef0a889876e444f473265997b94791c5c6c15942d6b1b729a6a5ee4ff835aa464e5add5a929f65188ac125d51e2b281986547bcca9f7d851f32d28d246a6c33288882b3f462cdd3a2a01c0574e8725ae9b22e51511e2cac58ebab2ed21dd305d94c3305ea9c7ae73bc49227ecad04443582fd962ea6ef9081dd40f4a33e2c531c6aeeb2708581d376009093e5f1f8ed10847c99cbe258b3ee08ead3f8fad6bd45d8b9cda59f79cc6f05a6caf51e1043708fea2587c5071c8e68c63dadf15b7ec3f46d44a408c5a936e6a6b8a72784665e22ec8942c606ef24061f5ae518e62cd9ea1cee9b01e43f2bbaf0bf0ec94f46d601abbc44f99fc2f90699439e99fecd4f9c98ed332af909774b76e527ff812b639bf32d4bffe2babee284e15b6e91ece51f752c5f3e270bda54ded67a05a938481bb97c16fd0679af3f27352fda7a5dd6c7da286e420dd6dd695bcd6e55fa084e5c3695ae765ccc25ed78940d6362e953996669b2a45f28d8e039776499dc942a8750997e18e1ee95f0d0bcb86f37c5ab879897d2db73f93949bf73b4c9c7245ed5e0f35fa4cb9775c1ced7f9acb7663a29a84a56990a8323e0ed962f8436e0bac9135a46ef2dd778ed8c37a779ccb13751450ca5e1b6dcdafd12b65ba209c99645d7e606445c1b85b26c9f72de127447cd6ff0089446def47950a50e2908cf49ffc64989161f666582ccd7d3e45f60d3bc0dd1c32cb946dbb2dc22396d4055e98c4b5c44f0dae09651cd7766df278fe750db52ff78916ecae9f85436c82e1ddfbaf86d8785c1ca49d20b856e7b4bd13c8ce138e34254f982b885c647a92fef58f217d5b964fb5db1752a5f9f6f1a5f866a5ee75bff107535f5f8be75262aa8e4d8ebd8aa9aac36783522e3b8d47f65ac7e4c7d22617ff00889b7047fe049c2ca43c52d717143d1ff65f483324d3a374329710afcf589dd6b8d9661b49b26f29090e9212e682fa67a08e96c675b6e4a71c166a4d8da376519c111cae0febbe314d4f15bc405fba9d87d5e702371b1e87bf915afcfd2c5bb884729652ed7f37d0be64e9d7a386a508aa14f6f0d922ba7255bd2dff00ea581e11e61878a1e55f5084ec5c1d4a1eb74912b8886e1704ae12d36970f763f12851cc58ebb7e215a4f4a26664937e87cd7c12526dbb8976a1d243ca8566448743c4dad47a65d842a54de3b43ffe3e68885bff00d3bfabc18bb3e918fd5e859b112b963c385c2c9c91be17969d0852b2b58a8376884e3836f0e521ff00a9052929b6b551707109b26f497e8ec3977b3b9404b9e61478c53a1ee1b15223c4aaa3f76470f8abb37d23ba2de695972f5708adfd9a97a1d28cb7c249dbfdd90917bd054c48285dc28c4ae1d55843c4b5f16cfbfab41fdaeb4497e90e98e5b70937de971fbb047cbed252ddd2f498966d4d8b5f6a0b2b843850c720d170a589cab5878d6a99efb18ff858fe16d004c3b95b19773fbbc224fcbd21bbae265bbbfbb6bf82c39891c3d0e383ddcbf65165529b6b30ce3cd88feb0bef258a81d95bc5c7915ad241f220fdc2d99d936047332d9779b1fe08529263fe1d9ff963fc152649bda2c11741cc66dc1171bc4c222212ec96e8a4ff00e27abb1fda69b021e6165c0f5b26f82936205cb48f82934bfc44c06539490d3b1b807e8355788c835f232f6ff72d5dfe9fe49254d63e45bff92d7f05470e92047cec8bc3da12d5ea9420a5e57a42a7e5bb199bb99bbad2ed5a8b3b168a0e22c126176c8cf88b7dc2b2852a58872cbb3ff25abaefd8913d4f961ffcacbdd6f13639547b5b614e21fedcd8916912136c7bd71413bf9d1a77283ccb9da1704ae2fda8858ed65690c94137b86377a10932f459622cd272e5fe18a3ff0031ca65fd165c4bfb914fcbb4423dad45f8144b7990213eea4a73b31bff0048fc21828329ff000b2e5fe18fe3f6239b808888b63688e51e5f7978c930599159263a58d86ed686fa003ec94496732d3599f70591d2245a6eef24808da88719175926c8711b21b5c12d3ef717cf040a153ccc84476bf4bed7f34c15424caeb66192b7b4289662d10f9e67fe70897faacab6b365ce45ec769b29893bb33657757d97087c787da87915bf67366295526715a952173e19bf0a2c46cb9b36a6fe2282553c4f95d95b6bf624ebe8b927107f11eab02764aba636fea69b8ffb79ab58134d895ce379799c122f677aae5667afd36e6ed24543a2b933d43303ff00f95ff655d7fa2a96b8ad999b6c7fbebbf729bfe9d38e83e6aa28ff008eb87b892e88fcff0000a2a7699e14d9306370b836f35bca425cd02f1afa3bf242db7f0ba74c529f21fce3452160a368b6e3d25985874b743310db6c63dddfe55f3d51ba2520eb46ad38df2f17ef82e51ba3baa494db937215f765a61e126de784081e26c88725c318dda463eaa627c2ea1f6b33ea153f107f14304c58b5c3f4decb824826e3b683a2fa7ba5fda0a7d1dc99a84e10cd54e6a57f36d3e4c6c279a9322b9fb47ca3711111147cb688fa1675469c07596df60870dc1b8484447d52b61aa05e28c156765f619a967bc26666262a53c598a6a6889df644a31ff356b618001b404444888884728dc5c56f92e8ab5c2e8a4a707391af4ea3e2b8bf1663b4d89c8de466f05c66d81bf96fe8baf39c445eb128b99da100f34c4dcd969b5864887fe639ba0a5a216e54898374472362e172939863ed6e8ab47dfa1fa5d66a0c80f8866f8d87c7fee154e7f6ba71bb8bf304ee08e622271bbb2eab5b08c628aa56d052ab52ee4b62365883d64a4c756fb65cc025e3ba1cc29f9c7eb45fd9e4e9d776df73ee8accba4307b793b3f2944c41e390998b13e25cc386598be982ac9e77c63525c3a82db0f98fc2d561f43154901a1b13f76963ee6fe609fdc287e9136026e90e62075d4f22caf7137fab99e52f88bc9155b6c95a242bce9378475b9b9795786d266a32be16c90965b49c18463f5a83da0d9f19126c9aa84acf32f0e52952bade2b5d12f18e559da98987c718d3a8b8d3fb7c1747c32a656810d410e77420385c0ef716bfc50c2b918a48397712f462a12ba4835147e707bc2a56305131d43d9246111465d717753af1f0a199cdeb15c49e661715c8234eb4368af44d21d713437176450413847c29d61a4a6dbb53913448250c12085222faf08972fdd4104a808aee5498345c442bde0c3cc820bd1826f70f2fb4971951e62f6973c1c74dc482092511eca6ad1f592a2c0f315c2b9825cc3eca34131bede64988fac9c8b45cd77ac988a08279be54fc9b96b83f8cc8618dd97d94b81ff57791a257babb77136f88da338cb533eb1657c7ea745d86e43b6da46cece63c90b45aa55e2b4b8b01fcd6f760e5d187f791520c36b6f8749cd89aef2b1f82e7d8ab391339be771e85765da441ca27a5db520cb4add91dd67a59cb4dd43b4d5aa524de5e9f97418c0852c03194d97095b75639270631eeeafba2a76561a554698efe3ef2b5c9c72ab181d982a4ae8f2945bee88891474809117aa2b1f7df275e70cb519117b4b47db19ac3927bb56b63eb166f76e598cb2afc41fe26b7e2adb0186d1ba4ee6df2ff00ba95974b66173c29b62288a385ce9265a2e40f353de6c1c7c95a9a8651453a16b79b2dd988b95b14aa6b1bcae2d2237112a4eda6d0e3b84d37e6eecddab748f760a74f3089be67654b494cea99728d86a4a66bf56c772d0cacb7a7b5da2fa500826e28e6d55837d4ad4e40c01a1369e04d90a75a4a09a79d126d47c94531104e4b452c689890dc29221431822d9d29a7e09d0a1876a92d368806d32d4518dc138137238a4c1b5dc34f80a5da96a399109105e80a248122d4a461e90304e0c17976104612494e37145cac330a1014953a5c9c7040751266a64e5c4e776052e9a32f998d1d48fbad4f6163d58ab3bae28dd9aa7603223c5c495549a1115c42a25ccf73bb92bd13491658dadec027e0f2748944d39dbb323e2ea62fa292e6eba26a7a3d592c376c9dfd20bec90fde5b7d44bab2585ed65d8fab8956625ee055b887ba0217672485c7c72f12db256186c88f65665b054f2f08b8aeb5698fc72add7065365a6327f5958cad7f8c81d144d4dc557a8e6561a845572a315d080b44ef42b178a9b91eaaf72083daa6ae6d1d22915f0b99254f8947cc89edf25a488d9a165b0609b7478ad2fb25c2b57d8d8f57769ecac9e68885ecda6e5abeca15ac8ae2545198ea5e0f9ad8e0be2769d94d4c3d6a609db85333e4954f85cae41b95a9b00d51cecde1929ea7cc8ba2aafb54d5b99446cf57484ad480fb1294f68cb72a4f6e6882e0dc2b399b6308ad5b2b6f0bedaa3ed451735c2ba1f0be30dcbca72e5dc5f81389e7c615380530704f4d652b50e715bd1dd73526da2eee5c23498413a0ca227b26cb924609d6c13a0da5c2088e8923543cc06551ae2949b351d11484f34ea99b57893c50424c124b8d93cdd520cd306eae12649345ca5b1abce3a837cd3ee413316d20dfa292cb20482e4b004560a6dd82465b2941f743ba48738a75c4dda90e09e6a692492c93650519e9d09b32433a69e76085760a3952630ae5d139fe92e7715e2aefaa67456cdb8cefaaacf337112d1505db00f3bac7e2c03ab5c7b003e88306ae25292928229524c5a8a8c54c8e20352ab669c9d026b0d34608cb5722da596a8e24514f34a326da5617c145ce36a34ac53a9e5d557df6d685d10cbe1b730e972daa90eb6b52a0cb60538798957f2f338355c09b246e7760a2662371177940ed64d10b72f28d17e915079b9667984488449c5668b293b19441776831dc1c419793b99bb4b2fe28b625f58e247d547c493be9e85ce67a13d81d135c194b156e28c6487adc0ee46bf4dd69b46a7049cb3328c0daccbb623fde39f0af97311178f7a29922d5c2293bf37115d7664e4203fcab8aefaaf50b80636c148ca5c48a16c6eb6ed2846625dde5b51b28de5f78b993c143794eb705d75eb75736a2fbab9bb972f6b8939ab56646536a3ea5556d8127087b3da254daadf399db6f0dbbad12f9421d45f5227a48b9b6c5c1bad12112bb48dca7b67e6441a6c62df5387d596aef5c5c2599304ddd63b296c686b338dd55a46a0ecb643119864785c1cdea92b2d2dc937c6e02ef345a879b578c51955a1b4e85c0e08aa14f52cda7c9c61c2121e2e1bb97b429123397b25b5ed97c8abd4cd25ab72e9e555cabd3729088dd70db696612b9264f6ac849b6a6dbc122ca2e7c0b9dd2e12f9a2aeb4f9603b4b2a6c00f36445c63172b02dafe86a5272e718fff001b39c44d8dd2ee17eb58e1dff18ee587eda6c8d4a94e0f84b24d8895ccce32444c910e921747c6c17cc5b97decfd14784556abd43126c9b71b171b2ca42e0dc25d9b49584534918b1d47d55454524339bb3c07cb6f92a0f40db71f9d241b275cfd3a5fa89afd65be69ff00587cab626005c0e65820f47edd3e6ca669a58389e72548ba92fee0b855df63b6c2d7309fb86dcb9b290a6247303f4d8fd158c7148e845fde6e9ebe68ddbed9c627187a5265bc49778730f2970ba3cae0978e115f197483b2f334a9b2967ee21d52f316e5986b87fc487a60bef89f883eddc3eaacbfa4bd9d627a59c967c4484b4b9f08cbbc24d17cdfe69d8aa396eb1d944aaa1f696e9a387d7c97c7928e7baa6422a3aaf4d72466de9677532e615dcc3c2e0f66228d958e5156e0df55957348362888a42f124112082eef5dde91bd751224ade9b799c526c33758e08e5d598b525ef521b2b2f8951931fd65c43fcc9713333c37b90147ab93950bdfd9a4fc82d91a6441b11f936c47d9111f6b2aec0ed4a80a90a64809b771f3655bb6b6fa05c126932f89ca19f012d4db65de6c4bf728f9ad9ba7bb76249b377308dbf655c7f33b1daf6932ed180b89cb7bc83a983b700faa11626587c2e737d2e3f7599d4360e98efc1baddb75b6ba5eeddbe0a261d14cb15c4d4e4c37cb70897f05afc686d965c472df5520e8222395c2f6546761913b768f869f656f0f1554c42cd99df1d7eeb1b73a399f6cbf47a947d6271afb31dc8dfcd9b4ad5b6b82f5a3f28d17da86f5ac050ff5deea73f3297ca0fb299760f1f4b8f43f9bab8a7fe23e27068d9bee3ec42c89baf5798f3f26243c458377fedc5203a4d744bf49a7908f3378825ec9c16c10a49fcb0fbc9a99a39965ea4bbc377ee4cbb0777f2b8fc402b4947fc67c4e23e27dfe3f90566521d25c8995a4dcd09170da25f67c6ac32db694fbb0c660848b85c6c84bfd1589cd8e64b31caca917308da5ed0a8e9de8e251dd52f865ccdbc57261d854e3620fcc2d3d37f1de41a4ad07e03f623ecbb2d57943bbf4897ed5c439aeec97c6b3fda8a7cd4b3c33d4873cde6265be11e2b477f58dc7d2315355ae895a2cad3d3025cd70928a1e882a21e6aa05dd2b87de18a61d435035cba8d883b2b2adfe29e098c53986b631a8b037208bf958e8aebb0fd2031526ad31f079f11eb25cb4b9c2452f778ca1e988f960a765650888472e6d4b12a87461586de1719c1271b2b84d976d3bb9b3456c1d19bf5126c82a3284cbc23966616e13a23cd6e93ff28ab8a2a999de099a41ef6d0faf62b8763b86d1c20cd41235cc3fcb985c7a0dc8fa856898b406d5d900b8b9536ec2e252b22d5a3ab52b42eb05906c3a6a9c32f59475567c5865c7dd2b5b6449d2f5748fd656c11c44ab7d20312a52051a83c4dc8b2e0bcf0895a5318799a96f8fc65e88795312b8b5848dedd7653a8e16c933186f624036173bed6f355ee887689c7c5c977e058ce14c4fb24e117f6671e1016c6ef19404a25bbbaafe702e1b6eed6959cf4772f333d3ff009d9d67c0e5465fc124656db7a9cd6e5e580f8f7fa6e57fac541a9561c7dd2b5b6c6e2e622d22d8f31115a30876946a373b95771dba9d2e07556f8d44cf6ccb101736b806e038f4d34f5414e5145d1229b9c9826f89b6dcf0497b7b566e897d71551af6d750294242cb32d35303a5b6045d2bbf59325bff007c548cb6c89d41b17eb0e3ce139d60c836e130c4ab65a5b216fc6e396dbbe3153d4fd92a731e6a42503fc3132f68925cd91fab001e6753f24ec735353f8657ba4b6ed610d6dfd7afc02c9a676ba52a84d8d567bc164c884864e4e548591e5f099d286ffd8b4aa4ecad11d63f449393986edca4d95d772dc5bee1f9f7a9e769ec1b64d1cbcb9365a9bc16adff0045529de8e5802c5a64c4c5266357524472e45ca4d970fd09a14cf61bb9ad93bdf43f0e9f0529f8a43380d63df4c06c01bb3e396c41ee7554cda3e8d85d1726699775644dcc53deb7c225dc6f50b45c5f1c211f2c1672f642c373ab734936436b8243a849ae15b5747f589bfcf13d2d3c2c8cc132de2133a5e7a5b28ccdbc044d1043c5e5ddbd4d7489b1ed549bc46c45b9e6c7a97ad1eb3f54ff0030c7e3f42ae970d6cec3245a10482ddb50b4549c4b250ceda7ab39d8e0d2d78372011a5cf51e7baf9f8a0a15c8ea526ec5d6dc7187c70dc6c88484b55c3a8487fd23e95184a8ad6d0adfb5e1e2e3645b31ca3da4b8b96e5143ca472e6ed5a9cde892975a1bb52220422986eefea4f042dfe62411a54088b4e51ed2720cf315df65722e26dd9811d456dda4751177447c65fb10411508dba6d49bcb995af64ba31af55044a5296f0b25ff00989cb6459f571b317d505a5d07f25e9e72d2a856256579999364a65cff0098f65fd8905ed1b94b6c4f76c1613134394e37f28dfb42bec2d9dfc9db6718b49f666aa8e734e4c10b7ff219dd0b7e65a152b646912c36b149a7b223947f456bed142312fa536676a90da290eebf3f82644b4891775b74bec82edc5c2cbdff0025ff00ff00e6bf45da6596f4cbcbb63d9976c7ecc138603f26d8ff0086dff045cf1d939ec0eeebf381c9c11d4569768487ed42092134d969212eeb82bf44a6e9d2cef9d9393739b125d82fdcaad5ae8de8733763d0e9e5da6d9168bfe9ee45ed2dec8ffd39fd085f0b943887d61e64d180db97bddd5f5c563f27cd9c76ec266724cb9a5669db47fc3737c1516bff009345b9a46b5dd6e7a5c737649f652c5430f54dba8251d2fe8be7bdf76accbc01765bbda576daee88ebd4db89da7f8533ff00114f73c247d66f50aa444ed730dcca5c4db824d39ecb908453a1c0eca33d8e668e16539b0f336cce11697849af5be0bde576976966b2ce61b82e0f09090ad5a5485d117474bc22efac5a87ea2ba1eaad570ecb7cd19f51fbac4715c3943651ff00b4fec9e61a47300b92ed22db6d6ce362e772cb74dc59bbd541cec9297115d88278c6084cb672d3a2aeb10b4959a96f655133b2b6a7298f5a49b8864759395169597099e918fa9687b777bb1545661995db6fa3732cf7feec5531955f5bfef7c95d613a530f8fdd1ede9539b2529778f9bf02a082175a3ccac352ab8d3d8100fed4e0e5fd4897c2176be2fda92d91b1f88f4fba13c6f9072d9bbbe812b6f2b82cb7e06d1759ff009970787f57fc567d14b895d98b3116a2498c147748e91d99cad2969994ecc8df89ee529a5212ea3c11b2c494d472220c529b4adc9209c510945420930878d2db5d214a51ee8e9424a9804c4a1238a17275aa23f42a38228f97342bcdaf3468ef646f19829308a78504c9a29b24e82a0bdb64ec4520813908aec608d340d90a505e8413c4291b92c273325041699d1bd0ad1c7707316955fd85d9927c85d746d647de5a54d4c36d3768e511584e2ac79ad69a584ebfcc7b797aae97c1bc38e2e15938ff00da0fdd153536222a833759f0b99c36fcd89662505b77b5c45d431766ca4e0a91e8ea98422245c4b9a99336cba9412c6496837237578930b5b4883f9ad473f0c36d4453e3715c9f3a2369162a4a7e3d49775635b4ed0e35c4de522d424b5e9e73290acb36887ac21ed2aac4fdd1eaa9b176e5602ac1b0f2e239874ab5cca81d8f0b5b153d3315d5f87a1e551c6df2bac24cecce715015155aa9c5592a66ab33c5996a87fb4ef42b218a3bc4079abd53df44544ee6d57a4265483cfdc2a354417055dd3d45d8a93500b9f1b79b35cafd467ad6c455166a57afbb9b4916956ba63994570f91a195b234775d17877ddbf92b29e614c48bf695a8ca7e66d42d4e186e2944e5175a40331214c562545c6d6675896261c2b6e1b968f253a2436a80da890bf4a6678cbc58151ea1a4c67c9466cb55c872912b63b16df6d66a4d1344a6a8557cd9896c63e1f961a564f09d6d72b0f47c491cb3be96a7bd821369e86425708aace02bced56d10b8384d0dc5c45caaa04b6bc3f5534d0de5045b4d7aac4f1651d3d3d40e4b86ba903a2660d25c1722ba51b55f12b2602f44920cd2489364892936ec6e48dc9c8a1de71114e34265f341b914eb849924c3ca96c164d924da9db576d49b27da50e4093104446099348254a63530ea0de45bd143124a7c04310a444512429b2149727da86c35e204fc6099722a2b93cd433c08375b46b9149946b11c6c7988453563b294080db95a26c7c9614a363c4598bd6530db09f9796c3111e5114e1416ae28f2340ec1739a8a83248e77724a68013910ca94097186524f59452ed53304b84125b825a08894c3f0517342a55e51f3504cc83452a0286a44962cc363da579adcd8890b43c2a2760e53338e97c18a62a0edef1176944a5666949ecad6add969c37ba911715f3626505b96c5b733c5ab8885aca23dd816247d65968ccdba96cf4796b25e5fb2c8e5ed10dc5ef12a2e39a90ca26c637791f21aad4ff0bb0e2ec4dd31da361f993609c0815d97d9eca2465c784b52f447eef757a11b74e5ed2e50d5dfa4ba909600e2fc77bb2896e025715ca301decdddd443263c3a7dd4bcca3967552385eb1710f6572302496e3a79bf1951107aeca56faa8f44c9ba8caa498bac936edb6965b755cab2d91d372b973d225c5a8a5fb2e73370e787915d0c072da597b5aae4de1dd9750e9b7f9bb29b7b7b27a39328b74ec8694618744482d2121b873654999a58daa24a96ec9911ca6667514997bc52c5c25d88f894ad2aaa1321701661cae0e971b2e5707ca249b2ebe84256bbb4e8aafb494b17449b70448797f1a4945ecc551fa6da2e623d27cda9c67bdcc3f3ad0634c170ae2cc989da1da3a452044ebdc2739ed0dca54dd16b0d3e026d9890972922e658125954f53e6651cc5932b4aeb9c64bcdbdd9ec92b36c96db3532361756f0e57192ca424a4b27b68e50e4a5fe68d72b949ecaa755e9addb984b2f1717aa5fba2b577481c1556a9c98e9b7ba4912b07452696537b1556a2d5cd8ea9c2b9be12fba5da4fcf18bb75c39b50a8dab356bc43eefe3f104752b30da5a9be2e61e125186ba2b0700dd42c17f286d9d2b59a808e66cbc1a6bbbf00e17d05e2f596594c3cbeb2fae76d286dccca4d304236cc32eb45de21ca5de812f9025449a79c68c6d26c89a21ed345697bcaea864cccca7a7d964b1a80325e63767fdc6ea4dc24d5cba45952060a6aa64a8c52a10486d3918a0897b7ab0f45acdd5512f93977cbd6b6d1fd8abd1ef2b5742eddd3b34e72b3c5a473295422f337d555e34ecb4527a5be7a2d49c80ab349316b2d8dbc3f6b32ae943f1fca8e979a70dc6c6e2d598748e5eead8c6fb15c6aae9f3b7d3553587d94888a7624b901eca93754fcb09a16c4536608928a400a199172826c417a2288214d9a3cc9060098282f36d1274453ad0a3cc93c848805c999e2b72ea471651d281b088ae441c808026a59822444c90b639bd5b7527e5c2d41cf9dc56a22e4e32105daa05b66ee6b8b55ca56eb5bb50926376645bf1b90525c05ec9996673779493d11151f2f076ebbabb7b57243af4cfc8cb97f8c43f681364faa564cdd47cc0fba3216a0ea14b969926c9f645ec12b9b172e26c4b9b0fc845f4ef4d785ccffc0917f7730d7dedcb91ab10ea939e1eeb62e8ff00d338a4b9ec3a3bea0a76386569bb08bf9385fe86e8c99a8343e72e6fbcd95beec370a61f65a99264e2e36e32c96261dc3864f7c1b8e5dcb9a30847d25bfd0abf5edbb926849a1987866b4f83b72f74c0ff00847947e98f910323b3d4a99217e6670a626087336f4e0888ddf0786d5a25b94774e1de16107e36ff003d14f8a80c6de64c1f1f621b727d01b69e7756efcf9278a2d785cb6291650c61b8bb28d79db4488b288ea55697d86966c486489b65b22b89b26589b122ef390bc7ea2528d42a0c088932ccd3639449970987aded0bdbe045eb2718f7ff0038f96a98969e027f49f7f27687eba0f4b95252d34d98dc0e36e0feacae2f67ca9718aae4fc651d2b9d666a4dee19816498704b9b1d9de25eb6f84548529f774bae37343f0734d8db776665b1d2e76a1e28fcc96d92e6c7e9fb8dc2665a60d6e617f423ec468550ba5207e4eab4da9318638974a384e0dc22edbd513a23a86224230eea869ce91a6466700aa0e36f0e52b64c3044bb5778edf9d69bb7143f0e9098961caf10e2cb972bed666cbf77acbe78da3967e6705cb7f48b70a6ad705b219960b0cae12dd963e5dea8b123240f258480fd74246bd7aaeb7c0ffe9f88503a39a064f3c24019ae498cf41a8dbbab4f4af1969c9719c75bf03ab336b4e088dcccf365a5f6087e2f2f8fe859a9453ce9bbe68de70b0748e25c23cd696fff0044cc552cd2991d98efd7cfccf9ad047491535e386e197d1a4dcb47f483d81dae9e02d29d0142cbc53d13b731651e2b9329f4f09a719b9c705a06dc79e70ad6d96449d79c2e5111f1ad03a29e876a159b5f708a9b4d2ffcd3cdf5d303cb28c16ecbfac2dd0fa57d49d1e6c0d2e8addb232a38df0938f75b38f7689f2f18f1651dd04cc93b5ba2970d13e4d761dd605d1efe4ef549cb5daa3c34997d5e0e36bf5021e5e596dff3c77c3e25f436c3746144a45a5274d671bfe2a6bf4b9822e6c57b7c07d58415a822956e9cca1be771567151c6ce9f34491ddab37797af4c8c12a11f553775232a5145246257766dcaba4b90d3f66e42e8d2c6d4981fab6fd94d41df778579d76d1e6b9281432a43ae8f686eb730a6ddbbbdda5ddf76a1bb9adcb6da907121f6bf049253805934624375c4a3e6e377751ee76bd6eca899c73b56969ef2494f3412829876d2eacbdee1ff00b283da1a1c8d4070ea1232b39da26c45e1eebe3b8bfcd4e38797365ed7328f98ef69249d41d13b90386570d1625d27f412db0c3d374679e2c11c4729b3058a587a8bc19df2dd0f2db1f2daaabd1ad445f9426fe1a5cbda69dfe05e25f4fb6f15c36e9b74f67887ed2f9aeb146fcd9b4b3cc37959981299647870df212b47b30222843baaf703ad732a5b7eff0043a2c87166111ba8de582da1f811a82159e58117004d31044ee5d858179ce476a91082e08259c13b086514bb26cb908e05c86297dca448526c445b74b6ca4281dac6ca32d02f933122f5b2ff00ac455465db5a154a5311a703984adef0e61f785673507b083b45a554d70caecc7b2d1612fcf1960deff7ff000a7d8a80b4447a8872b23dae62ecc1454c3c4e111995c445711209b3e6448aa92e2e372b42d8447b6e9c082510ae369edc9f62438a68609f649262292314e84d9d549b64bdb9352e49f24e050dc13ad4511b90cca31b4b0a2c9a243515232e4a38d152ae25b53120b8ba21d6d0c608e8a64c12c84cb5d64c3468b6cd04504eb6688146f6dd49012737a15a3440c53a0a84e6d92f729cd93a40bef091f9b1f7941c11f4ea9132a1629cee43843ef11a2b5c13902a9a6a3dd1adba1f55ac4d4d36c3396d1111caa81b4bb404e5c23a547d42aae3b948908d324e651cc44b238670be46baa2b3536240fdcf9adc63bc63cc229283ad8123ec1476cf53c5f99badb73665b5d06505b1155dd8fd9c1606e2d44a767ea4db4d91115b6ac0ccc6365716ea2e5741c2a9dd153343bde2354d6d44fe96c53b4967ab555a54c14dbf89f0625955f0070db486dcb8dd59bc06340507567adcab39da772d7872abc4d449c7088b48aa16d04cdcfe1fde502aece2d6f9aa7c73fd904aba6cc3bd58a3e7a6542d25cb5b15c9c995db30da7b40c1e417309aa2c0a6a79f505307993d3f34a3ee577247685de8563eae6cf281e6a6e41e5280e281a612996d1ced0ada89e4b0151f3e45729da18dc223c4ab35b3b4bb24a6762ddcd6dcb806371f271478efaae99c39536002bd52f2a136898cb7276276a5ccb82e0a777165b4170ebacecab44d3d692b8d3279b7db159c74872242570a0762f6888485b24f884b802ddd091e06eb43aed2aed22a9b352c4d92d124a745c151f57a589695b0c0f1f30fe84fb79ae7bc47c30d9fff00114dbf92a14629b8c51d539226c902305d0e1918f682cd9728a98648e42d92f7f35d14cba69d38a1e2969af25d48235d38a09f75252c36e94fbc8370d78cd7a0da6c9ba92d686a6a304b16d3c0da784111164bd4ec8616d78c51068478d20ea9f6689b722857092dd34299a4e55298e5c34d12f19a689c456525a944904b97a6c8d20b538175c8a11c8a71c34d141325a9e6a6ca0a5b6265b16765c7b577b2a289597a322b67db4860b3dbea3ee8aadd6a77dbfa4fd96975185aa3ee45d54b3120db82d4ae731b6cd4f369f2d29b60538f15a294125dba61a82524b515d7228919dd32e4103368d240bd988453321d14c805dcae7b34c6148385f28a1b06d5659e1c39265becaafba170a3a0659a5ddca731597f51ace8005ea5ca83efb2df338d8fbc2b65988e512bbd5ecac7f646448aa32bd972e2f544896b4659bb222b9df1f4c4cd133b027e66dfb2ec9fc28a768a79e5ee40f9026df54923d5710a5b07ddcdef219c733651baee64e350f6bf172c105d4ddb234786df5918cf6474a063cdeaa21b2211e5e5465376d11611f57f1f69704ade2bbb48278c878ade6488385c39bbc9b73ac9223470976ad46b11b5571c76d1e6431d6c872fb5fd2901e8f945da2b609897f4f3280ae51a245e132dd5cd0ea2e1787e4a66dd5f317960aa6fd75f9c9b725a59cc16dbb71087295c5dae5cde553735b28ecb0914bcc3c5dac4222fe0429e65e4040097c8e59177589e8ac3b315c174484870de6cad7992d4d97de18fa0bd2ac8501215978cd9bc57b76b353647cdddd5ce31c43daf9bd224acdb25b46134de5b85c12b5c6cb536e0ea1214a8df94e5728d3c17f1351f5991bae59e6d4ecce210bad160cc37a5e1e2fd53bcc3fe8b5633125035896fc0a3940b22a77906ca93b37b50edc2c4cf56f0e5ec97687b3157100221ef2a457a445ccc596d2ca43a84b98bb28dd93af38db82c3e5883f06e0f10ff003414569b1b153e465c5c6e8cab53f35c23eca8b8893442e0f0e52eeffd95ea6041c6f2e92559a849da5d94b732daa6e3949d0a65f1121ca594857c9fd36d17c12b04e08dadcd75ff00e269747dd18facbeab908fc1f2e9eeacc7f293d9627e9de12d8dce4a962fabc43fbd3d492e4935eba28f89c1cd8081b8f105f3e9124dc87c6b9b14e9c728abc58d4fb29514db71ca9572082722bb499f76582605a221f0cc261c706dcade2095a3e9b8bd31f426e1142cb4b08bd2fc373cd71661eb47de4b89c43b4ff2e98a8635f190e171bfcb51f55f45b512116fb2223cda44451f418f5d7764890071e5d28fd9e1eb88bf57f7856d231b2e2b527c0e53c715e824945777a9aa8d70e29dd229b82524a09315c5ede92704105e8a7da124cb028c842d444a0877e08704e4d9a6d882504606889815a2a1e2571112367deb46d1d48493fc0a4a7631604a54279b6edf385dd6c8924ea5cb2b345dd6c47fd4911070ae4e99a3b1ee90e7b1bb8fafe2c833a9be23969f305d927191fde9862a5365ff00ede43de9a6beec11736fdbd9111ccaa7b5db64c48b37915b779bb7ce3c5fabe51f8ca2912111b7339d61f0fc27a99aea8788e28c3c9d07bdff00f4a5aadb44ecb364ebf2acb6db7aae9c1fe4d5f32cc36c3a59766449a9673c0d9f8421ccf17f883e687e8f1aa4ed0ed0bf5272e70ad11d23f06d8f67e55cf8e314114a8e193623eb71112cb56628f9096b0903e173f85d5306e14829c09276873f7b6a437e049b95b8746db3254f67c2464db9a9a981177c28a686ec2706e1162e08c4778978e3e58ab4be4ebbae8edb9fe2305f681507a09dac1759fcdcfb9fa4339a5f10bce325f06245c405e8ed7ccb47999212d58deab842afa898d7c2d319d3b69a1ebd16031ca8960ae7b6a5badf43e2d5bd08f1003e0a35ca5b65ff00ecee0f75e16becc609a84bb4dfc0b92fff00fb6012ff00547150650b3382e1779e7487d9de94145911d326cddda1bbed4548f677761f4fff009503fd4622352e3f3fdde840a834dffe608bb253c4f7bac8454bd35fe211f68486ef6b52f30d8079b6db6fbad88fee4a75ced694f32123750a6ac63b4683f3fdac9f8bab3ce951ea7d3a5a6a67c159727a7cad66e112ebedb49ecda4610f1c7e32dcac5b5fb4d2d4e96c7992feed91f38f39cad8ff00ac7c905f3a6d2d79faacc94d4c651d32ec8f9b69be51fdf1f4aadc56aa3899934738ede5e6b4dc238354554e26376440ea4123358dec2db8beea325dbb1bed7124dc9530698deb20bb1a21b2cdeaafa1ff00271e8a9a75b6eaf54645c6cb35364dc1b9bb7fe3a65a2f116f2d231f17a57cf74a96c579968b4bcf30c1775c7444bdd25fa014e016d96db1ca2db6db436e9b5a68447eca8d532168b0eaac70e8048e2e774521f76db794479447c823f327c0bf1ca8308a7598fb4ab4b95fd948351ca9e12bbd5418122821fed40148364e045390ef7b29a6c93a3146124aec229a8477ddc59bd95d3707d9e54d3845c39beef69291b42e44887510dbc3fd49389c577abca904639adf5b8ad25e022b73662ec8ea41381ab8e99ea11b86dcd6eaef7c4b8e1eff00189095bab9bfdc9b79ed3ab55a3ece92fa13411d4438637172fb5888894b0d4dceb83abdde61eea0662371166badd5eb235fd5a86dfb3ffdfc69973490dba7295c8ae9cd0051cfb436f6b8508ec3369f5785483d6dbda1151af447515c36f0f6904b6a6a5cad2f6adfe5592f49d2989b492256e56e92eba5eaccbd6fbd6c16b6db769767311764952b6fa58466c5fb73392a32d77088b6fb8e908fd3882adf00839d5ac6f9dfe5aace71a54f230a91fe807c74fdd565b82206099827c17690bcc2f290e22610ca2877110de94a09b76c8738a48925bc287349296dd54a483572c776f9a109f7847cd8e9f5b57f082d8a8e79ad58eedf1dd3f31de5558b3bc0d1e6afb86da7da1fe9fba846d14da1820896954b42d7b93c114f8c53029c845486851dc13ab9182e422949c4d14e3048e151cda3e5e29414690274114cc50d08279b4e050de9d72090c1274a0878a526dba8b29760d28e08493346270288f16283998264228c7850a628884e30e9645b068c6e2a3988a39a8a534a8f2b510314a8453704449b246e0b63c494f7868cc7401371c6e91c1ad17274013924c9195a23712d07666822d0dc7e7139b3d480966f99ce224aaad645ad4b99e3fc48fab71a7a6be5bd89eaef2f45d8f86784e2a068a9a9b17dafe4dfee8da9d41b69b22bad1158ced4ed61cf4c8cb305d489662e64f74875e71d6c844ad6d0dd14ecd11b98e43978550cb40fa501d30b1b68dedebe6b5b495f1555cc26e1a6d7e87d3c96b1b0f2186d8f7558eaaf65b5072d1169b40c27315c55b9ac14d2333922a90c360896733316dc784b89685b56e5acdab3d916c49cca3c5c4ab1dfa95b1c63b8598e2198916ec158daca22859c245c219501512cabd074adb31a3c82e5f507c24a85983cc9b225e38a4b90caac2a3fda77a159769bc80f9a93a61a9e97558a739995964229ba8162aef0e3765946ed2015ab9b17302d9088ddab8915b4c3d592aed2dcb5c6c7510da595709e326e4c40396f7047e5b7aad5a79dead45cad4735ab94e9ec5140d419b4ae15018f045d7486b839970a52b74e17db599cdd009a7ae11e25a2d2aa7c248aa849b6e0e556b86d536399a4ed7d557d7c6e9a9ded66f654990aa137955ca853a243989546ab4a212ca8119975bca256addd760b0d7304b4f6bae7787f104f873cc5560e5eea776c271abad6f31765579221ed12e192d161544fa58046f373d563f1ec4a3ada93246db37a7e53469a74ad4e1928f9b755893654ac17291313085846e4b1688912ccba6f52a58b3740996d94f88276368a19e7d2918df54e44ad4d45e40bafa649e4d97009e0c2518fbe8271d482348282417a758cb243869870938504c9c116aa53004d992648d3a62998c10d5486d9248d2224976ae401020a74593715ddc969114d3825029b2537b00fdb3ecf68ad50b1827a41ec279b70784849336b6a8e519e32dee085b25503ac24c4054ac445d16dd1f846c4bdd42b8c2d333c42e1736cf94e43d344c366a3aab396e5524fda22a97599cdee65f55353cb91aa75141cd75d5ae9e5bc4538e450b4a2b8063d9441453ad3a26646d9e530e926e9cddcf363da5d793bb371ba65bef28f31d14da46f882ba6d346d16c794540422a736b21d60a8036d4ca30046142af3799d7564d8285d3a3fddbbf66dfbcaec65abb4a95d1b37fa4385cacfda21156b7cb847989726e397e6af0decd1f72577ffe1641930971feb909f90013ac16abbfdc96dc335c45eaa622ea2e5a03cd76a58d5d0dc8a6c39aeec88f17693a1022d5c3f8fc45310b86d21eee62e114f6e1e2bb37dae142e897888edd36f790f305fed4515da4b31692fe64936edd5eea41d5182a2a6b37e34a84a8dd6eafe653eeb3cb97bb9bed28c9b972e5f67ed126ce89c6aa4c8cd949cf93ee09783bc22d38439b0dc1d2443cb11f1456b9409f8e10bad1634b90dc237661eef67e659f4ecb17fbbef20a933efc8b97305d5916667e0cbbbcbf525c52e429538e636c55af6ba585d31741b297704ae121ca425cc3f4fa60ab75d9b7d874679bfed0d8fe94db6368cf303f0823c33403e8f48ab6d3768189b1cc36b96e92e651bb42d8dbc243c25fca9523c3b54860b69653db21b5cc4db22e36e5d70dddd5353d3625a752f9ec9c72953788225e0734e5c243a597eeeb5a2e512f2c3eb5afd12a2dbec89090e9d244921e48b26df1341ccb95b6ae6ee11feaecaae4652e1b79730f64b86dfa3d2ad934436da4f37ea90e55164c08e9707da149213ad7e888d90ab5d70b995c122173bc3f763e58297a905c256aa5cc9e13c2e895c3945cee8e92cbf12b4c94e090e62479ba269cdf15c2849a8909090ea1cc8d7a2d3ec9625a42e0909091730e9248aa3799478cb8915d68ff005241727800e1aaf967a57d86768cf0f582f4acd5cecbb83970caeccc176a1e5847d2aa8db97362bec8db0d9962ab28e4b3e37652c12e2176dca43cb9857c7756a73b2732e4a3a2424d95b9b8878495ed1d4f35b63b8592c4e8792fcedf74fd0f64b688938114344d3c315315527422879c8758c95ba5c1fb43a53e1142559c210121e121d28da7c49320bb485f466ed3695d9474f7549ecf47ac73baab74f99bdb64c789963ff6c54eecf3dd639dd15ba89b7b2e15592656b81ff355611ff6aec50d72744d4a2d5482509e8126c8d36669b89a2ca941e11011b925c349877934311e2e647950e6047cab5c45eca5be6bceb968a8e71cb924349d513a40175f3cda93ad908f120a1ddb92a61db44b2a5e544651b04dcf3fca96c9dad8a8837caeb7dde145cf3968e9440290e75806a3240aeb893a669990d036e5ca85ab3e42d95a43a4bbc97600286ebc9258280da6aaeabb2b2cdce176b0f57f0841622fc66ab336f175622d8e5bbcdb63f06c8fd3e98fd31573e9366ac902cc224f3c2dfab99c2fdb6a07a3095b6484edccf384e17744ad1fb2b2f894a65944676b5cfecbd07fc25e1686ba7bc83c201bdb7b0d343e64eaa8cc93acb84c3ede1b8256f2ff00b87e22f4a90182d1f6cb6646799f36233023d4b9c5fdd3bd98f93e659548cc38ddcdb8399b221f67f82a49a22c2b69c458049854f949bb1f7ca7d3a1f30973929710b8d961b83a484adf5b2f8c4be756ad9de946a7236b6f8c27981f94f3a3dd787f7aaade44bd72382a2484de3710b235b875356332cec0f1e7b8f43b85b851fa59a53e238a4ec939caeb64423fe2078ad56695da49077cd4ecb39fe308fda5f3452699e1951a7ca5a5fa54d4b3056e5ea9d7c44bd6c3b97d7358fc8de8a645e0d52a94bf289603c3ed46108ab88f1f95a3c4d0efa2c7547f0fa8de6f1bdccf23623f3f5505355995686e39c956ede679afe2b3edace97a518121938f85cc7379b607bc45e373e882ae74cbd1952a953edd229d509aaa55aeba709c161b939160448885d218c638c223796f8ee11f2f9566b80d13c5859996728b8436e310fc25bc3bfcb087d08a6c7a570b31a19e7b9fc7d12e8b80a92176695c64f2b003e36d7eaa42b13f33507fc2279e270f84748b63ca23e411f9930f1ae9ba8475d548f739c6ee372b6f142c89818c0001a003403d02e112e298a36cbcf4df9a972b7e51ceac7def1abad0fa3011cd36f5dfab6ff994692a638f72ac29f0e9e6f75a6ddce816774e7ad7e5c87e0de60bd974497df720edcdb65ccdb45ed3424be6c98d96946dbb5a6474f10add36127f164254bf522d7fcacbf75574d5625d95fd361aea569b9b92ad46ea21b251e048a61300dd3ea401cb514d44850303eca7e05a7ecf3230eb24108b6cae5dbfdd4c09651e15d85dd9eea3ce8b2a72245c36eacddd496e16e9d3724917aa9923b6ecb7716540bd2c353a0571169d59adcbed2432376a12111badcda85223c5dde6cbeca761ddcdd94b6b9288b2eeed5ca23c48616faccad8e9b88bb45cc28922425c2444375dc594b308f0dc8c941a4ae1908f0eacbfcb6a65c73295c3765fc5c9c988966b4b5661b874a15e2ca45dacc8ae956ba05d6ee2bb86d1b47eca1662de22d597fa910d9652e1b50ce396f7452538374d1c730970aabf4901999eeb9f75595b2ed7e3854074991cd2a5d92f76d5a1e143ff0098b3e3f62b25fc411ff92cbeadff00f60a9714b6d72d5edebb1af351d5353a568dcbb4e9ab8531553b408b9454250a7735b1e24cbe5caf03ba971d3f32227b2b53a48731445970a5b6ca79410e0d5da3ea58e6d69dd3b305fac25b446d61979d2f836c8bdd5853ee623847cc444a9b143e26b7d56a386db72f93a68134304fb69b80a75b82af685a6714e412e0bd082f290d09a29629d1826c53c09764d39780514c4533b938d41001467a3f72536bcd2eee4e0509c9d84534f412c62bc6949a1a15e963524c9288047cb9a5b4a44adea8938215e822a314c98a514cb4d8a69a47311418c112cc510452ea8c145d326b0dcb906114a28245442268cb0f545475069a66ca3f94aba39b522db368ea5549b9a274ae224229cd9ca113e571656fed2cfc185516120d4ca751b13d3c80eeb5f3e37886365b4900ca0ef6ebe64f60a3a9bb38538e0dde644bda5a952e41b61b111111114dc9b2db4368e5b5426d1ed15bd5b799c2e15ce719c57db2774a741d0797e574fc1f0d6e1b48d889b91ef1ee7c92b69eaf6961b7988917b392e423716a50f42a611162b9a894d5527c586d53192e2e745741d9597769fb050db7b39c372af51f3b9aaeb526a8f139d6966146d1981ca4394b8944c1a46cd89467fe6583c626e69739bb29a7472a84a9929b9b8e555baa9af44d30b9580ad76561408452dc8654281a221052ea7fda77a159868b3c5fba448b9995a6986a9ac12b0522612ea99717565453063ac548ed095a372a53d399bddcb97feeae15e2ea4967adbbd61768b9732e21c774dfaed7f92e81853eedd15c28354b6de1b752b84acc8ba2b2fa740ad2121b4878b84bbca7e993b87c5fcab174f521872396b682bcb3c2fd958a6a570cae1444954edca4914c9ec51e1519b4862d712b0bdbc415cb9c00e633656ab05d6ee54ada26c5b72de25c676a70db211cc4a1e2e9ba44e399ae5b8e0daf7493f2c3b4583e329299f4b9ede2ba5c4d36e3a9249b2b575472e48354d3ae1124834964e08a16627136481a94fb1a4e8022b788a65d9a51ae4c92608c936651d14a6407aa35e9a4238f24082741945e2727835ad4c406e4e8b4896d94ed88f220643d107065262d23a304c9a1601004941182662da2ce28574d05258997050c704eb848670915d49605e8924145712845029ed97372f5a97082e1c6d4d382174d941053131ca933331125e97974592dba94c6068bb96d5d165431e9cd8c7ce325845dde152f3b0b4967bd13d4b026f08bcdcc65f5b8568d5f1b159d0cb76e5ecb018c5372ea491b3cdc7c77557da69db4157a85278ae5c4bd5f7c8dcb54e6ce4bd8da47fbd2f905340f66a6d37729369ab46d15c34e126ce2a795500dca126890f4e98c3784b949393104c34da8b20bab081c1baad1f68c2f65b739845575a7158a521894e6fb395560e36929342ebb329e899c4e3064cc3a8bab86c143ac7bfbb11bbd653d33f7957760cf7f8466f90ffe653cf47f1f79720e3377fe64ef203ecbd0bfc36665c1233ddcf3f54d8b9c39bb3dd47cac3b597f170a8f18dc5ca8c64bde5945b970522db99486eb7365458345948bb2809512b7994a37022460a6ca7adeca49348969bed7f4a588faa9564d66b28d7d8bb84b2a0a6e4feca9d26d0efb09a2d4a6bd555ca7ead5eb28d99a7f655cca4ee4c464aefc652482d4e091518e9b6e6b4aee61ca4bb0a6116a12eedcae9e03d95d849711241052848a9e348e61baee6cc3ef7125948888e91cbc3fcaace52fab88755a9a848e62d243c3d94a00a2cd755c848365a5b14e9488f2a99725ad1f77da4d8ca15b6fab6ff32328d41c657fabf9529b6c874910f654c14b90dc84986f50e6fe5249b25008784d1f3654a69e21ed27040bbb6f657a2cf2a08c84f31339aeb6d58afe527b166e0cbd4a59b71c26faa9a16c6e730b50bb68f8fc5e45b13902ef25326e0e94fc1298dd9828b55009a32c72f89c5cbbbdc43a487bc3e54ee22fac76a76129552cd332622f7fc433d439ed37e22fad67b59e809bff00c9d49c1e56e69b177feab7e3570cae8cefa2ccc9854adf76c7d162c2629aa847a92b495f6a7d0ed718f36ccbce0ffe9de1bbd973c6aaf58d9ba94b5c2fd2e71bed6093a3ff004f7a90d958ed88f9a84f8246fbcd23e0568bd1ccd93b4b9572e22b449bbbb4d9717aa42ae9b3ce672d3e6f9bb42b27e8567ba89a967089bc1731045ccb95dca594b77108ad3686f08bc36db9ae1d42b7587ca1f1b1de407c9710e21a331544adb75247a1d55a32ae4636f0ae87aab9692b558bd534eb85dd49840b99373ee3e198258a647b2f08b9ea89ea50b31b6b2ac15b38c4d481733ec1107b6d6f4d3e5633de36f5d07cf65361a39a51789b9fc8589f9037fa2b1423de24f4a866f7947c856656686e979961fee38377b25ba2a4a532ea21f685381ed22e14796191970e6907b1163f2499976e2cc49a89f28a666a6444bce097ac920f0f35ddd122fb304874ac6ee404ec747349eeb09f404a241053b77369e5d29d71b32d2dcc17f86496147992d32ef0f7ad1fdea2c98852b3de91a3ff009056b4dc3b88c86ec81e7d187f0a2d8ccedba447de4f544f948b56615214fd999bb8889b6c44b99e1b87d51458ecbccdd762323de222fb2a1bb1ca168d641f0b9fb2bb6704e3123816d3bb6eb61f7418988b7c5a543557cdba568ab796cf3e43694d32df6859bbed450e7b125a4e79c21ecb2d0a8d2713d06c1c4fff0013fba9d49fc38c641cce601af570fd97cf7d3495acc9b7da71cf5ad53fd1ce1c6425c9a704ad1b5c1e26dce21215a756fa1ea6ce61f854c4f161dd6e190b639bba9ba3f42b4a942be5a62a4cf35b302425de1ddb966a7c6a074c5edbd8dba2eebc01154e00d0256837043ac45c5cdf4eeabd012bb55d75ab069d808cece066caf3bf697d6e5b0527ff00113dff00305403dd08d0dc749d2f0c271c2b9cfd22db889313e2b0bc0b5fe5fdd6a78b2b5989c6c6c20dd84937b0d08f25f3491a4918afa761d0b6cf8ffe5e68bbd344945d0deceffc0b85de9a7546ff00508bcfe4b12dc2263dbe6b3ffc8f3a3f76ab5c1a9ba2432145217f4f9e9b2bb025848bc5e2baf2f8b2adabf295e9fc29f751e8843355c98ea09e6c85d6e9f8b9729efb4a6be6f20796284a3ecd48c9b3e0d2cc9332f711608bce8b7716a221df0b8a3e4de9ca76cfd3582b9aa7c9b65cc2c8e266d598bc7e3f8d36ec4983607e8a4370394eee1f75f3056a4dd625dca7c9b73152a94f16256aa8c8bef8966c5fcdb2ce6edc6303cce3bbf3978bc908a6e99d1ad6dd11c3a6bcd8f33d6b7eb5be55f5eb0e088dad88b63c22d8888fbb05c289170977532ec49dfcadf9eaa5330360f7dc4fa582f9aa93d0c3baa72604799b6757b44ae349d859194cc12e2e17ca3998bde5af464db2d42a3e7a94d72a852d4cafdcab4a7a3a787dd68bf73a95468b7f8d2b82ca94a9495ba72a8e3709463753f385e71a1565e8c260701c687e0661d1f55dcc2a9ef3a56f2a99e890fae9ce5ea2eef66fba9c8f751e6d5ab546893ec17128e6dc1e64636e2782876524cbc29e8cd0fabdd51e0e0f2a7451dd283423bc206dcbef258b97692d5a50b02b7b49e02cd765b7de42e8cb4744e9f7525c85dab8bda4adfc56fac9b7a39bef7f323ba20b9bcae2b872f7b5779289cb74e5bb8b87ba48571fcba887b443dad29406244578e5d25cbd92b529a5196a5c1cbb2e924998866ca2225a48878bbcbce17aa236e6fe5eca6273bb988b377799006c8c0ecbbbee121baee11b930f5c23ab28ae38ef7b570f2a4047565ed7e050cc8ec8075cf7936edb94938e98f08f3265f0e1e6460a5a6a4c6e2bad55ce92a3fd97fc5ffe35689468aee5cc372acf4a219a5ffc5ffe35a0e153ff009933ff0097d8ac8f1fff00fe24beadff00f60aa0315e8a6db8a737aeccbcd04262718bdb2154e9c662c38af30503b552b70e5512aa3ccdcc370ac30f9f2bf21d8a97a1ce5e0a6a4c6e2542d979cb4ad25a1d142e4ec12e665d42c429f9725bbaad74b750c0a7900ea982b7d51d4b1661d578e97ea58f3b843e6e5c70bfc4e2fe0a86616aa3a87f32427e1f25bbc1294434ad69dcea7e2a49b8a5041052eea35b24d86d94c7b484f8c1757052d48684c95e14fb704cb6886d28a69e9c08275b1490827c2080519e510c4538629961124961447a6e115d8a412f422941376483444b9a60d25b241288b852cd92e9a1983444229c511cdb2446096d457570512493a231a24ea19a8a7a114a69515c13d2d6dc372d068d3cd8b7c2236acedb6ee21b53f34eb8d5b9ad1e2fea5cfb8f27e5b1a4dcdba2e87c0f5ac833dc6a7e65582b35ec47309af6b851b49a38e5370448b9955a41e1c4bbb4acf355910679897318e4128e63cdbcbb2e994d50d9019243b6c3a0feea5276a2db02a9157a993ae66226f9794937373773824e5c4245c2890680ae1c4c41e5b6d707dad5f4c155d6e219fc2df77eeab6bf11337863dbee84667c83508dbcbc24a5e8532db9a5bc32e21e155b990b6e1b8b0f9854aecbb56f1777baaeb83e9dafc418ef8aced7bcb613753f507154ea8fdc4a6ab2ee555c7c57a2e923b0bae758854e67e409b6491467950ad369f28654f55db96ef42ab4019c7aa71b6148c885a49c0974a6a1991bdf70a1b2625e3d51b3f1ead52a6e16b970fc26a1e557599f36a913ae75856f0e6cab91f1fc1a35e174fc124f0a781c2b8bba2bb122bb35c425ca5a5354f78735d974fda4cc660b12ee2cd95bd36f3769729c86e55fb8f552ccd58a586dece52ed202a138e3ae09116ab7d5fe651d3ae91619e62ec96aef5bc29d83775dccd8e61fc71296d91ed65afbee8fdae40cc9d14832038a2d8e6e62e6561a8cb8b6d888a85d8f96222b8b8bddff00ed4fd60b8574ff00e1f619903aa0f5d07eeb09c4f59b45f155c7624867231463b04cb905d35cd597639044d92445845c6290649bc81480f286f075dc115d2712226940009d05c52a00bb04d11a4dc9574a01117ae4493024bb13444234b334c386926698324829d685c70d0ce270e29b38a4eea4b021dc4d4609e24dc52835496a4c20bcbc90e396a5592c02528ced51b32f5c94f3b72f36da491652636066a5725d946802e3409f104d109a924ba54bb84d9090ea12121ef0ad4ab35d17e49977e1086d70795c1d5fc56692f2f72999ceadb10e6e142190b1c48edff65515f13662d077052e98d623972b6b2368daa2f6725b25ca60159d34795b7eea8aba5ccfb0d82ec629b34b8c52630520a8210ae0a46e4f1a6c130e521a55fa870fff001deb2accc8e6256a67ab906c798557cc13943b13e68f117e5735bd80531d1cc6d298eeb7ff00c8ac2f169eea84d8b1b49ecbc23f694cba59bd9f65723e3316c49de83ec17a2bf86cfcf81b3d5ff7491d436f2e645cb9dbdab508dc51acb79bbcb28b6ae52c175b70ff00b9494907f32025a36f7bf1a549cb06540261c518029787a52598127e10e6ca9d0a338d9378691104488af6e4921273a130b9926ce14690f12e44524847cc40e1269d646ee55236a4407b293952c3d0506050be0b9bf16a91302d4b82dfb2859283943b8d777d5497203de1f794a381d94c7835daad45953a1ea2a2c69e52ed70a4bd0ecf129236386d4dc19b750a22d4acca35f60b296a419b7994bb9043831c48804a054513777aa9968094af83662fc654d41b112cb9bef25591e641c6df590cf47dd52641a8887bca3df62e2b74a4bbc9009b6dd2b9182f970921db6785281921e2d3ed248466c9131252ce79c979722e22265abbdaddbd310a1c8ffc1cbffcbfe54641b1d4bc1a93ad95edd891f129875242ff0079a0fa805051a0c9ff00c3fb24e0fef4d1ece4a7c9b9ddc673f8a90212ef0a4d83da2bb87953c2b6a06d23bfea2a21c1281c6ee863ff00a1bf8410ecec9fc997ff00c877f8af476724486d7192707885c79d21f64a3b91c4c08f0e9d4943cc287b7547f5bbe6518c0f0f1b431ffd0dfc2af37d1d50c4f146992e263c624e8c7dd3829d629d2839465dbcbd9fe64fc0570449326a253fcc7e65481414ff00d0dffa47e17b05b1b6d659f55b1fe08869db47847d54d4bb7771259b223fca9b2e27729e1131ba0007a04e13abd079360cf6974d921d29364ad024bb1bb57b49889169cd69694634397326c65cb30eafba8200a6b7fadde4a68f4f0f2db987d64b0972ed2219952b52ec89c421ad5c38db9451e0d249b168e542c919ae81cdca9a362e52100224e782f2ea4128051b1689326d972a9d6a56ee5bb94b8974e56ee1cdeb208ae02831673661fe54f8c9dda46e152e32c23a851b2d2c3f27eb23ca925f655e853cb872a765e44fbdf655ad895eea2232029c0c4d999565b901e215c7a447947ef2b0bb4ee5d5c2951902211d3daca95912399e6b3dadd2b2ff004aa2d46489b22b6ecdc3c2b719fa7888dbd9fc7ff4b3bda7a6f74474e54d39a9f649759e3ce15d697f52b1746416b0f3ba71a6087bd8436a12a4d652b8748ab150a54589665ae51b8bbc5989242709b956168beca201c2e6b9450b9a757e3eea32561cc5fd3dd477ba22d0a565dd224f07b5c4577dd4135ed23c63d9402246325ecfd94e866d5eea1a5e395104e0e5e124b051109d60b296ad5f8b536fb9cdddd2bb112cb68f17e34af1c3315ba4852d104d3b31c3c443c5d94b8b76e7ecda5ca9b7e1c443a74ae45ecd6895bc5de2e51ecda823b7644bd1cb765ee9694c3863cb77125391cbcb70965eca0cc844756ad2288844d0b8ff0017bb6eacc8423ed65e2ef220a39b328e7cf874e6462c12938f00db950b03f6bf16af3c79b8b28faab91b4ae1e61ca5da1468c27e5735b72aff004979bc1ffc5ffe3534c1da56ddab52adedf3b738cf2da5f6bfa568f841b9b126f9071fa2c67f115e1982480f52d03e60aa8102e27dc8264a0bb2d979ac1baf422869c0b86d44249c111d52da6c6ea98ec309e57c94ae0cb539e992d4236b63cce1691f6bc6ab1b492be2b9453b73b2d65d944aeb7b4aaa471883da3b68af5b136a3239dd08baa94c191911166222222f590ce02927a50850a60ab5841d96a83aca38853ec3894e026622a43427ee1c149b269cdea319791adba9d01477b084f8a7db24389274228ec98704604510dc506dc512dc5159447845b4881418389e034a0a338253a298449453068d3612932504e8af10a52306c96c1231b251c11463048c14d48dea8a5e5c82ea3518a5b4896e28504b71cf4711200a69cdba96a26672e5293929885c3da5194f1b047de528f42e1594e2fc3bdaa91d6dc2b4c0eaf975007455fa9ca5b9982b487879bba5e45d7c489bcd769f6513099102c22bb3730a7c223a4b32f3dc8f919e07742ba897666e88426c098b48b30e612cdc3dd5c71c1b6e12ee969b7d64fc4446e112b7b28574449bcbeca6c1bfcd263ec512dc39adb88751717ee5234b85bc223dd55c7c2e6c6c7072f0915aa7a8b0eac5741e00a7bd639fd82afc61c1b1592ea599473ad2959a688925a9322e15dd63780d5ca6b03f9a4d9446126cc54bbf296a0de6909df789d6ec531149e317eeadd09115e6a93c48d124e0bf6aae32bfa2b5a5863cc0b8287a9ca5a2a835d66d171ce52b7ef2d2aa2770acf769a1c25a6e58be3289d25287762b6985bd99ecd5032637895c56dc425eca74e6b0cae072e11d24436e5eea69f6c85bcd94b879ad2cdf6544baf6621ecdb6ae4ed8f3927a2bf7123453136570dc0e088966ca59bba9e8c2db886d2bb878bd615160204d88e26522cb76ab8796d4748b424e0db691117b22296c80bdc183a9b6c92f21ad24f6577d9962d6710b89727091a71b5b11516f92f406074429691918e83eab9462d51ce989f35193d04336e23a660a1a672ab8253500cc2c51c6da60da433550e6448cc09245d48e516a1cdb4d14114e121dc4764e36e9bdc9115d28a65c3469d682539bd248d0c4e26c9d413a234f11a6ce29a89a4c5c48b278312e29b722924e265c785009e6b0af1c536469a37937bae4eb58a4b63ee946ea15e244460862cc483f409f8c04a64112d8a4b628e93972251dcf012247a4b4d299a7d2eed49ea7c908e6252adb8a0cd313a3508e30757fc9724a4404bbaa22a2573fb94ccd1e1b645cd9540b45bdc1ef27606da317dc9bfc3a2aba87074ae2dd80b0578a3b76b429d749264e36894396d4c3ee6657e34002c9b8173c94fc229514d3314fda49690742839934aa2b188f363cc4999968959b6064bae270b488a8929b0254d800240eea67690acc36c78454209276b7397ba5de4281a9d4f1648c055f5eee6484ab16c83c388f0f337f64854dcd365c3a9567653fb50e6b7297e3f72b83d1f69721e3a8f26200f7683f70bd13fc2b983b06ca3f91ee1f300a01b85bdd2caa465a3a7947daca828a3588dda7bdde58d5d05ea6598db9b572a90977147ca0a9269b4b0a338846311244b71f650cdf0a240d381467a76315e14981e55c38234d5928c520d28a3726a288d929abdb972305d04db977aa892c6ebb1495d8c72a6cc34fdd449490599364d8dbcc9f72d4deef6504aba64205c29032e3c5a9136da9b77f177dd494ad4a8e36b310dbdd5e195e2fc5ca46cf692059e6fea4564acea1a625cb9adeeaf419b6de652c6d5a98759ecf6904b06ea38dab90c32f94aeca5d952e41a7b5f6934f35695beb24d90ba8a8cb2660d6acaa609ae1fbdccb84c6540b500fb6ea2c9ad3da4926bd55264c090e5e54dc1ab72f750ca8f3a8f36f87f1de4a6dacbf8f6918e4b7da121fbc9519742c8f3208658bbdccbb0962fe547c1a5ec22ff6a30116628416b2ae425ee1ed0a39a6538cb76dd7715a925a939d460319aee224e38ce612e55242c8fbd6a545840352b3a085a5c798b854a3ad0da36f752db651d9365ea3703dee1e64a8b1ecddeb293163dd5e8cbfad766432a467519196cdddcabb0632fe2d5246cf65742de14ab219d4741be6ff00726df97fc7329471aeca65cc3f691592da81111bb4da5ca9d84be6fb399118225de4e332a3c428804a2e5c09721e112e62bbf104536dddc296cca5ba6eeea31a679852c3530e910c32e2b832e3c4577e39451f8229a7216f08dbda246459361f74c88872dbda14e41d1e12fba86987b8b2dbd9d5eca86ab569a6b5396fb2925f64b0cccac3099cc96e4c7687bab3e776bc4b43770fb29a3da6992d2d88f7b577910912fd98abcd42a0d8ea2b6dd42a8db52eb64395c1b873201c989973ce399788474ae7810fe35222f4e321caab136d938436891096ae121cca6e56064456a35c964e312d6a4ee9e02c912cc90fadf8f651ec336f2aeb2ca2d9691d924dd3acb68a648bf1f6934209d6c39518082203569fc7325b71cd9aecdeb0a4840b993ac694ab209d8472dba4b28ddcc9043aae2e1d29111cdf8d44ba6de5d3a7b48d2529885ba74f296648202cb9b4ea121d49401a75166d5fcc2913b11e27355b6f69047d571d3b7372f0fdd4d462245a748f10e9b9125eaf7bb3fcc81721dad5abba948029971c1cc3c4a3df2cc396dcded7f541173a17764add43a900f95c439bfab99213802f4c1737b28602e2e1e14e3b0d45c2568a15f2e1464e88dbba3e5a223eb2a9eddb9d70f65bb7de256192222cda955f6ac6e7cbb223f656bb81d99ebc9ecd3f70173cfe29cb930a68feb91a3e40950f034db89bccba715d76ebcf01b648225d6e2987a292c3a9374f64b848da06ee6955a8859c815b6a71b87776495200ed70a3da55d59a3c156f86dcc4e6a91a84a8dc4a0a7a4d58e6237089a8e7a2a88b4b24207f816b2190490b49dfafaaacbcd218c14ecd08a8a7854c63d135d63651f114fb71487a0bac92951a907508807110d388680a5413c58a3b802a45a34409a8a1753c1309b2d21477c451f07112dbaa2c5d4f0ba88261d129507579c24003c9d83a9574c98d3e249e18a0e069e68d1a69cc4b2827d824c9457849253645c2946e296a3633e01a8902fd6c8cad686e2e64ace026db4af7ec3e2a62726c43bdc2288a4b25acf51691e55194a90b73b85739f654f328c79a667b346466bdcfe11ac9297962caa19a47c9b899a98c48c2d3d54381c627dd0b546847317aa49a819137ab4f0f37751f53865510276f7579cb88e87d9aadcdf3baea9864e65843928dd22b72e6e6e6ef21a6619aebad2f752999a1241d40c884553b186f6562d2774dd3df122d39bf1a55e367e5b12d547a7cadc4397da5a1530b0db115d538129ec1f28f454f8bca05aea6a32ed88a68c450e0ea73117450d21636ae4ce76b21a699511372ea71c2424c0a951cb9775415315ce9ba9089a65c7d2de0403f0249680559b496a5baf288988b78844e5b9472910ddee978938fb8a1ab6e6525558fd109e8ded3d8ad061355cb95ae0ab75f684a6ef12bb97b43dd51d32d85d906e222d5f693827c4637137708ddded4bd28de6beeb87517adc2b85e531f87fa745b37bf3bb32e4b8908dc16e5ca245c376a531b24038fa48bb5da517bc0f2fbaac3b1f0d598488752bae1ea73515ac6dbadcaacc5e73153b9de565649e75051825b91b8979776f745972f8da64712508f0a8d99152d310519308daeba94e8f2daca067e5b954594c902b2be2a227a5ae41cd5654d303a390add593b0a98a8d7e550d16d22e429c29e276a14e14f8a65c9d1511864b9848f314a14ac1d54894d8a68a6c509069760ca50ba7044c09e29c4d94d457b05285a461a956604889c4978413d004ab53ad0022cfd937005e28276d487012cb80405ca1265cb5352a3e94b7219938dc14791f7522f66d910c0a9496221414b0a936014722eaba692c8b95b894a4bb686926d4ab0da87294f53f9a8fda073f471ef2afb4e661ef2b0ed1cbef68b98730aa503f6a739960df4fb28ac86e5c3ccfd5691098dd867d9b4d25c3cc80a74c5cd0f7579b7f715a5c3a7b42ae5b22a0306a476536c29511caabedcd8c2d53b12ca2a531c0aaba9610426661c564948e04b729383f6955c7ce0f688559ab911eac355a229a700e78076dfe49e8ddcb8cbbaec3e2a09d6489343188a968349975953c381d95773ba145ecd4d08ccb3fde08fb5955da61bb6e2e62ca3cab3861b20704878484969a4439ade5f74972cfe21c3696293b823e46ffbaeeffc22a8069ea210762d77cc5bf640328fa7166414239bef23e542d5cf5abad3d4dca0e5caa4e5db251d20636eaeeff3292968da3eea70286f4f042d4fb629a234a034bba64dca76293bd737a6ca2288b900139bd72049b8af0924928f2a5c4d26314984570bde457460250aee95c224db914a050dd72199737250f792c628256c9b3869b922028828a6c46e410052460b8e08dc97b9721a9043cd356f0f324c43d6f591560dbcabb00fc123b219d024045d949702ed48d2b530db59757ac92425075d0e52f9b874e643b8df689491c0b4fb490db56fddfea46881b208daf76deea6cc46e1e252965dc2924d7324d900e51ef34bb09747882f45ab90010cc8769a4816ad2e64641a5db337aa94024e642352bf6aef597465d14d35fccbc43fd481086629816f3270da4eb715e8924d90cc53306b325c03eca49453bc28ec812916a4463c2962490e446efc7da4682e6ecdf8ccb8eb7da498c2ed5c3c22b80c778bd6412ac963de5e8363de25e83dab4fb2b9131211149469c8447953ad35c57126593e6b53f0738ae4774928802ed12f63fe2e51f3b516c352a2ed2f482db644d4b094c4c69c36787bc5e46beb4464011b202e5a34ccfb60398ad547aff488c36e61b424f3c3f27d617bbe21fad520989b9c2ba6dc7047865d970adff15de2fa94bd3e9a2d8f56d8b63ca3f78bca5f5a6cc85da290da76b37d570eb1507f51783b65c3e75eb7bde4bbe74dcbd307515c45cce15c5fc148882720da20d013c2c856e553c2c5b6a25a04634cf650444d90acb0942d665252e36fac9c6e57569f5b9b851d9379d00c49e5cded71279b96478b76af585cbc5c3c5da45628b321a0d6acba7de4fb4d652b5152ed0dd9b57babb16b365cdda46116708611bbd5e14fc204b80d16ab47f1cc9e01eca55d2935bc78bf1da4b38dbcdab853830d2439bb488c3fc70a55d2094d8dbfcc9651e55db0797fa97a01f82e54126e2e87742ee22cbc2936e62bade5449447bcbbbcb97d6460219d0af5b695da479530eb63722e0cfdab8ade2ef21e3c5cdc5ca97608c151d390f6b8546bd0bb2fe34a9736eecc436dbc24a3a69bb74e5cdf814d94eb4a09c6f9b2a15c80e924f4c96abb366f650f98b2a4b8a7004ec8aad571cb9f70bb56fb3955a25b492a5d45eb9c70b988bed2ddff000fa2bcd2c9d801f3375c97f8bd3da9a9e1fea739df216fdd22243ca99785326e2f1b99497522e5c29ac21474cc508c9e649726c4ae409bbbfc43a8b57645457c815cc501b58a917e6378ba7c36da0a984e78d58aa9316b05dd54bc6f1aadad975015c61d0785c55d24cff461e6b9474d348fa733b986f9b51244c028329bc9f01f65634e008be27eea01e0404c029898151f3029e68498dfae8a29e04380a35e821a304f35d6562c7688869390821d931bad52632c9e13b41b128185c45c041c4572c4545a5cc34e9702982484c2ee2453a40916a4108ae938c4bbe124bb11498824d90f0aef8712542a249bb17a0d241ba1959d93b1a9926ce6cc97b0d112f2d722d4a49e5b75b21d997232f1ab0d2a4841372ac08a9262296d680abeaaa4b8586c8b6d1d2b04036a4e5608dc745591c798a28053804b904882269ba6aa63b6c9f9e73ab517bdbe1f651efc2e1501503cbddecae3dc7b436a86c83aadaf0c4e4c65a575eca45c486189138242436f15c877df2d4999872dd239896159195ad6900ab2494ddce5b6e51e25616a6152766c8ae215686a2bb7f06d1361a06dbf9b558fc72a2f29f20a61a9844b4e28e94152b2cc2d33ecd597cdcc3a256f42cde9252040829d1caa2ccefd377a14cbe339c7aa9571464ec516e1a8f9b8a9110d53933eedd1444c9a89ac3773642a4e6546cd9e5522b22cf0387926b0da9732501ddd559c85d769b5bf5447f98a283f0e2b9ccb75bea8dddd47cf3624243a48884b55a2a3589175cbaeb79ade2e5b8bf8af3d54b1ac99e1dd0aea311ccd16ec98a536443715c4575c3fd2b42d9f6c706e11b6ed43da5569169d13d2387944487366e2f561f1abd49336b622b6dc134d9e674e761a059ce2298b9ad841df529042bc209f28268a2ba53a4bace434a014c3f0517322a51f51b32898fb295253e60a35e241bd144cca01e34fe6519b116943be28170116e9a60e2924a9d1dc21a305cdc9e8a4ee461480537082ec0538229d00477b2534129816d3a0ca245b4e8368192ca4320ba120ca71b974784a95b7229897b44aeb4796dcd9bb443e2596c5b8b69687c37ceeec3a7aab1830d2fd6da28d6e5bb280aa0915c0dea1d4adb2327986e7046d6f13fa50f6dc4568e670887bdddb561e6e3ba8965f0801aad1940c636c550db6add48a605135095b48932c4174ec36b1b550091ab3d56c2c71051b2ea4a5e0a3e5e0a4a5c54f5493952723152ec284622a5a54d479988a967b1b14ecfb373642b33ad4b934e172ddf815a844956f68e445cb8add5a87ef28c05c643ea14d2f0c933f43a1fca8fa0cef5428e9a70495665ae66e18e82d25ca96fcfdaa5b2a32b2ce4c4b479a4ccd53f4d7489e118f32bf142d11eeacbb6626089f15a638e2b1a09333495418cc45b2347926e11cc3de57fd98a663962972e5ef2a1c9cb13ae880f112da696c604bb61c56daa9b89b12f6580db73a2d0f05609fea156dcc2ed6104faa0e7288d39c3eb2ae547671d6eeb7ac1e55a0c8b17279f945cef0ee28ada53ef676f63afcbb2eb98d702e155e2c59cb7ff5374f98eab1a79921ca4243de57596322644b849b1f5b87eeab14c6cfb6eea11517334f160b0b35a23f6b365561c438fc589d3300696bd86fe56235b155dc15c253e075d25de248e46d81d8dc1d2e147d9d67b28a12cc99763c5ccbd2a7978963da57479029b9331d4a61b78557258ed52acb83decc3eaa55d46732ea480d2b110e45ca94028ee9bca13e4e2f5e9b114b80a08ac12a249610488412b7a0124aeef5c866bb8978a0bd6a3212578209a80a5142e498c500949c187aaba514d462bd140a164adcbdbfb49b892e6f1468ec9d38ff004f652c21ca87812704c9049213d01e65e22f553108a48c7d642e8ac9c2114988e95e15c33fb28230ba515cb8532d970fbc4bae0ddc56a082722e7abc2bbbbd64389fac9cbd114765d8655d81f0a6ccd200c78b5201127a314eb437266104a177bc94929f3114d3d0f79784eed49a75dcd974a0929c84522249113e1f6974623cc8ac961777faa29445fee4cefcddd5c8c34f15bcdfca8ec94940244bcec171c76dd56f7bfa52312eeea49402ec0adcb95262f8dd6e622f7571e8f16a42c5dece5ef22ba50174546613119e1414d4cf296950b3f546db1b88b4eae51f5920b93ad8eeac719c1d4a0769b6b98961eb0ad22cad8f11172b423e32543aa6d93b3244dd3db272dcae4e1659564bff0090be6826689b3d6bb8ae914d4d10dc530e169e6c06bc8d0fd09b3227db000a427a667aa1a88a5657947fb439d922f821fa148d2690d30222d3623cd9b317688bca448f92608735d77323c03b228804a71b6c856db450b49f659b9122c8f0a7004c9720a0cf66efc7da4a16b9451c4d92495d9b2db697b5dd4680726e565d14db4294c066b7b2886c7b5eea16492e48080a7c1acc920d5da51430ca48ec93743381cbeaf6bb2b8d43d5e1ca9e28da4595744331166468c9d1396dabc23ecfd95e74adcc594529b2fe94564d95e20f6927f16a762e72a68f5715dcc8ac94d29d0493d49302cabad3d717752ac8259c3492503998b2facb844bb07491a4d9701b4e0972a68ad2e222eea5143d9e24e048292e07f52413568f6514e432dda8797993701d3951d90cc829863f99444f43b3f8e61563778bb2a0a7b2f0e5fb290e09c6155c9e85beb7bca3ef2cca52a5a72f328b6f57bc9a729d1231b730db708b94b2f684550dc356fad1dacb9ddd5deca45ef2a2cc4ddba7da5d3b8121c94f249dc81f25c3bf8b33f32b21847f234bbe67fb2f3a69375c25dd401ba9c65d5b7322e5c22b05539c982170861cc88953dca1368262d7c934c4fef54dcf01e415aaf652e8c11d948ed14e757bb9944d06589d707944bf02b931027c8603e6c78b9895ae83262d0ddec8f2f6bbca3c8eccfce761f55200e547cb6fbc7e8a5230b46de551f3a68c789473a8e369273151e79431a18d40bd051f310528e8a0264549b24c2e518f0a15f46bd05ea64a6239d9151eaaa194f13a57ec05d5c53b4bdc1a111b3b48cd8879aed2ac8524bb2cddb96ed3a51f2c570965e1cc3f785710ade25aa7d49983b4be83a01d16ac40c6b035423b23769d5ca867a48855a6323710f370971774935e0c0576ae5d3a496830ae3a9038366d9439e85aed5aaa44d26c9953f352198946b8cdaba6506290d5b33465544b4a5aa349a4888a35c14c182b2ba82f8f2a63725420bbb9290299baf00a2998a16114e0124dd34f17524c9229a3518d1a3e5891e6511d15ca9594829496828b958a93978a65ceba7e380008c82540120629c6d243ac912c01c9d6203c5a5426d60b7a9ab86dd5caa744142d703292c871850fb441cc1bb14fc164f679b29d8aad4ebc25695b96dcc4839476db86ecdc249e74b508965fc6a43366375ab93b19fcab764f5564a00e5b886dfbca6da350b4fd2a5e546e5e82c069f9545183d972dc7aa1d2d439add94c53e2a665cd42cac6d522c929130b950e97c22c11a46839924fc1b4cccb6a14f611bbd0a75e1e5c34ea8c9a82879c754d4fc55767cd4da720a4d7f850cfc546cc328a324c3a6a79f74850695e338ccab951888908f6ae2cb769fe092d47de1f74b3662f67c48e9990c4badd57091765b1d423cbbfe3fa1333d3211279c0eaf308888f6b56a5e77c7c0f6e918ceebaa50ffb20f925ecbca138f5c43ece9576b147d16505bb886ec3222b44b55a8e79c5d5787693d9a8980e84ea7e2b335079f50e774d8269d8219c8a788d0cf92bc0e41d181b261e251f33145ba4a3e6492c109394a8e9a3518f1a3a7145bb14f348b261cc3748324d4629471484774b0d5d8af420bb082740528b804e31975c014fb6094db4886db4832053e28571b6d494ac9da371716515da7b3986ecb723e60481d6c44b55adb63c2223989c5ccb8b78a4b49a4a676bfcc47d81fbabca4a4160e77c10916cad7079872dc3c43a6efe0b92224790eebaeca3a7d6cbc495558913ed8890f58377b3f79225a242e5df6b366fc7a17342e2e6dcee75562eb8364e3c242798874da223aad12e2fe09a8c0da704b4db986dd43ca5f5a3dc2221e11cd769d45f750afb7695c7cb97b45c3ffd26d8f446f9941554088ae2e251500b4959675bcb98737e34a849a0ccbaaf036225c0c2551e2f0d8664e4b414acb828e93052ec41749b858ca97270208c9624388a742289d621426bac6ea404947d54514049a9cd2a1bc5b556ad7666d8aac4e3624a127a40b50fb2ac33a28328a5bda1e354e412b99b28dd9c72d7c7bcb4a6e674aa548c94312f53717d48a4263162a0e261b3bc11d96a3d1aca8b8f13a5a474abeb537739d91540d8d9ac2a7097ca110dca529b54b49739e2bad33d4641b05d938030b14b47cc2357ad2651d147c332a9484edc3a94acbcf769660466eb5f2480956497b455776d02d2131e21212f751cc4e769476d410b8c895d984b2fad96dfc72a78b7c364d53b8894395767074f77fdc9a9714980973248dda75128a15bc81494be6b548305fee5192e7c43f8146b1146a3952ec22003321248d493696147795c836ba23992e1992e10fb48ec9bcc925a570209cc34d5a94920a5c0bb29b7caeecaec21c4992140a50b5d292224906e654d4092425a2f13893113e6cc9a71d4dc63765b91146d6a284b9bf029302cbf750d1badbb95781ccbda448baa7e0944e218cad4917b891a516a220496114c892f138824909e81166b9704cb87ded49981aec2dcbc296892e39472a4eff7b852480bb56f2ae98908f678b9912097b86e4b890fb29a6e3cc9bb335d6e540249dd2ccaed56fe3ef258dded2f0c1777eae6fc66476449c7093570dc36a69c77fdc5c4b80eddeaa208108c6d0f30efbda6d4a83836e62430b9765468009d23cabb1876bd514c900a4c1c1eea08d3e30b6efc126e0ff2fabda4303decfbc49b7a707fda8f647645139cc39bb4b9e15ab2e651453968fddfe640ccd5479b372dc9b2529adba93989fe6cdeaa8c9ca8db98bf1eaaacd7b6a1a632915ce1696c733845d91e1fa62a099a7542a599f229395e56cbac73bcefee8268b9496c60291ae6d80896134253531f22cf0ddf2ae79045470ecebf384275078886eb864d922165bfef7d2f97d2ad541d9e625b2b4d88f37317688b894c8cb8f08dbf7923529c2e0140ca534446d11116c72da39447d547b0c08fe34a91297fea4a659bb2f7bdd46d62497a483596d440b623c5eb253416e5cc9c8336a72c9b2529980f779529b6f9b8525a6ee4fb9974a5269c524a372f3402b8701e1f652d91e6ca8ac8c14a815a9d12e54dbd1e5ca9c691a1ba5844bf1a93ec3b77747de4d09652fb56a68cfb5de412484e3ae08f092765884b35d68fdd424605ab292f09da36e9412eda221c2cb97f9ae149dfa72a6b17b36f6beeae62e6d25eb7dd40a2b225be6cdf77b29c839da43c223fd2901cbeca0022b2223c56eae15c6cbbbf8d4930ef5a3ed2535c5f6452d15ca57753914db3a7b5ddccbace62bb4dc881468b03214e0da49bbd38368ff4a71344a71c8708a65f0d2295885726dd24aba485c761974a84a8432a9375eb7f9894154a608bd5fc6648253cc0a0ea279506d8717e3bc9e998ff0052e00a65ea646a0b6f662d65b6fe50aeef088ff310aa338e2b0edfccf5edb7f26de9e5222fe9155279c5d838722e461ec1dc177cce9f45e75e34a9f6ac5e53d184307c06bf54e45c5c83da902e3c900eab6748b3a21550af9f5a5de4a90912d45eca969c931bef5e1559c9f19715a0f69fd30d6a7a49a1153b2b0fc76944c882976f4a393521aa234ea5cb8f9214a09f722931827db6b28123eee42b80a3e6c54abb051f36097709e84eaa1a620ac3b2f2a42388a1b0ae2572a6c0459111f5973fe3dc4f954cd81bbbcebe816bf078b33b39e893332bd9b49100cdb6f15ba4b887b25cc29b9821c4e2d3f653ed88f0915c59ade12eef6971f2e36d5687d13f273b98448730e92fba4b95572c2b85bd59887ed2e96913211121cbde5c97992e36c884b361e92b87e4cb9bfd53200bdc04abd8593600375dc24a26a929c43a5586a0c0b8c93a3e6c7369b487b443f37a7720499b5b1e2125a4e1ec75f452837d2f62147962cc3555475b43380a6ea4c8a8f26d776a1af654c4246ec5514d06b651c409b8a35d6d0ae029ad782ab258ac9115d08a4ee5d841024262c9f6c91b2a6806c549c9b088bc04911171d14aca129264946cbc1483314c9704f16108e6a28a6906ca244921ce096c623009055866e14eb469e7f30a8d5318962730f5090f194877659b5458c370adcc249a92866b894ad6d8eb0847512165e19ad1cd6ea5c70d3915bc968b9cd6faad7326060ce76b2b1d39bcaa440f954730568a25b25dfe9e32c89ad3d005cbb109c3de726ddd484b38a6e4157e563995869b04c5490024505cb94a362879d0ca8b14cce1e5254b3c9fa6ef42b40220480bffd9	image/jpeg	0	good	2025-11-15 21:52:23.953457	2025-11-16 21:52:23.953469	f	t	2025-11-15 21:52:23.955811	2025-11-15 22:44:00.133444
6	tiboinshape	Fitness YouTuber and social media influencer who shares workout tips and routines, along with nutrition advice. He is known for his humorous and entertaining approach to fitness.	France	f	100	\N	\N	\N	0	good	2025-11-15 22:09:20.455628	2025-11-16 22:09:20.455633	f	t	2025-11-15 22:09:20.456088	2025-11-15 22:10:32.352239
7	ibratv	French YouTuber known for his pranks, challenges, and social experiments.	France	f	95	\N	\N	\N	0	good	2025-11-15 22:09:35.312812	2025-11-16 22:09:35.312818	f	t	2025-11-15 22:09:35.313344	2025-11-15 22:11:15.66397
8	Sulivan Gwed	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:18:50.395294	\N	f	f	2025-11-15 22:18:50.395297	2025-11-15 22:18:50.395298
9	Justine Gallice	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:19:56.271338	\N	f	f	2025-11-15 22:19:56.271347	2025-11-15 22:19:56.27135
10	Nassim Sahili	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:19:56.351252	\N	f	f	2025-11-15 22:19:56.351256	2025-11-15 22:19:56.351258
11	Bodytime	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:19:56.428022	\N	f	f	2025-11-15 22:19:56.428027	2025-11-15 22:19:56.428029
12	Norman Thavaud	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:23:28.621915	\N	f	f	2025-11-15 22:23:28.621918	2025-11-15 22:23:28.62192
13	Squeezie	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:23:28.678514	\N	f	f	2025-11-15 22:23:28.678518	2025-11-15 22:23:28.678519
14	Lolywood	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:23:29.771323	\N	f	f	2025-11-15 22:23:29.771327	2025-11-15 22:23:29.771328
15	Chandler Hallow	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:27:59.865626	\N	f	f	2025-11-15 22:27:59.865631	2025-11-15 22:27:59.865634
16	Chris Tyson	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:27:59.932136	\N	f	f	2025-11-15 22:27:59.932139	2025-11-15 22:27:59.93214
17	Karl Jacobs	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:27:59.999469	\N	f	f	2025-11-15 22:27:59.999474	2025-11-15 22:27:59.999476
18	Valkyrae	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:01.300977	\N	f	f	2025-11-15 22:28:01.300983	2025-11-15 22:28:01.300985
19	Seb Du Grenier	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:25.709933	\N	f	f	2025-11-15 22:28:25.709936	2025-11-15 22:28:25.709938
20	Benzaie	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:25.76501	\N	f	f	2025-11-15 22:28:25.765017	2025-11-15 22:28:25.765021
21	BenzaieTV	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:27.550828	\N	f	f	2025-11-15 22:28:27.550832	2025-11-15 22:28:27.550833
22	Bob Lennon	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:27.621701	\N	f	f	2025-11-15 22:28:27.621706	2025-11-15 22:28:27.621708
23	Karim Debbache	\N	\N	f	0	\N	\N	\N	0	\N	2025-11-15 22:28:28.80488	\N	f	f	2025-11-15 22:28:28.804884	2025-11-15 22:28:28.804886
\.


--
-- Data for Name: news_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_articles (id, influencer_id, title, description, article_type, date, source, url, sentiment, severity, created_at, updated_at) FROM stdin;
1	2	Cyprien Releases New Animated Series: 'Roger and his Humans'	Cyprien Iov, known as Cyprien on YouTube, released a new animated series called 'Roger and his Humans' on his YouTube channel. The series is based on a comic strip of the same name and has been well received by his audience.	news	2020-09-01 00:00:00	YouTube	https://www.youtube.com/watch?v=IjI7Fo-Q3WQ	positive	6	2025-11-15 22:03:03.15344	2025-11-15 22:03:03.153444
2	2	Cyprien Criticized for Lack of Diversity in His Videos	Cyprien faced backlash on social media for the lack of diversity in his videos. Critics pointed out that most of his content features primarily white characters, leading to a broader conversation about representation in digital media.	controversy	2021-02-15 00:00:00	Twitter	https://twitter.com/MonsieurDream	negative	7	2025-11-15 22:03:03.153445	2025-11-15 22:03:03.153446
3	2	Cyprien Collaborates with Squeezie for a New Video	Cyprien collaborated with fellow French YouTuber Squeezie for a comedic video that quickly went viral. The video, which features the duo in various humorous situations, was a hit among fans of both YouTubers.	collaboration	2021-11-20 00:00:00	YouTube	https://www.youtube.com/watch?v=xyz	positive	5	2025-11-15 22:03:03.153447	2025-11-15 22:03:03.153447
4	2	Cyprien Hits 14 Million Subscribers on YouTube	Cyprien reached a major milestone by hitting 14 million subscribers on YouTube. This achievement further cements his status as one of the most popular French YouTubers.	achievement	2020-06-10 00:00:00	YouTube	https://www.youtube.com/user/MonsieurDream	positive	8	2025-11-15 22:03:03.153448	2025-11-15 22:03:03.153449
5	3	Joueur Du Grenier Celebrates 10 Years on YouTube	In September 2020, Joueur Du Grenier celebrated a decade of creating content on YouTube. He marked the occasion with a special video that looked back on his journey and thanked his fans for their support.	achievement	2020-09-01 00:00:00	YouTube	https://www.youtube.com/watch?v=8YUWDrL5Z0M	positive	8	2025-11-15 22:03:23.427585	2025-11-15 22:03:23.427589
6	3	Joueur Du Grenier's Video on 'Les Sims' Reaches 5 Million Views	In January 2021, Joueur Du Grenier's video on the game 'Les Sims' reached 5 million views, demonstrating his continued popularity and influence in the gaming community.	achievement	2021-01-15 00:00:00	YouTube	https://www.youtube.com/watch?v=2ZsBbs_Z1BA	positive	7	2025-11-15 22:03:23.42759	2025-11-15 22:03:23.42759
7	3	Joueur Du Grenier Collaborates with BenzaieTV	In March 2021, Joueur Du Grenier collaborated with fellow YouTuber BenzaieTV for a video on the game 'Resident Evil 3'. The video was well-received and further cemented Joueur Du Grenier's status as a leading figure in the French gaming community.	collaboration	2021-03-01 00:00:00	YouTube	https://www.youtube.com/watch?v=3RQqBAGeHLY	positive	6	2025-11-15 22:03:23.427591	2025-11-15 22:03:23.427591
8	3	Joueur Du Grenier Criticized for Comments on 'Cyberpunk 2077'	In December 2020, Joueur Du Grenier faced criticism for his comments on the game 'Cyberpunk 2077'. Some fans disagreed with his views, leading to a minor controversy.	controversy	2020-12-15 00:00:00	YouTube	https://www.youtube.com/watch?v=4BcK2gNUFEE	negative	4	2025-11-15 22:03:23.427592	2025-11-15 22:03:23.427592
13	6	Tibo InShape's New Book Release	Tibo InShape, a popular French YouTuber and fitness influencer, released a new book titled 'Tibo InShape - Life, Death, and Resurrection'. The book details his personal journey, struggles, and triumphs in the fitness world.	news	2021-10-15 00:00:00	News Article	https://www.amazon.fr/Tibo-InShape-Vie-mort-r%C3%A9surrection/dp/2749944848	positive	6	2025-11-15 22:10:28.908921	2025-11-15 22:10:28.90893
14	6	Tibo InShape Accused of Promoting Dangerous Diets	Tibo InShape was criticized for promoting potentially harmful diets and fitness routines without proper medical or professional oversight. Critics argue that his influence could lead followers to harm their health in pursuit of unrealistic body standards.	controversy	2021-06-20 00:00:00	Twitter	https://twitter.com/...	negative	7	2025-11-15 22:10:28.908932	2025-11-15 22:10:28.908933
15	6	Tibo InShape Collaborates with French Rapper Bigflo	Tibo InShape collaborated with French rapper Bigflo for a workout video on his YouTube channel. The video gained significant attention and was well-received by fans of both artists.	collaboration	2021-08-15 00:00:00	YouTube	https://www.youtube.com/watch?v=...	positive	5	2025-11-15 22:10:28.908934	2025-11-15 22:10:28.908935
16	6	Tibo InShape Reaches 6 Million Subscribers on YouTube	Tibo InShape celebrated reaching 6 million subscribers on his YouTube channel. This milestone solidifies his status as one of the most popular fitness influencers in France.	achievement	2020-12-10 00:00:00	YouTube	https://www.youtube.com/user/OutLawzFR	positive	8	2025-11-15 22:10:28.908937	2025-11-15 22:10:28.908938
21	7	IbraTV's Prank Video Goes Viral	IbraTV's prank video, where he pretends to be a zombie in public, went viral and was featured on several news outlets. The video was criticized by some viewers who felt it was inappropriate and could cause panic.	drama	2021-10-15 00:00:00	YouTube	https://www.youtube.com/watch?v=...	negative	6	2025-11-15 22:11:12.539306	2025-11-15 22:11:12.53931
22	7	IbraTV Hits 6 Million Subscribers on YouTube	IbraTV reached a major milestone by hitting 6 million subscribers on YouTube. This achievement was celebrated by his fans and recognized by YouTube with a Gold Play Button.	achievement	2022-04-20 00:00:00	YouTube	https://www.youtube.com/user/IbraTV	positive	8	2025-11-15 22:11:12.539311	2025-11-15 22:11:12.539312
23	7	IbraTV Collaborates with Famous YouTuber	IbraTV collaborated with another famous YouTuber for a prank video. The video gained millions of views and was trending on YouTube for several days.	collaboration	2022-07-10 00:00:00	YouTube	https://www.youtube.com/watch?v=...	positive	7	2025-11-15 22:11:12.539313	2025-11-15 22:11:12.539313
24	7	IbraTV Involved in Public Dispute	IbraTV was involved in a public dispute with another influencer on Twitter. The dispute was over a controversial prank video that IbraTV had posted on his YouTube channel.	controversy	2023-02-15 00:00:00	Twitter	https://twitter.com/IbraTV_/status/...	negative	6	2025-11-15 22:11:12.539314	2025-11-15 22:11:12.539315
29	1	MrBeast's $1 Million Squid Game Recreation	MrBeast recreated the popular Netflix series 'Squid Game' in real life, investing $2 million and 7 weeks of preparation. The video quickly became one of the most viewed on his channel.	news	2021-11-25 00:00:00	YouTube	https://www.youtube.com/watch?v=4PZng5vj9ic	positive	9	2025-11-15 22:43:59.56714	2025-11-15 22:43:59.567144
30	1	MrBeast Accused of Creating Unhealthy Work Environment	In May 2021, MrBeast was accused by former employees of creating an unhealthy work environment. However, many other employees defended him, stating that the allegations were not reflective of their experiences.	controversy	2021-05-10 00:00:00	News Article	https://www.insider.com/mrbeast-youtube-jimmy-donaldson-workplace-allegations-2021-5	negative	7	2025-11-15 22:43:59.567145	2025-11-15 22:43:59.567146
31	1	MrBeast's 'Team Trees' Campaign	MrBeast and Mark Rober collaborated on a campaign to plant 20 million trees by 2020. The campaign was a success, raising over $20 million and planting 20 million trees.	achievement	2019-10-25 00:00:00	YouTube	https://www.youtube.com/watch?v=HPJKxAhLw5I	positive	8	2025-11-15 22:43:59.567147	2025-11-15 22:43:59.567148
32	1	MrBeast's Collaboration with PewDiePie	MrBeast collaborated with PewDiePie in a campaign to help him remain the most subscribed YouTube channel. The campaign included buying billboards and radio ads.	collaboration	2019-02-01 00:00:00	YouTube	https://www.youtube.com/watch?v=mGIpOtncmSM	positive	6	2025-11-15 22:43:59.567149	2025-11-15 22:43:59.56715
33	1	MrBeast's 'Finger on the App' Controversy	MrBeast's 'Finger on the App' challenge faced backlash as participants reported the app crashing or glitching, causing them to lose the challenge unfairly.	controversy	2020-07-03 00:00:00	Twitter	https://twitter.com/MrBeast/status/1278757389358489600	negative	5	2025-11-15 22:43:59.567151	2025-11-15 22:43:59.567151
\.


--
-- Data for Name: platforms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.platforms (id, influencer_id, platform_name, username, follower_count, verified, url, created_at, updated_at) FROM stdin;
1	1	youtube	MrBeast	73000000	t	https://www.youtube.com/user/MrBeast6000	2025-11-15 21:52:33.742494	2025-11-15 21:52:33.742498
2	1	instagram	mrbeast	11800000	t	https://www.instagram.com/mrbeast/	2025-11-15 21:52:33.7425	2025-11-15 21:52:33.7425
3	1	twitter	MrBeast	11000000	t	https://twitter.com/MrBeast	2025-11-15 21:52:33.742501	2025-11-15 21:52:33.742501
4	1	tiktok	mrbeast	16000000	t	https://www.tiktok.com/@mrbeast	2025-11-15 21:52:33.742502	2025-11-15 21:52:33.742503
5	2	youtube	MonsieurDream	14000000	t	https://www.youtube.com/user/MonsieurDream	2025-11-15 22:01:58.746388	2025-11-15 22:01:58.746392
6	2	instagram	6pri1	5200000	t	https://www.instagram.com/6pri1/	2025-11-15 22:01:58.746393	2025-11-15 22:01:58.746394
7	2	twitter	MonsieurDream	5500000	t	https://twitter.com/MonsieurDream	2025-11-15 22:01:58.746395	2025-11-15 22:01:58.746395
8	3	youtube	joueurdugrenier	3450000	t	https://www.youtube.com/user/joueurdugrenier	2025-11-15 22:02:22.994306	2025-11-15 22:02:22.994314
9	3	twitter	@Frederic_Molas	680000	t	https://twitter.com/Frederic_Molas	2025-11-15 22:02:22.994317	2025-11-15 22:02:22.994319
10	3	instagram	joueurdugrenier	120000	f	https://www.instagram.com/joueurdugrenier/	2025-11-15 22:02:22.994321	2025-11-15 22:02:22.994322
11	3	facebook	joueurdugrenier.fr	600000	t	https://www.facebook.com/joueurdugrenier.fr	2025-11-15 22:02:22.994324	2025-11-15 22:02:22.994326
12	5	youtube	Maghla	1500000	t	https://www.youtube.com/user/MaghlaOfficiel	2025-11-15 22:09:15.137873	2025-11-15 22:09:15.137877
13	5	instagram	maghla	1200000	t	https://www.instagram.com/maghla/	2025-11-15 22:09:15.137878	2025-11-15 22:09:15.137879
14	5	twitter	Maghla_	500000	t	https://twitter.com/Maghla_	2025-11-15 22:09:15.137879	2025-11-15 22:09:15.13788
15	6	youtube	Tibo InShape	6790000	t	https://www.youtube.com/user/OutLawzFR	2025-11-15 22:09:30.160226	2025-11-15 22:09:30.160231
16	6	instagram	tiboinshape	3700000	t	https://www.instagram.com/tiboinshape/	2025-11-15 22:09:30.160233	2025-11-15 22:09:30.160234
17	6	twitter	TiboInShape	392000	t	https://twitter.com/TiboInShape	2025-11-15 22:09:30.160235	2025-11-15 22:09:30.160236
18	6	tiktok	tiboinshape	2400000	t	https://www.tiktok.com/@tiboinshape	2025-11-15 22:09:30.160237	2025-11-15 22:09:30.160238
19	7	youtube	IbraTV	6000000	t	https://www.youtube.com/user/IbraTV	2025-11-15 22:09:43.238754	2025-11-15 22:09:43.238759
20	7	instagram	ibratv	2000000	t	https://www.instagram.com/ibratv/	2025-11-15 22:09:43.238761	2025-11-15 22:09:43.238762
21	7	twitter	IbraTV_	500000	t	https://twitter.com/IbraTV_	2025-11-15 22:09:43.238763	2025-11-15 22:09:43.238764
\.


--
-- Data for Name: product_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_reviews (id, product_id, author, comment, platform, sentiment, url, date, created_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, influencer_id, name, category, quality_score, openfoodfacts_data, sentiment_score, review_count, description, created_at, updated_at) FROM stdin;
1	1	MrBeast Burger	food	70	\N	\N	0	A virtual restaurant brand selling burgers, chicken sandwiches, and fries. Available for delivery only.	2025-11-15 21:52:59.814604	2025-11-15 21:52:59.814614
2	1	MrBeast Merch	merch	70	\N	\N	0	Official merchandise of MrBeast, including clothing items like t-shirts, hoodies, and hats, as well as accessories.	2025-11-15 21:52:59.947039	2025-11-15 21:52:59.947044
3	2	Narmol	merch	70	\N	\N	0	Narmol is a clothing and accessories brand created by Cyprien. The brand offers a variety of products including t-shirts, hoodies, and hats, often featuring phrases and designs related to Cyprien's videos.	2025-11-15 22:02:24.973658	2025-11-15 22:02:24.973663
4	2	Scred	mobile games	70	\N	\N	0	Scred is a mobile game developed by Cyprien. The game allows players to create their own virtual universe and interact with other players.	2025-11-15 22:02:24.999853	2025-11-15 22:02:24.999857
5	3	Joueur Du Grenier Merch	merch	70	\N	\N	0	A range of merchandise products including t-shirts, hoodies, and posters featuring designs related to 'Le Joueur du Grenier' and his video game reviews.	2025-11-15 22:02:49.729633	2025-11-15 22:02:49.729637
6	3	Sponsorship with Ubisoft	sponsorship	70	\N	\N	0	A brand deal with the video game company Ubisoft, where 'Le Joueur du Grenier' promotes their games in his videos.	2025-11-15 22:02:49.754891	2025-11-15 22:02:49.754894
7	5	Maghla Merchandise	merch	70	\N	\N	0	A line of merchandise including t-shirts, hoodies, and accessories featuring designs inspired by Maghla's personal brand.	2025-11-15 22:09:40.671227	2025-11-15 22:09:40.671235
8	5	Brand Deal with Cosmetics Company	cosmetics	70	\N	\N	0	A sponsorship deal with a major cosmetics company where Maghla promotes their products on her social media platforms.	2025-11-15 22:09:40.697656	2025-11-15 22:09:40.69766
9	6	Tibo InShape Nutrition	food	70	\N	\N	0	A line of nutritional supplements and protein powders designed for fitness enthusiasts and athletes, promoted and sold by Tibo InShape.	2025-11-15 22:09:55.446953	2025-11-15 22:09:55.446961
10	6	Tibo InShape Clothing	merch	70	\N	\N	0	A clothing line that includes fitness apparel such as t-shirts, hoodies, and workout gear, sold and promoted by Tibo InShape.	2025-11-15 22:09:55.895239	2025-11-15 22:09:55.895244
11	7	IbraTV Merchandise	merch	70	\N	\N	0	A line of clothing and accessories featuring the IbraTV logo and related designs.	2025-11-15 22:10:08.414235	2025-11-15 22:10:08.414239
12	7	Sponsorship with Major Brand	sponsorship	70	\N	\N	0	A significant brand deal with a major company, where IbraTV promotes their products or services in his videos.	2025-11-15 22:10:08.441498	2025-11-15 22:10:08.441502
\.


--
-- Data for Name: reputation_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reputation_comments (id, influencer_id, author, comment, platform, sentiment, url, date, created_at) FROM stdin;
1	2	username123	Cyprien's videos always make my day better!	youtube	positive	https://www.youtube.com/watch?v=xyz123&lc=abc456	2024-01-15 00:00:00	2025-11-15 22:03:01.890068
2	2	redditUser789	I don't always agree with Cyprien, but I respect his honesty.	reddit	neutral	https://www.reddit.com/r/youtube/comments/xyz123	2024-01-16 00:00:00	2025-11-15 22:03:01.890071
3	2	twitterFan456	Cyprien's latest video was hilarious! Can't stop laughing.	twitter	positive	https://twitter.com/twitterFan456/status/123456789	2024-01-17 00:00:00	2025-11-15 22:03:01.890072
4	2	instaUser321	Cyprien's content has been a bit repetitive lately.	instagram	negative	https://www.instagram.com/p/xyz123/	2024-01-18 00:00:00	2025-11-15 22:03:01.890081
5	2	tiktokFan890	Just discovered Cyprien's videos. They're really good!	tiktok	positive	https://www.tiktok.com/@user/video/123456789	2024-01-19 00:00:00	2025-11-15 22:03:01.890082
6	2	youtubeUser567	Cyprien's humor is not my cup of tea.	youtube	negative	https://www.youtube.com/watch?v=abc123&lc=xyz456	2024-01-20 00:00:00	2025-11-15 22:03:01.890082
7	2	twitterUser789	Cyprien's podcast is one of the best out there. Highly recommend!	twitter	positive	https://twitter.com/twitterUser789/status/987654321	2024-01-21 00:00:00	2025-11-15 22:03:01.890083
8	2	redditUser123	Cyprien's recent collaboration was a bit disappointing.	reddit	negative	https://www.reddit.com/r/youtube/comments/abc123	2024-01-22 00:00:00	2025-11-15 22:03:01.890084
9	3	gamerfan88	Joueur Du Grenier's videos always make my day better. His humor is on point!	youtube	positive	https://www.youtube.com/user/joueurdugrenier/comment/...	2024-01-10 00:00:00	2025-11-15 22:03:26.83475
10	3	retro_lover	I love how he reviews old games. It's a nostalgia trip every time.	twitter	positive	https://twitter.com/Frederic_Molas/status/...	2024-01-12 00:00:00	2025-11-15 22:03:26.834755
11	3	critic_reviewer	His content is good but sometimes his jokes can be a bit offensive.	reddit	neutral	https://www.reddit.com/r/joueurdugrenier/comment/...	2024-01-13 00:00:00	2025-11-15 22:03:26.834756
12	3	game_enthusiast	Joueur Du Grenier is the best! His game reviews are always honest and entertaining.	youtube	positive	https://www.youtube.com/user/joueurdugrenier/comment/...	2024-01-14 00:00:00	2025-11-15 22:03:26.834758
13	3	french_gamer	I've been following him for years. His content is consistently good.	twitter	positive	https://twitter.com/Frederic_Molas/status/...	2024-01-15 00:00:00	2025-11-15 22:03:26.834759
14	3	random_user	I don't get why he's so popular. His content is just average.	reddit	neutral	https://www.reddit.com/r/joueurdugrenier/comment/...	2024-01-16 00:00:00	2025-11-15 22:03:26.83476
15	3	old_game_fan	His reviews of old games are spot on. Brings back so many memories.	facebook	positive	https://www.facebook.com/joueurdugrenier.fr/posts/...	2024-01-17 00:00:00	2025-11-15 22:03:26.834762
16	3	social_media_user	His humor is not for everyone. I find it a bit too sarcastic.	instagram	neutral	https://www.instagram.com/joueurdugrenier/p/...	2024-01-18 00:00:00	2025-11-15 22:03:26.834763
25	6	fitfanatic	Tibo's workouts are so motivating! I've never felt better.	youtube	positive	https://www.youtube.com/user/OutLawzFR/comments/...	2024-01-15 00:00:00	2025-11-15 22:10:32.377711
26	6	healthguru	I love how Tibo makes fitness fun and accessible for everyone.	instagram	positive	https://www.instagram.com/tiboinshape/comments/...	2024-01-16 00:00:00	2025-11-15 22:10:32.377715
27	6	fitlife	Tibo's energy is infectious! His videos always brighten my day.	tiktok	positive	https://www.tiktok.com/@tiboinshape/comments/...	2024-01-17 00:00:00	2025-11-15 22:10:32.377716
28	6	workoutwarrior	I've been following Tibo's workouts for a while now and I've seen great results.	youtube	positive	https://www.youtube.com/user/OutLawzFR/comments/...	2024-01-18 00:00:00	2025-11-15 22:10:32.377717
29	6	fitnessfreak	Tibo's content is always top-notch. He really knows his stuff.	twitter	positive	https://twitter.com/TiboInShape/comments/...	2024-01-19 00:00:00	2025-11-15 22:10:32.377718
30	6	gymrat	I appreciate how Tibo always keeps it real and doesn't sugarcoat the hard work it takes to get fit.	instagram	positive	https://www.instagram.com/tiboinshape/comments/...	2024-01-20 00:00:00	2025-11-15 22:10:32.377719
31	6	fitmom	Tibo's workouts are challenging but doable. I always feel accomplished after finishing one.	tiktok	positive	https://www.tiktok.com/@tiboinshape/comments/...	2024-01-21 00:00:00	2025-11-15 22:10:32.37772
32	6	healthnut	I'm not a fan of Tibo's style. His workouts are too intense for me.	youtube	negative	https://www.youtube.com/user/OutLawzFR/comments/...	2024-01-22 00:00:00	2025-11-15 22:10:32.37772
41	7	username123	IbraTV's pranks are always so funny! Can't wait for the next one.	youtube	positive	https://www.youtube.com/watch?v=xyz123&lc=abc456	2024-01-15 00:00:00	2025-11-15 22:11:15.685911
42	7	redditUser789	I don't always agree with his methods, but I can't deny that IbraTV is entertaining.	reddit	neutral	https://www.reddit.com/r/YouTubePranks/comments/xyz123	2024-01-14 00:00:00	2025-11-15 22:11:15.685918
43	7	twitterFan456	Just discovered @IbraTV_ and I'm hooked! His videos are hilarious.	twitter	positive	https://twitter.com/twitterFan456/status/123456789	2024-01-13 00:00:00	2025-11-15 22:11:15.68592
44	7	instaUser321	IbraTV's latest video was a bit too much for me. Not a fan of the prank he pulled.	instagram	negative	https://www.instagram.com/p/xyz123/	2024-01-12 00:00:00	2025-11-15 22:11:15.685923
45	7	tiktokFan890	I love when IbraTV collaborates with other YouTubers. Always a good laugh.	tiktok	positive	https://www.tiktok.com/@tiktokFan890/comment/123456789	2024-01-11 00:00:00	2025-11-15 22:11:15.685925
46	7	youtubeUser567	IbraTV's content has been a bit repetitive lately. Hope he switches it up soon.	youtube	neutral	https://www.youtube.com/watch?v=abc123&lc=xyz456	2024-01-10 00:00:00	2025-11-15 22:11:15.685927
47	7	twitterUser890	I don't understand why people watch IbraTV. His pranks are so immature.	twitter	negative	https://twitter.com/twitterUser890/status/987654321	2024-01-09 00:00:00	2025-11-15 22:11:15.685929
48	7	redditUser123	IbraTV's latest video was hilarious! Can't wait for the next one.	reddit	positive	https://www.reddit.com/r/YouTubePranks/comments/abc123	2024-01-08 00:00:00	2025-11-15 22:11:15.685931
57	1	youtuberFan1	MrBeast is the best! His videos are always so entertaining and fun.	youtube	positive	https://www.youtube.com/user/MrBeast6000/comments	2024-01-10 00:00:00	2025-11-15 22:44:00.157544
58	1	instaUser2	Love the philanthropy work MrBeast does. Truly inspiring!	instagram	positive	https://www.instagram.com/mrbeast/comments	2024-01-12 00:00:00	2025-11-15 22:44:00.157549
59	1	twitterUser3	MrBeast's challenges are always so creative. Can't wait for the next one.	twitter	positive	https://twitter.com/MrBeast/status/...	2024-01-13 00:00:00	2025-11-15 22:44:00.157551
60	1	redditUser4	I appreciate MrBeast's efforts to make a positive impact on the world.	reddit	positive	https://www.reddit.com/r/MrBeast/comments/...	2024-01-14 00:00:00	2025-11-15 22:44:00.157553
61	1	tiktokUser5	MrBeast's content is always so engaging and fun. Keep it up!	tiktok	positive	https://www.tiktok.com/@mrbeast/comment/...	2024-01-15 00:00:00	2025-11-15 22:44:00.157554
62	1	twitterUser6	I'm not a big fan of MrBeast's content. It's just not my style.	twitter	negative	https://twitter.com/...	2024-01-16 00:00:00	2025-11-15 22:44:00.157555
63	1	redditUser7	MrBeast's videos are okay, but I don't really get the hype.	reddit	neutral	https://www.reddit.com/r/...	2024-01-17 00:00:00	2025-11-15 22:44:00.157557
64	1	instaUser8	MrBeast is doing great things for the community. Love his work!	instagram	positive	https://www.instagram.com/mrbeast/comments	2024-01-18 00:00:00	2025-11-15 22:44:00.157558
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, influencer_id, user_name, rating, comment, product_name, verified, created_at) FROM stdin;
\.


--
-- Data for Name: timeline_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timeline_events (id, influencer_id, date, event_type, title, description, platform, views, likes, url, created_at) FROM stdin;
1	6	2012-04-12 00:00:00	channel_launch	YouTube Channel Launch	Tibo InShape launched his YouTube channel.	youtube	0	\N	\N	2025-11-15 22:23:09.709275
2	6	2014-02-20 00:00:00	video	First Viral Video: 'How to lose belly fat?'	This video went viral, marking the beginning of his rise to fame.	youtube	2000000	\N	\N	2025-11-15 22:23:09.709279
3	6	2016-07-15 00:00:00	milestone	Reached 1 Million Subscribers on YouTube	Tibo InShape reached 1 million subscribers on his YouTube channel.	youtube	\N	\N	\N	2025-11-15 22:23:09.70928
4	6	2018-05-10 00:00:00	collaboration	Collaboration with Squeezie	Tibo InShape collaborated with popular YouTuber Squeezie, which significantly increased his visibility and subscriber count.	youtube	5000000	\N	\N	2025-11-15 22:23:09.70928
5	6	2020-01-01 00:00:00	milestone	Reached 5 Million Subscribers on YouTube	Tibo InShape reached 5 million subscribers on his YouTube channel.	youtube	\N	\N	\N	2025-11-15 22:23:09.709281
6	6	2024-06-30 00:00:00	milestone	Reached 6.79 Million Subscribers on YouTube	Tibo InShape reached 6.79 million subscribers on his YouTube channel, marking his most recent major milestone.	youtube	\N	\N	\N	2025-11-15 22:23:09.709282
7	7	2014-09-01 00:00:00	channel	Channel started	IbraTV launched his YouTube channel.	youtube	1000	\N	\N	2025-11-15 22:23:10.655467
8	7	2015-07-15 00:00:00	video	24 Hours in a Supermarket	This video went viral, marking IbraTV's breakthrough moment.	youtube	2000000	\N	\N	2025-11-15 22:23:10.655471
9	7	2016-03-20 00:00:00	milestone	Reached 1 Million Subscribers	IbraTV reached 1 million subscribers on YouTube.	youtube	\N	\N	\N	2025-11-15 22:23:10.655472
10	7	2017-08-10 00:00:00	collaboration	Collaboration with Squeezie	IbraTV collaborated with popular YouTuber Squeezie, leading to an increase in subscribers and views.	youtube	3000000	\N	\N	2025-11-15 22:23:10.655472
11	7	2019-05-15 00:00:00	milestone	Reached 5 Million Subscribers	IbraTV reached 5 million subscribers on YouTube.	youtube	\N	\N	\N	2025-11-15 22:23:10.655473
12	7	2024-12-31 00:00:00	milestone	Reached 6 Million Subscribers	IbraTV reached 6 million subscribers on YouTube, marking his latest major milestone.	youtube	\N	\N	\N	2025-11-15 22:23:10.655474
19	1	2012-02-19 00:00:00	channel	Channel started	MrBeast started his YouTube channel.	youtube	0	\N	\N	2025-11-15 22:44:01.43144
20	1	2017-01-15 00:00:00	video	Counting to 100,000 in One Video	This video went viral and marked the beginning of his growth on YouTube.	youtube	20000000	\N	\N	2025-11-15 22:44:01.431443
21	1	2018-07-18 00:00:00	video	I Donated $30,000 To A Random Twitch Streamer	This video was a turning point that launched his career.	youtube	25000000	\N	\N	2025-11-15 22:44:01.431444
22	1	2019-10-25 00:00:00	video	I Bought Everything In A Store - Challenge	This video was one of his most viewed videos and significantly increased his subscriber count.	youtube	60000000	\N	\N	2025-11-15 22:44:01.431445
23	1	2020-10-31 00:00:00	event	Reached 40 million subscribers on YouTube	MrBeast reached a milestone of 40 million subscribers on YouTube.	youtube	\N	\N	\N	2025-11-15 22:44:01.431446
24	1	2024-12-31 00:00:00	event	Reached 73 million subscribers on YouTube	MrBeast ended the year 2024 with 73 million subscribers on YouTube, marking his latest major milestone.	youtube	\N	\N	\N	2025-11-15 22:44:01.431447
31	3	2009-09-29 00:00:00	video	Channel started	Frederic Molas launched his YouTube channel 'joueurdugrenier', focusing on humorous reviews of retro video games.	youtube	5000	\N	\N	2025-11-15 22:46:51.921922
32	3	2011-02-20 00:00:00	milestone	Reached 100,000 subscribers	The 'joueurdugrenier' channel reached 100,000 subscribers on YouTube, a significant growth milestone.	youtube	5000000	\N	\N	2025-11-15 22:46:51.921925
33	3	2012-06-15 00:00:00	collaboration	Collaboration with 'Seb'	Frederic Molas started collaborating with 'Seb', another popular YouTuber. This collaboration led to a significant increase in views and subscribers.	youtube	8000000	\N	\N	2025-11-15 22:46:51.921925
34	3	2015-03-10 00:00:00	milestone	Reached 1,000,000 subscribers	The 'joueurdugrenier' channel reached 1,000,000 subscribers on YouTube, a major growth milestone.	youtube	10000000	\N	\N	2025-11-15 22:46:51.921926
35	3	2018-07-01 00:00:00	video	Plagiat de jeux - The legend of Zelda	This video became one of the most viewed on the 'joueurdugrenier' channel, contributing to a significant increase in subscribers.	youtube	5000000	\N	\N	2025-11-15 22:46:51.921927
36	3	2024-05-15 00:00:00	milestone	Reached 3,000,000 subscribers	The 'joueurdugrenier' channel reached 3,000,000 subscribers on YouTube, marking a significant achievement in Frederic Molas' career.	youtube	20000000	\N	\N	2025-11-15 22:46:51.921927
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-11-15 20:27:44
20211116045059	2025-11-15 20:27:47
20211116050929	2025-11-15 20:27:48
20211116051442	2025-11-15 20:27:50
20211116212300	2025-11-15 20:27:52
20211116213355	2025-11-15 20:27:54
20211116213934	2025-11-15 20:27:56
20211116214523	2025-11-15 20:27:58
20211122062447	2025-11-15 20:28:00
20211124070109	2025-11-15 20:28:02
20211202204204	2025-11-15 20:28:03
20211202204605	2025-11-15 20:28:05
20211210212804	2025-11-15 20:28:11
20211228014915	2025-11-15 20:28:13
20220107221237	2025-11-15 20:28:14
20220228202821	2025-11-15 20:28:16
20220312004840	2025-11-15 20:28:18
20220603231003	2025-11-15 20:28:21
20220603232444	2025-11-15 20:28:22
20220615214548	2025-11-15 20:28:24
20220712093339	2025-11-15 20:28:26
20220908172859	2025-11-15 20:28:28
20220916233421	2025-11-15 20:28:30
20230119133233	2025-11-15 20:28:32
20230128025114	2025-11-15 20:28:34
20230128025212	2025-11-15 20:28:36
20230227211149	2025-11-15 20:28:37
20230228184745	2025-11-15 20:28:39
20230308225145	2025-11-15 20:28:42
20230328144023	2025-11-15 20:28:44
20231018144023	2025-11-15 20:28:47
20231204144023	2025-11-15 20:28:50
20231204144024	2025-11-15 20:28:51
20231204144025	2025-11-15 20:28:53
20240108234812	2025-11-15 20:28:55
20240109165339	2025-11-15 20:28:56
20240227174441	2025-11-15 20:29:00
20240311171622	2025-11-15 20:29:02
20240321100241	2025-11-15 20:29:06
20240401105812	2025-11-15 20:29:11
20240418121054	2025-11-15 20:29:13
20240523004032	2025-11-15 20:29:19
20240618124746	2025-11-15 20:29:21
20240801235015	2025-11-15 20:29:23
20240805133720	2025-11-15 20:29:25
20240827160934	2025-11-15 20:29:26
20240919163303	2025-11-15 20:29:29
20240919163305	2025-11-15 20:29:30
20241019105805	2025-11-15 20:29:32
20241030150047	2025-11-15 20:29:39
20241108114728	2025-11-15 20:29:41
20241121104152	2025-11-15 20:29:43
20241130184212	2025-11-15 20:29:45
20241220035512	2025-11-15 20:29:47
20241220123912	2025-11-15 20:29:48
20241224161212	2025-11-15 20:29:50
20250107150512	2025-11-15 20:29:52
20250110162412	2025-11-15 20:29:54
20250123174212	2025-11-15 20:29:55
20250128220012	2025-11-15 20:29:57
20250506224012	2025-11-15 20:29:58
20250523164012	2025-11-15 20:30:00
20250714121412	2025-11-15 20:30:02
20250905041441	2025-11-15 20:30:04
20251103001201	2025-11-15 20:30:05
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (id, type, format, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-11-15 20:27:42.305085
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-11-15 20:27:42.313249
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-11-15 20:27:42.320486
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-11-15 20:27:42.351965
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-11-15 20:27:42.540014
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-11-15 20:27:42.544487
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-11-15 20:27:42.550971
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-11-15 20:27:42.556299
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-11-15 20:27:42.561
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-11-15 20:27:42.565817
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-11-15 20:27:42.573833
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-11-15 20:27:42.578478
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-11-15 20:27:42.593523
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-11-15 20:27:42.600198
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-11-15 20:27:42.604856
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-11-15 20:27:42.635321
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-11-15 20:27:42.63997
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-11-15 20:27:42.644519
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-11-15 20:27:42.649214
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-11-15 20:27:42.660969
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-11-15 20:27:42.665284
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-11-15 20:27:42.671915
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-11-15 20:27:42.695504
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-11-15 20:27:42.715494
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-11-15 20:27:42.719962
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-11-15 20:27:42.726728
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-11-15 20:27:42.73133
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-11-15 20:27:42.749178
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-11-15 20:27:43.414977
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-11-15 20:27:43.421766
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-11-15 20:27:43.427192
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-11-15 20:27:45.27931
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-11-15 20:27:47.204871
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-11-15 20:27:47.645422
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-11-15 20:27:47.647449
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-11-15 20:27:47.705631
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-11-15 20:27:47.711672
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-11-15 20:27:47.749689
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-11-15 20:27:47.756658
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-11-15 20:27:47.785802
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-11-15 20:27:47.793548
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-11-15 20:27:47.806859
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-11-15 20:27:47.811959
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-11-15 20:27:47.818032
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: connections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.connections_id_seq', 119, true);


--
-- Name: influencers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.influencers_id_seq', 25, true);


--
-- Name: news_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_articles_id_seq', 33, true);


--
-- Name: platforms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.platforms_id_seq', 21, true);


--
-- Name: product_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_reviews_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 12, true);


--
-- Name: reputation_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reputation_comments_id_seq', 64, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: timeline_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timeline_events_id_seq', 36, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: connections connections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_pkey PRIMARY KEY (id);


--
-- Name: influencers influencers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.influencers
    ADD CONSTRAINT influencers_pkey PRIMARY KEY (id);


--
-- Name: news_articles news_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_pkey PRIMARY KEY (id);


--
-- Name: platforms platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platforms
    ADD CONSTRAINT platforms_pkey PRIMARY KEY (id);


--
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: reputation_comments reputation_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reputation_comments
    ADD CONSTRAINT reputation_comments_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: timeline_events timeline_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeline_events
    ADD CONSTRAINT timeline_events_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: ix_influencers_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_influencers_country ON public.influencers USING btree (country);


--
-- Name: ix_influencers_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_influencers_name ON public.influencers USING btree (name);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: connections connections_connected_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_connected_influencer_id_fkey FOREIGN KEY (connected_influencer_id) REFERENCES public.influencers(id);


--
-- Name: connections connections_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_influencer_id_fkey FOREIGN KEY (influencer_id) REFERENCES public.influencers(id);


--
-- Name: news_articles news_articles_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_influencer_id_fkey FOREIGN KEY (influencer_id) REFERENCES public.influencers(id);


--
-- Name: platforms platforms_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platforms
    ADD CONSTRAINT platforms_influencer_id_fkey FOREIGN KEY (influencer_id) REFERENCES public.influencers(id);


--
-- Name: product_reviews product_reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products products_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_influencer_id_fkey FOREIGN KEY (influencer_id) REFERENCES public.influencers(id);


--
-- Name: reputation_comments reputation_comments_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reputation_comments
    ADD CONSTRAINT reputation_comments_influencer_id_fkey FOREIGN KEY (influencer_id) REFERENCES public.influencers(id);


--
-- Name: reviews reviews_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_influencer_id_fkey FOREIGN KEY (influencer_id) REFERENCES public.influencers(id);


--
-- Name: timeline_events timeline_events_influencer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeline_events
    ADD CONSTRAINT timeline_events_influencer_id_fkey FOREIGN KEY (influencer_id) REFERENCES public.influencers(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE connections; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.connections TO anon;
GRANT ALL ON TABLE public.connections TO authenticated;
GRANT ALL ON TABLE public.connections TO service_role;


--
-- Name: SEQUENCE connections_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.connections_id_seq TO anon;
GRANT ALL ON SEQUENCE public.connections_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.connections_id_seq TO service_role;


--
-- Name: TABLE influencers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.influencers TO anon;
GRANT ALL ON TABLE public.influencers TO authenticated;
GRANT ALL ON TABLE public.influencers TO service_role;


--
-- Name: SEQUENCE influencers_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.influencers_id_seq TO anon;
GRANT ALL ON SEQUENCE public.influencers_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.influencers_id_seq TO service_role;


--
-- Name: TABLE news_articles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.news_articles TO anon;
GRANT ALL ON TABLE public.news_articles TO authenticated;
GRANT ALL ON TABLE public.news_articles TO service_role;


--
-- Name: SEQUENCE news_articles_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.news_articles_id_seq TO anon;
GRANT ALL ON SEQUENCE public.news_articles_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.news_articles_id_seq TO service_role;


--
-- Name: TABLE platforms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.platforms TO anon;
GRANT ALL ON TABLE public.platforms TO authenticated;
GRANT ALL ON TABLE public.platforms TO service_role;


--
-- Name: SEQUENCE platforms_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.platforms_id_seq TO anon;
GRANT ALL ON SEQUENCE public.platforms_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.platforms_id_seq TO service_role;


--
-- Name: TABLE product_reviews; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.product_reviews TO anon;
GRANT ALL ON TABLE public.product_reviews TO authenticated;
GRANT ALL ON TABLE public.product_reviews TO service_role;


--
-- Name: SEQUENCE product_reviews_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.product_reviews_id_seq TO anon;
GRANT ALL ON SEQUENCE public.product_reviews_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.product_reviews_id_seq TO service_role;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.products TO anon;
GRANT ALL ON TABLE public.products TO authenticated;
GRANT ALL ON TABLE public.products TO service_role;


--
-- Name: SEQUENCE products_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.products_id_seq TO anon;
GRANT ALL ON SEQUENCE public.products_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.products_id_seq TO service_role;


--
-- Name: TABLE reputation_comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reputation_comments TO anon;
GRANT ALL ON TABLE public.reputation_comments TO authenticated;
GRANT ALL ON TABLE public.reputation_comments TO service_role;


--
-- Name: SEQUENCE reputation_comments_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.reputation_comments_id_seq TO anon;
GRANT ALL ON SEQUENCE public.reputation_comments_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.reputation_comments_id_seq TO service_role;


--
-- Name: TABLE reviews; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reviews TO anon;
GRANT ALL ON TABLE public.reviews TO authenticated;
GRANT ALL ON TABLE public.reviews TO service_role;


--
-- Name: SEQUENCE reviews_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.reviews_id_seq TO anon;
GRANT ALL ON SEQUENCE public.reviews_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.reviews_id_seq TO service_role;


--
-- Name: TABLE timeline_events; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.timeline_events TO anon;
GRANT ALL ON TABLE public.timeline_events TO authenticated;
GRANT ALL ON TABLE public.timeline_events TO service_role;


--
-- Name: SEQUENCE timeline_events_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.timeline_events_id_seq TO anon;
GRANT ALL ON SEQUENCE public.timeline_events_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.timeline_events_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict hFHe0IgW0WT9kS8fcl3BpXkRhm466q2RXHx14PHkkeCPrPjKrFyUz0U5i4hFuxJ

