--
-- PostgreSQL database dump
--

\restrict v52WNK4u2HORpbHp0jTzVRZO4fh9sSquO2GYWLAYEhasAOpGynK4HGboyXd2Egi

-- Dumped from database version 15.19 (Debian 15.19-1.pgdg13+2)
-- Dumped by pg_dump version 15.19 (Debian 15.19-1.pgdg13+2)

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

--
-- Name: evolution_api; Type: SCHEMA; Schema: -; Owner: evolution
--

CREATE SCHEMA evolution_api;


ALTER SCHEMA evolution_api OWNER TO evolution;

--
-- Name: DeviceMessage; Type: TYPE; Schema: evolution_api; Owner: evolution
--

CREATE TYPE evolution_api."DeviceMessage" AS ENUM (
    'ios',
    'android',
    'web',
    'unknown',
    'desktop'
);


ALTER TYPE evolution_api."DeviceMessage" OWNER TO evolution;

--
-- Name: DifyBotType; Type: TYPE; Schema: evolution_api; Owner: evolution
--

CREATE TYPE evolution_api."DifyBotType" AS ENUM (
    'chatBot',
    'textGenerator',
    'agent',
    'workflow'
);


ALTER TYPE evolution_api."DifyBotType" OWNER TO evolution;

--
-- Name: InstanceConnectionStatus; Type: TYPE; Schema: evolution_api; Owner: evolution
--

CREATE TYPE evolution_api."InstanceConnectionStatus" AS ENUM (
    'open',
    'close',
    'connecting'
);


ALTER TYPE evolution_api."InstanceConnectionStatus" OWNER TO evolution;

--
-- Name: OpenaiBotType; Type: TYPE; Schema: evolution_api; Owner: evolution
--

CREATE TYPE evolution_api."OpenaiBotType" AS ENUM (
    'assistant',
    'chatCompletion'
);


ALTER TYPE evolution_api."OpenaiBotType" OWNER TO evolution;

--
-- Name: SessionStatus; Type: TYPE; Schema: evolution_api; Owner: evolution
--

CREATE TYPE evolution_api."SessionStatus" AS ENUM (
    'opened',
    'closed',
    'paused'
);


ALTER TYPE evolution_api."SessionStatus" OWNER TO evolution;

--
-- Name: TriggerOperator; Type: TYPE; Schema: evolution_api; Owner: evolution
--

CREATE TYPE evolution_api."TriggerOperator" AS ENUM (
    'contains',
    'equals',
    'startsWith',
    'endsWith',
    'regex'
);


ALTER TYPE evolution_api."TriggerOperator" OWNER TO evolution;

--
-- Name: TriggerType; Type: TYPE; Schema: evolution_api; Owner: evolution
--

CREATE TYPE evolution_api."TriggerType" AS ENUM (
    'all',
    'keyword',
    'none',
    'advanced'
);


ALTER TYPE evolution_api."TriggerType" OWNER TO evolution;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Chat; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Chat" (
    id text NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    labels jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "instanceId" text NOT NULL,
    name character varying(100),
    "unreadMessages" integer DEFAULT 0 NOT NULL
);


ALTER TABLE evolution_api."Chat" OWNER TO evolution;

--
-- Name: Chatwoot; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Chatwoot" (
    id text NOT NULL,
    enabled boolean DEFAULT true,
    "accountId" character varying(100),
    token character varying(100),
    url character varying(500),
    "nameInbox" character varying(100),
    "signMsg" boolean DEFAULT false,
    "signDelimiter" character varying(100),
    number character varying(100),
    "reopenConversation" boolean DEFAULT false,
    "conversationPending" boolean DEFAULT false,
    "mergeBrazilContacts" boolean DEFAULT false,
    "importContacts" boolean DEFAULT false,
    "importMessages" boolean DEFAULT false,
    "daysLimitImportMessages" integer,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    logo character varying(500),
    organization character varying(100),
    "ignoreJids" jsonb
);


ALTER TABLE evolution_api."Chatwoot" OWNER TO evolution;

--
-- Name: Contact; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Contact" (
    id text NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "pushName" character varying(100),
    "profilePicUrl" character varying(500),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Contact" OWNER TO evolution;

--
-- Name: Dify; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Dify" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    "botType" evolution_api."DifyBotType" NOT NULL,
    "apiUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" evolution_api."TriggerType",
    "triggerOperator" evolution_api."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    description character varying(255),
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."Dify" OWNER TO evolution;

--
-- Name: DifySetting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."DifySetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "difyIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."DifySetting" OWNER TO evolution;

--
-- Name: Evoai; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Evoai" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "agentUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "triggerType" evolution_api."TriggerType",
    "triggerOperator" evolution_api."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Evoai" OWNER TO evolution;

--
-- Name: EvoaiSetting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."EvoaiSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "evoaiIdFallback" character varying(100),
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."EvoaiSetting" OWNER TO evolution;

--
-- Name: EvolutionBot; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."EvolutionBot" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "apiUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" evolution_api."TriggerType",
    "triggerOperator" evolution_api."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."EvolutionBot" OWNER TO evolution;

--
-- Name: EvolutionBotSetting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."EvolutionBotSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "botIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."EvolutionBotSetting" OWNER TO evolution;

--
-- Name: Flowise; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Flowise" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "apiUrl" character varying(255),
    "apiKey" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" evolution_api."TriggerType",
    "triggerOperator" evolution_api."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."Flowise" OWNER TO evolution;

--
-- Name: FlowiseSetting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."FlowiseSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "flowiseIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."FlowiseSetting" OWNER TO evolution;

--
-- Name: Instance; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Instance" (
    id text NOT NULL,
    name character varying(255) NOT NULL,
    "connectionStatus" evolution_api."InstanceConnectionStatus" DEFAULT 'open'::evolution_api."InstanceConnectionStatus" NOT NULL,
    "ownerJid" character varying(100),
    "profilePicUrl" character varying(500),
    integration character varying(100),
    number character varying(100),
    token character varying(255),
    "clientName" character varying(100),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "profileName" character varying(100),
    "businessId" character varying(100),
    "disconnectionAt" timestamp without time zone,
    "disconnectionObject" jsonb,
    "disconnectionReasonCode" integer
);


ALTER TABLE evolution_api."Instance" OWNER TO evolution;

--
-- Name: IntegrationSession; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."IntegrationSession" (
    id text NOT NULL,
    "sessionId" character varying(255) NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "pushName" text,
    status evolution_api."SessionStatus" NOT NULL,
    "awaitUser" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    parameters jsonb,
    context jsonb,
    "botId" text,
    type character varying(100)
);


ALTER TABLE evolution_api."IntegrationSession" OWNER TO evolution;

--
-- Name: IsOnWhatsapp; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."IsOnWhatsapp" (
    id text NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "jidOptions" text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    lid character varying(100)
);


ALTER TABLE evolution_api."IsOnWhatsapp" OWNER TO evolution;

--
-- Name: Kafka; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Kafka" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Kafka" OWNER TO evolution;

--
-- Name: Label; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Label" (
    id text NOT NULL,
    "labelId" character varying(100),
    name character varying(100) NOT NULL,
    color character varying(100) NOT NULL,
    "predefinedId" character varying(100),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Label" OWNER TO evolution;

--
-- Name: Media; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Media" (
    id text NOT NULL,
    "fileName" character varying(500) NOT NULL,
    type character varying(100) NOT NULL,
    mimetype character varying(100) NOT NULL,
    "createdAt" date DEFAULT CURRENT_TIMESTAMP,
    "messageId" text NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Media" OWNER TO evolution;

--
-- Name: Message; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Message" (
    id text NOT NULL,
    key jsonb NOT NULL,
    "pushName" character varying(100),
    participant character varying(100),
    "messageType" character varying(100) NOT NULL,
    message jsonb NOT NULL,
    "contextInfo" jsonb,
    source evolution_api."DeviceMessage" NOT NULL,
    "messageTimestamp" integer NOT NULL,
    "chatwootMessageId" integer,
    "chatwootInboxId" integer,
    "chatwootConversationId" integer,
    "chatwootContactInboxSourceId" character varying(100),
    "chatwootIsRead" boolean,
    "instanceId" text NOT NULL,
    "webhookUrl" character varying(500),
    "sessionId" text,
    status character varying(30)
);


ALTER TABLE evolution_api."Message" OWNER TO evolution;

--
-- Name: MessageUpdate; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."MessageUpdate" (
    id text NOT NULL,
    "keyId" character varying(100) NOT NULL,
    "remoteJid" character varying(100) NOT NULL,
    "fromMe" boolean NOT NULL,
    participant character varying(100),
    "pollUpdates" jsonb,
    status character varying(30) NOT NULL,
    "messageId" text NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."MessageUpdate" OWNER TO evolution;

--
-- Name: N8n; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."N8n" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    description character varying(255),
    "webhookUrl" character varying(255),
    "basicAuthUser" character varying(255),
    "basicAuthPass" character varying(255),
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "triggerType" evolution_api."TriggerType",
    "triggerOperator" evolution_api."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."N8n" OWNER TO evolution;

--
-- Name: N8nSetting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."N8nSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "n8nIdFallback" character varying(100),
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."N8nSetting" OWNER TO evolution;

--
-- Name: Nats; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Nats" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Nats" OWNER TO evolution;

--
-- Name: OpenaiBot; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."OpenaiBot" (
    id text NOT NULL,
    "assistantId" character varying(255),
    model character varying(100),
    "systemMessages" jsonb,
    "assistantMessages" jsonb,
    "userMessages" jsonb,
    "maxTokens" integer,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "triggerType" evolution_api."TriggerType",
    "triggerOperator" evolution_api."TriggerOperator",
    "triggerValue" text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "openaiCredsId" text NOT NULL,
    "instanceId" text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    "botType" evolution_api."OpenaiBotType" NOT NULL,
    description character varying(255),
    "functionUrl" character varying(500),
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."OpenaiBot" OWNER TO evolution;

--
-- Name: OpenaiCreds; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."OpenaiCreds" (
    id text NOT NULL,
    "apiKey" character varying(255),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    name character varying(255)
);


ALTER TABLE evolution_api."OpenaiCreds" OWNER TO evolution;

--
-- Name: OpenaiSetting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."OpenaiSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "openaiCredsId" text NOT NULL,
    "openaiIdFallback" character varying(100),
    "instanceId" text NOT NULL,
    "speechToText" boolean DEFAULT false,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."OpenaiSetting" OWNER TO evolution;

--
-- Name: Proxy; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Proxy" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    host character varying(100) NOT NULL,
    port character varying(100) NOT NULL,
    protocol character varying(100) NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Proxy" OWNER TO evolution;

--
-- Name: Pusher; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Pusher" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    "appId" character varying(100) NOT NULL,
    key character varying(100) NOT NULL,
    secret character varying(100) NOT NULL,
    cluster character varying(100) NOT NULL,
    "useTLS" boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Pusher" OWNER TO evolution;

--
-- Name: Rabbitmq; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Rabbitmq" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Rabbitmq" OWNER TO evolution;

--
-- Name: Session; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Session" (
    id text NOT NULL,
    "sessionId" text NOT NULL,
    creds text,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE evolution_api."Session" OWNER TO evolution;

--
-- Name: Setting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Setting" (
    id text NOT NULL,
    "rejectCall" boolean DEFAULT false NOT NULL,
    "msgCall" character varying(100),
    "groupsIgnore" boolean DEFAULT false NOT NULL,
    "alwaysOnline" boolean DEFAULT false NOT NULL,
    "readMessages" boolean DEFAULT false NOT NULL,
    "readStatus" boolean DEFAULT false NOT NULL,
    "syncFullHistory" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "wavoipToken" character varying(100)
);


ALTER TABLE evolution_api."Setting" OWNER TO evolution;

--
-- Name: Sqs; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Sqs" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Sqs" OWNER TO evolution;

--
-- Name: Template; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Template" (
    id text NOT NULL,
    "templateId" character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    template jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "webhookUrl" character varying(500)
);


ALTER TABLE evolution_api."Template" OWNER TO evolution;

--
-- Name: Typebot; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Typebot" (
    id text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    url character varying(500) NOT NULL,
    typebot character varying(100) NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone,
    "triggerType" evolution_api."TriggerType",
    "triggerOperator" evolution_api."TriggerOperator",
    "triggerValue" text,
    "instanceId" text NOT NULL,
    "debounceTime" integer,
    "ignoreJids" jsonb,
    description character varying(255),
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."Typebot" OWNER TO evolution;

--
-- Name: TypebotSetting; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."TypebotSetting" (
    id text NOT NULL,
    expire integer DEFAULT 0,
    "keywordFinish" character varying(100),
    "delayMessage" integer,
    "unknownMessage" character varying(100),
    "listeningFromMe" boolean DEFAULT false,
    "stopBotFromMe" boolean DEFAULT false,
    "keepOpen" boolean DEFAULT false,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    "debounceTime" integer,
    "typebotIdFallback" character varying(100),
    "ignoreJids" jsonb,
    "splitMessages" boolean DEFAULT false,
    "timePerChar" integer DEFAULT 50
);


ALTER TABLE evolution_api."TypebotSetting" OWNER TO evolution;

--
-- Name: Webhook; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Webhook" (
    id text NOT NULL,
    url character varying(500) NOT NULL,
    enabled boolean DEFAULT true,
    events jsonb,
    "webhookByEvents" boolean DEFAULT false,
    "webhookBase64" boolean DEFAULT false,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL,
    headers jsonb
);


ALTER TABLE evolution_api."Webhook" OWNER TO evolution;

--
-- Name: Websocket; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api."Websocket" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    events jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL,
    "instanceId" text NOT NULL
);


ALTER TABLE evolution_api."Websocket" OWNER TO evolution;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: evolution_api; Owner: evolution
--

CREATE TABLE evolution_api._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE evolution_api._prisma_migrations OWNER TO evolution;

--
-- Data for Name: Chat; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Chat" (id, "remoteJid", labels, "createdAt", "updatedAt", "instanceId", name, "unreadMessages") FROM stdin;
\.


--
-- Data for Name: Chatwoot; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Chatwoot" (id, enabled, "accountId", token, url, "nameInbox", "signMsg", "signDelimiter", number, "reopenConversation", "conversationPending", "mergeBrazilContacts", "importContacts", "importMessages", "daysLimitImportMessages", "createdAt", "updatedAt", "instanceId", logo, organization, "ignoreJids") FROM stdin;
\.


--
-- Data for Name: Contact; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Contact" (id, "remoteJid", "pushName", "profilePicUrl", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Dify; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Dify" (id, enabled, "botType", "apiUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId", description, "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: DifySetting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."DifySetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "difyIdFallback", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Evoai; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Evoai" (id, enabled, description, "agentUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: EvoaiSetting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."EvoaiSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "createdAt", "updatedAt", "evoaiIdFallback", "instanceId") FROM stdin;
\.


--
-- Data for Name: EvolutionBot; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."EvolutionBot" (id, enabled, description, "apiUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: EvolutionBotSetting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."EvolutionBotSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "botIdFallback", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Flowise; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Flowise" (id, enabled, description, "apiUrl", "apiKey", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: FlowiseSetting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."FlowiseSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "flowiseIdFallback", "instanceId", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Instance; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Instance" (id, name, "connectionStatus", "ownerJid", "profilePicUrl", integration, number, token, "clientName", "createdAt", "updatedAt", "profileName", "businessId", "disconnectionAt", "disconnectionObject", "disconnectionReasonCode") FROM stdin;
5a521291-ab75-483d-b27a-bb18f398ea26	whatsapp	connecting	\N	\N	WHATSAPP-BAILEYS	\N	253270FC-6597-4863-8A95-AD7506183206	evolution_exchange	2026-09-23 18:40:31.08	2026-09-23 18:50:33.806	\N	\N	\N	\N	\N
\.


--
-- Data for Name: IntegrationSession; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."IntegrationSession" (id, "sessionId", "remoteJid", "pushName", status, "awaitUser", "createdAt", "updatedAt", "instanceId", parameters, context, "botId", type) FROM stdin;
\.


--
-- Data for Name: IsOnWhatsapp; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."IsOnWhatsapp" (id, "remoteJid", "jidOptions", "createdAt", "updatedAt", lid) FROM stdin;
\.


--
-- Data for Name: Kafka; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Kafka" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Label; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Label" (id, "labelId", name, color, "predefinedId", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Media; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Media" (id, "fileName", type, mimetype, "createdAt", "messageId", "instanceId") FROM stdin;
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Message" (id, key, "pushName", participant, "messageType", message, "contextInfo", source, "messageTimestamp", "chatwootMessageId", "chatwootInboxId", "chatwootConversationId", "chatwootContactInboxSourceId", "chatwootIsRead", "instanceId", "webhookUrl", "sessionId", status) FROM stdin;
\.


--
-- Data for Name: MessageUpdate; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."MessageUpdate" (id, "keyId", "remoteJid", "fromMe", participant, "pollUpdates", status, "messageId", "instanceId") FROM stdin;
\.


--
-- Data for Name: N8n; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."N8n" (id, enabled, description, "webhookUrl", "basicAuthUser", "basicAuthPass", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: N8nSetting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."N8nSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "splitMessages", "timePerChar", "createdAt", "updatedAt", "n8nIdFallback", "instanceId") FROM stdin;
\.


--
-- Data for Name: Nats; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Nats" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: OpenaiBot; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."OpenaiBot" (id, "assistantId", model, "systemMessages", "assistantMessages", "userMessages", "maxTokens", expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "triggerType", "triggerOperator", "triggerValue", "createdAt", "updatedAt", "openaiCredsId", "instanceId", enabled, "botType", description, "functionUrl", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: OpenaiCreds; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."OpenaiCreds" (id, "apiKey", "createdAt", "updatedAt", "instanceId", name) FROM stdin;
\.


--
-- Data for Name: OpenaiSetting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."OpenaiSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "debounceTime", "ignoreJids", "createdAt", "updatedAt", "openaiCredsId", "openaiIdFallback", "instanceId", "speechToText", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Proxy; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Proxy" (id, enabled, host, port, protocol, username, password, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Pusher; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Pusher" (id, enabled, "appId", key, secret, cluster, "useTLS", events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Rabbitmq; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Rabbitmq" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Session; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Session" (id, "sessionId", creds, "createdAt") FROM stdin;
cmueg7imc0003qw4qoqaclmd1	5a521291-ab75-483d-b27a-bb18f398ea26	"{\\"noiseKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"cPvOXM43KOMy5eelM9/r9uq8k/tMU2J0H35bqY5gpmQ=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"8zIxtArL0DKr07DQtoGhaXr8zTC43eaNVqAB9tlcqEI=\\"}},\\"pairingEphemeralKeyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"yAuPjlrgxAEWpjS9RrRkG6MtmNoeKoVD0pMe+C2uQl4=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"G8ljaY5Rsc5jBAmQvaAOufF7lKKjl9mOG6fB3bid4RY=\\"}},\\"signedIdentityKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"kJVmUZ4py4hIlYxwrFe/JQ2D4PVaPPex6Chtm7KOMGE=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"fbEB0/wBYBxBuqdtbedJWxbkzeCThdUEjPfcdn107Dw=\\"}},\\"signedPreKey\\":{\\"keyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"0MwI0/b3swERYbBk/8Ra/9V188gbHhc3oDQ8JzV31W0=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"R4ePQwR3y/YNlT2SJIWdZXb4hNkZHwplGAWSdJboskc=\\"}},\\"signature\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"8X2TgnQlPvUn9yLFP3sgNXm8UWqZsFMJI3wzWmnQGgfJMqB1IQ33HzGCMXdaD82DWxsFHOWpk5oDYzW2C41ngA==\\"},\\"keyId\\":1},\\"registrationId\\":140,\\"advSecretKey\\":\\"MBByjfIs05TgqjrloZkOuid1WKVulAYRKNAUL4Lpcu0=\\",\\"processedHistoryMessages\\":[],\\"nextPreKeyId\\":1,\\"firstUnuploadedPreKeyId\\":1,\\"accountSyncCounter\\":0,\\"accountSettings\\":{\\"unarchiveChats\\":false},\\"registered\\":false}"	2026-09-23 18:40:31.236
\.


--
-- Data for Name: Setting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Setting" (id, "rejectCall", "msgCall", "groupsIgnore", "alwaysOnline", "readMessages", "readStatus", "syncFullHistory", "createdAt", "updatedAt", "instanceId", "wavoipToken") FROM stdin;
cmueg7ijp0001qw4qm332kdg2	f		f	f	f	f	f	2026-09-23 18:40:31.141	2026-09-23 18:40:31.141	5a521291-ab75-483d-b27a-bb18f398ea26	
\.


--
-- Data for Name: Sqs; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Sqs" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: Template; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Template" (id, "templateId", name, template, "createdAt", "updatedAt", "instanceId", "webhookUrl") FROM stdin;
\.


--
-- Data for Name: Typebot; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Typebot" (id, enabled, url, typebot, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "createdAt", "updatedAt", "triggerType", "triggerOperator", "triggerValue", "instanceId", "debounceTime", "ignoreJids", description, "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: TypebotSetting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."TypebotSetting" (id, expire, "keywordFinish", "delayMessage", "unknownMessage", "listeningFromMe", "stopBotFromMe", "keepOpen", "createdAt", "updatedAt", "instanceId", "debounceTime", "typebotIdFallback", "ignoreJids", "splitMessages", "timePerChar") FROM stdin;
\.


--
-- Data for Name: Webhook; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Webhook" (id, url, enabled, events, "webhookByEvents", "webhookBase64", "createdAt", "updatedAt", "instanceId", headers) FROM stdin;
\.


--
-- Data for Name: Websocket; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Websocket" (id, enabled, events, "createdAt", "updatedAt", "instanceId") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
2a2a6ac6-2f8d-4f03-8dab-d7b7584c3918	1af30cbbccd90152fbb1b99a458978e42428a792b822b4b5f9c9c7fffbf7264f	2026-09-23 18:40:07.299816+00	20240819154941_add_context_to_integration_session	\N	\N	2026-09-23 18:40:07.266231+00	1
8f5a633f-086f-49d7-8b1b-b606eb1c61d6	7507eff6b49fad53cdd0b3ace500f529597dfa1a8987afbb9807968a8ee8ef49	2026-09-23 18:39:59.240631+00	20240609181238_init	\N	\N	2026-09-23 18:39:53.917349+00	1
02b8754c-651c-442a-a8fa-8d21bdc8cc81	8c2a595975dc2f6dee831983304996e25c37014c48291576e7c8044078bfde32	2026-09-23 18:40:03.419652+00	20240722173259_add_name_column_to_openai_creds	\N	\N	2026-09-23 18:40:03.344382+00	1
3a8d8b4a-fa71-468e-91d7-a29250ce3231	914eeefb9eba0dacdbcb7cdbe47567abd957543d6f27c39db4eec6a40c864008	2026-09-23 18:39:59.307634+00	20240610144159_create_column_profile_name_instance	\N	\N	2026-09-23 18:39:59.260944+00	1
c043d198-04e1-463b-bbec-0aa240aa658c	50d6920345af06dbd5086959784b7e2b4d163a5b555ff1029e5f81678a454444	2026-09-23 18:39:59.341804+00	20240611125754_create_columns_whitelabel_chatwoot	\N	\N	2026-09-23 18:39:59.315863+00	1
d551385a-b485-4995-9068-8a342bf70fd5	c29ccc88930138c50091712466f3f97bff48f6a0f486dcec5b19dc08c3612973	2026-09-23 18:40:04.844286+00	20240729180347_modify_typebot_session_status_openai_typebot_table	\N	\N	2026-09-23 18:40:04.243178+00	1
6d3ea8e7-3ea0-4c81-b306-e41a04d75357	b90c49299ed812fb46b71a4f0b9f818b7fc7109c52b1aff227a107236839d93c	2026-09-23 18:39:59.383157+00	20240611202817_create_columns_debounce_time_typebot	\N	\N	2026-09-23 18:39:59.34964+00	1
ee9e5dd9-8852-4857-95a6-3d843cbdcdf0	20b3c04d93799c25fa8b2d0a85d10f9280e915a5d7519542492ed85ff082a3c0	2026-09-23 18:40:03.453841+00	20240722173518_add_name_column_to_openai_creds	\N	\N	2026-09-23 18:40:03.428452+00	1
4fe1951b-e052-4b78-870e-158d107bf479	01303057a037f5dc28272ac513b60d5a75be71d1bf727e671ca538db3268fa2e	2026-09-23 18:39:59.512781+00	20240712144948_add_business_id_column_to_instances	\N	\N	2026-09-23 18:39:59.391682+00	1
a3587c8b-6f92-409a-a14d-63bf30cebf98	34235c250eb1f088c285489ad690b4c045680f1638076436cdc66de0ea382cc2	2026-09-23 18:40:00.78811+00	20240712150256_create_templates_table	\N	\N	2026-09-23 18:39:59.682682+00	1
885892cc-1d42-4e12-acd9-9f42645d89b2	0ba192ba428c9ab5a9b31d1f7d73603ee47b6192e2f8c590f6d93ade0dbdbccf	2026-09-23 18:40:00.964811+00	20240712155950_adjusts_in_templates_table	\N	\N	2026-09-23 18:40:00.805122+00	1
d770c07e-f9ca-4465-a360-8efce932741e	7ffb91b84cb7aa17b1f488d580626144cd557ccdfaec6654515545401d1938af	2026-09-23 18:40:03.705412+00	20240723152648_adjusts_in_column_openai_creds	\N	\N	2026-09-23 18:40:03.461947+00	1
f00c9a0a-2a0c-42ec-98ae-52e67728f138	426256b73f7ea52538dc91a890179c841325a9c387cf02885b81971d582af830	2026-09-23 18:40:01.099117+00	20240712162206_remove_templates_table	\N	\N	2026-09-23 18:40:01.002836+00	1
7500a12f-bbb4-4e6f-bace-c1390bbc1c99	3496739609829e80daf733baecd3d3e4e279bf318a99adc1ca3aa1c76f893b2f	2026-09-23 18:40:01.233669+00	20240712223655_column_fallback_typebot	\N	\N	2026-09-23 18:40:01.15783+00	1
243f7f80-0dff-4066-9476-aadb336548c9	c8627bad5d72ee4ef774ed32c95a2524517b0c60c49fa67cd4ba9dff7cbdde3b	2026-09-23 18:40:06.82944+00	20240811021156_add_chat_name_column	\N	\N	2026-09-23 18:40:06.804138+00	1
ae073dbf-d75c-42e4-825f-92a164ef9693	bea48f697c0c5db52ade4a3f26c1321e3f5611c80ea50384baa54e58c6b3a79e	2026-09-23 18:40:01.351361+00	20240712230631_column_ignore_jids_typebot	\N	\N	2026-09-23 18:40:01.250511+00	1
be293f2f-64e0-48f3-af85-09e18b8ae743	3056f8f1335e8933e4098f005e33cd4821190be2eb76520c0d01e2e13cf6e073	2026-09-23 18:40:03.915172+00	20240723200254_add_webhookurl_on_message	\N	\N	2026-09-23 18:40:03.780808+00	1
fc12202d-3e88-4582-a6fe-c51e392857d4	1bac56740af5d2d6512b29e7a6e0721d69b2a290400f6660b92b6f2d8b30cd6e	2026-09-23 18:40:02.250017+00	20240713184337_add_media_table	\N	\N	2026-09-23 18:40:01.376968+00	1
6ca1ee13-9810-474f-98a8-1757159e63c8	bdd992b253321ca9a9556e30fea5e7760556cb8e80140aec34066301b55dc675	2026-09-23 18:40:03.295464+00	20240718121437_add_openai_tables	\N	\N	2026-09-23 18:40:02.25884+00	1
77cc408b-d95d-4c52-a305-5ab6f0e96d4a	961a8627684fe1e4c7123565db3d16db30768df41881342032f9a2df16145eaf	2026-09-23 18:40:06.593634+00	20240730152156_create_dify_tables	\N	\N	2026-09-23 18:40:04.89942+00	1
8ed2b76d-1e03-4c7a-9f07-8a627292543b	8147ec0cc86ac30ea1be05d461559ba5064273a3fcb3227af71ddcd895f5aebe	2026-09-23 18:40:03.335654+00	20240718123923_adjusts_openai_tables	\N	\N	2026-09-23 18:40:03.303741+00	1
4fb7be77-3377-4e7f-b6bb-8c312e944786	9d6c9b4ffe51483a851f6507f7aefd2fb34f54a7c28961856e3230fda4f87022	2026-09-23 18:40:04.13036+00	20240725184147_create_template_table	\N	\N	2026-09-23 18:40:03.932139+00	1
b6b4c33b-e950-4b25-89ba-33eaa6b19c9e	94e2edb21107895c77b24402f41cd020c7f74dbb39b9a95664a45e62e2582be9	2026-09-23 18:40:04.166931+00	20240725202651_add_webhook_url_template_table	\N	\N	2026-09-23 18:40:04.141737+00	1
15147593-666e-4976-8bd8-1090f4ac7cfe	d0da588e4204c50bde2e41a615b9301afca072991033545b6f4e3e34e088db87	2026-09-23 18:40:04.200865+00	20240725221646_modify_token_instance_table	\N	\N	2026-09-23 18:40:04.175693+00	1
065b58b5-4fb0-42d7-8839-536d21c038a6	b56b053451d564ff6282078fad4fc7bff4aa71e3b0b8d00bf219da4ed1bc4c86	2026-09-23 18:40:06.69474+00	20240801193907_add_column_speech_to_text_openai_setting_table	\N	\N	2026-09-23 18:40:06.635713+00	1
7e1bd43c-fc79-4b17-828b-f1511df8add2	a80f5c27cd80d088ea69153f8d6f4879406770ffa5a7fd50b28da82bd020322e	2026-09-23 18:40:04.234788+00	20240729115127_modify_trigger_type_openai_typebot_table	\N	\N	2026-09-23 18:40:04.209498+00	1
1783af28-c47c-422c-bf54-6ba822ed1d1c	428a9148f2a29f773e0c9813149e6d07bf51765e018652aeac0be2141a722b67	2026-09-23 18:40:07.065122+00	20240814173033_add_ignore_jids_chatwoot	\N	\N	2026-09-23 18:40:07.039644+00	1
73910302-fb1f-4c12-a66d-e04dcbc6724c	2b963cbc826ea024f9a643af2d5d9fcea06717c90ec9bacb255d3836efa06aea	2026-09-23 18:40:06.76175+00	20240803163908_add_column_description_on_integrations_table	\N	\N	2026-09-23 18:40:06.711462+00	1
929505d7-d1af-429a-8c75-37d29af83017	ee44f0420384d55de6d252fffb8f2cfa88479e5811e14cfe975d8edfcc6957e0	2026-09-23 18:40:06.929726+00	20240811183328_add_unique_index_for_remoted_jid_and_instance_in_contacts	\N	\N	2026-09-23 18:40:06.837732+00	1
64a017ee-73d9-44ee-a3c5-1c2b5ff36ebb	4d2dd947ebb7515c7c278472a10ebab6d5f41a5ef60e15df717a05d457d5d2aa	2026-09-23 18:40:06.795519+00	20240808210239_add_column_function_url_openaibot_table	\N	\N	2026-09-23 18:40:06.770414+00	1
6d56405c-5426-4af1-bf10-3fe7f9476ade	29c330029a48aaee63567e63c4f4e57b7c1f5344162b11fbf61a4dc194547861	2026-09-23 18:40:07.030759+00	20240813003116_make_label_unique_for_instance	\N	\N	2026-09-23 18:40:06.938462+00	1
438cc12d-bb84-4230-86bb-fa8c81d01bfb	bc5cd1c7fb4df72e88cb4856c9c49ea340284c9d8f389fe558008a921494ed82	2026-09-23 18:40:07.258001+00	20240817110155_add_trigger_type_advanced	\N	\N	2026-09-23 18:40:07.232865+00	1
92994707-e099-49f5-b2bc-31dc02be5d95	e1eb8997ac99fd555b8a9241c817b97fa5614124922b4e6b3cb1751e9e2199c7	2026-09-23 18:40:07.207597+00	20240814202359_integrations_unification	\N	\N	2026-09-23 18:40:07.073647+00	1
995de93a-bbd3-400c-a347-7896c26b12fb	a363a9ebc5bb526e504c4e6f71ed7702a5b6d317db6a9981f36c4560f9147fba	2026-09-23 18:40:07.448742+00	20240821120816_bot_id_integration_session	\N	\N	2026-09-23 18:40:07.32492+00	1
1c8c6be7-3637-4e2e-85e1-5066f0a297a4	e31947e6c709ee3a62504980ae9ab1ffbfd9faf0cf9ac389cfd6435734c49902	2026-09-23 18:40:08.396468+00	20240821171327_add_generic_bot_table	\N	\N	2026-09-23 18:40:07.509115+00	1
efbf438d-0ae2-4ef6-8ebd-75cb8bb8e33a	18dde8e48c49a97f33f5b789ccd919326253c26d43af72c77f6b13d4285ffba8	2026-09-23 18:40:09.2902+00	20240821194524_add_flowise_table	\N	\N	2026-09-23 18:40:08.405117+00	1
b4bccabf-089f-46d3-a276-66f2f73ef12f	0148a09e0e5eedafe5c5169c6351201a5c70ebaa853456693d75a7b82a851dbe	2026-09-23 18:40:09.442043+00	20240824161333_add_type_on_integration_sessions	\N	\N	2026-09-23 18:40:09.31565+00	1
34d86122-6ef2-416f-884d-fc05b3aece0d	710e7ee3aabf07aa6ee9bf2865c09f75d461efa5724dd83f5a6f324ea1e5e47c	2026-09-23 18:40:10.419231+00	20240825130616_change_to_evolution_bot	\N	\N	2026-09-23 18:40:09.474468+00	1
6891846e-f7ee-4aca-8e0b-fb14d7fe252c	0a6034359b1cf68820e829d31402032eed0f77586fb1ee590a98f5a6c3e15847	2026-09-23 18:40:13.822978+00	20250514232744_add_n8n_table	\N	\N	2026-09-23 18:40:13.390645+00	1
605f5ebf-dfa6-42e2-a025-9faf78d8250d	d03a8a31df36eb0a07e80cd2a149b6d826e69bb2cb21fbe69943ae5ffba672ad	2026-09-23 18:40:10.961201+00	20240828140837_add_is_on_whatsapp_table	\N	\N	2026-09-23 18:40:10.428068+00	1
e0ae4a0d-516b-433e-af2a-34c141f07877	e927e00343b622bee7dab1b9b5c9fdd95007bfaf9d705ec52db9ecb05fb3d078	2026-09-23 18:40:10.997955+00	20240828141556_remove_name_column_from_on_whatsapp_table	\N	\N	2026-09-23 18:40:10.969879+00	1
61e9f558-d8b8-4913-b608-bde20cfb4d89	cf00d8ef2c28cf94aea51e7e2a80ddd65474a4f6c1113abc65dea6cc194c1a57	2026-09-23 18:40:11.315597+00	20240830193533_changed_table_case	\N	\N	2026-09-23 18:40:11.00656+00	1
7c9232b2-2e1d-493e-b063-54e9cac9bc50	f9ddf352b22e52a1f466d40df95da7bd6f4bf51310c07911d9c990f720e1fe81	2026-09-23 18:40:14.178042+00	20250515211815_add_evoai_table	\N	\N	2026-09-23 18:40:13.831833+00	1
54a37b78-08cb-42a7-8a79-e30c08324f1d	1cc60b9c38db62b694f753e2ee4c155e95c66815b5800f6ddb6f7cddec23b1ad	2026-09-23 18:40:11.425533+00	20240906202019_add_headers_on_webhook_config	\N	\N	2026-09-23 18:40:11.332311+00	1
7bbef903-6660-4378-82a9-fc5fa752b621	7dff7227c1e013127210ab4f77b91dc24eae14bcd07f21fb27aaa2fa82b23865	2026-09-23 18:40:11.467367+00	20241001180457_add_message_status	\N	\N	2026-09-23 18:40:11.433843+00	1
31d58959-e7a4-4f88-ba4f-dc19e7cdad8e	07449acbac59175f82670f34664c1dcea4d34f9a1710f19bd3396e26868db09e	2026-09-23 18:40:11.745913+00	20241006130306_alter_status_on_message_table	\N	\N	2026-09-23 18:40:11.509186+00	1
ba9bffb9-587e-4e8a-a625-b41f7cc4c5c5	7a03627d41844a016b28b4194e36eea0e52cd24be0061535fecba4ccbd0e72f4	2026-09-23 18:40:14.21163+00	20250516012152_remove_unique_atribute_for_file_name_in_media	\N	\N	2026-09-23 18:40:14.186555+00	1
196c820c-efcf-4beb-a598-b858ae57699e	7e9a7c45f05285e9fea38ccfa4266790a099107605299d81c309e689c06494ef	2026-09-23 18:40:11.84697+00	20241007164026_add_unread_messages_on_chat_table	\N	\N	2026-09-23 18:40:11.781055+00	1
bbbe3c61-f477-463b-b079-65d95c5a9513	7e3e4686eb8009cbf0f71e8606a442b1c2862673dbc654b3f36f39a36efcb586	2026-09-23 18:40:12.103693+00	20241011085129_create_pusher_table	\N	\N	2026-09-23 18:40:11.897407+00	1
f0bd3512-553e-46c3-91ec-e1afebdafa40	270e1e51c7b9d24c0e68708ad167cb5748d591fd194ad422486574a0e83c0b79	2026-09-23 18:40:12.145496+00	20241011100803_split_messages_and_time_per_char_integrations	\N	\N	2026-09-23 18:40:12.112238+00	1
8d646718-8d80-42bc-bced-ec5007995b1c	3fca4961d4e7fa8e1a99e3ec6b072d235bec706b7463ab699887be1084e3b656	2026-09-23 18:40:14.253703+00	20250612155048_add_coluns_trypebot_tables	\N	\N	2026-09-23 18:40:14.21995+00	1
e01433dd-bb3f-4a0c-a61d-c8c5b2ac7b07	e82282df963a32556a9c8cd5fd908dd5810d4c35f0d7765ab9e844ebad1106a2	2026-09-23 18:40:12.653101+00	20241017144950_create_index	\N	\N	2026-09-23 18:40:12.154307+00	1
52a0db41-aefe-4890-bf6f-08bf03eec5b1	668e44d3cd8caafa8f60f89805e9f80587c1c69b4d52a21dfc79f4b615125b1c	2026-09-23 18:40:12.868637+00	20250116001415_add_wavoip_token_to_settings_table	\N	\N	2026-09-23 18:40:12.678681+00	1
3f6030b6-78a1-4414-8c80-53e856d81b76	17983175f27c61a0ee6aaa42c94d665cabb7e904ee91c33f867c657512210e1a	2026-09-23 18:40:13.382022+00	20250225180031_add_nats_integration	\N	\N	2026-09-23 18:40:12.964264+00	1
4a215f26-845a-424a-b712-97634e53c6e1	36a19fe7711b98d02b450aedb2de8802b5e2e635a1e530cbc42f1d184e89bec3	2026-09-23 18:40:14.295777+00	20250613143000_add_lid_column_to_is_onwhatsapp	\N	\N	2026-09-23 18:40:14.262173+00	1
0b1d2813-16d3-44d4-8670-1c4aa4a59853	2b9d50b837a154ee3a74284c130b21fbe10ecddc1159cb29dac74c4ba4cb6a5f	2026-09-23 18:40:14.639842+00	20250918182355_add_kafka_integration	\N	\N	2026-09-23 18:40:14.304191+00	1
0b757984-faf7-45f1-9370-7ed9d15429d3	84053d218d69e85953f7533bbfced9171e762c02c88ab944aaaa75b17f18e161	2026-09-23 18:40:14.941389+00	20251122003044_add_chat_instance_remotejid_unique	\N	\N	2026-09-23 18:40:14.656884+00	1
\.


--
-- Name: Chat Chat_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Chat"
    ADD CONSTRAINT "Chat_pkey" PRIMARY KEY (id);


--
-- Name: Chatwoot Chatwoot_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Chatwoot"
    ADD CONSTRAINT "Chatwoot_pkey" PRIMARY KEY (id);


--
-- Name: Contact Contact_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Contact"
    ADD CONSTRAINT "Contact_pkey" PRIMARY KEY (id);


--
-- Name: DifySetting DifySetting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."DifySetting"
    ADD CONSTRAINT "DifySetting_pkey" PRIMARY KEY (id);


--
-- Name: Dify Dify_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Dify"
    ADD CONSTRAINT "Dify_pkey" PRIMARY KEY (id);


--
-- Name: EvoaiSetting EvoaiSetting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvoaiSetting"
    ADD CONSTRAINT "EvoaiSetting_pkey" PRIMARY KEY (id);


--
-- Name: Evoai Evoai_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Evoai"
    ADD CONSTRAINT "Evoai_pkey" PRIMARY KEY (id);


--
-- Name: EvolutionBotSetting EvolutionBotSetting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvolutionBotSetting"
    ADD CONSTRAINT "EvolutionBotSetting_pkey" PRIMARY KEY (id);


--
-- Name: EvolutionBot EvolutionBot_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvolutionBot"
    ADD CONSTRAINT "EvolutionBot_pkey" PRIMARY KEY (id);


--
-- Name: FlowiseSetting FlowiseSetting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."FlowiseSetting"
    ADD CONSTRAINT "FlowiseSetting_pkey" PRIMARY KEY (id);


--
-- Name: Flowise Flowise_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Flowise"
    ADD CONSTRAINT "Flowise_pkey" PRIMARY KEY (id);


--
-- Name: Instance Instance_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Instance"
    ADD CONSTRAINT "Instance_pkey" PRIMARY KEY (id);


--
-- Name: IntegrationSession IntegrationSession_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."IntegrationSession"
    ADD CONSTRAINT "IntegrationSession_pkey" PRIMARY KEY (id);


--
-- Name: IsOnWhatsapp IsOnWhatsapp_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."IsOnWhatsapp"
    ADD CONSTRAINT "IsOnWhatsapp_pkey" PRIMARY KEY (id);


--
-- Name: Kafka Kafka_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Kafka"
    ADD CONSTRAINT "Kafka_pkey" PRIMARY KEY (id);


--
-- Name: Label Label_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Label"
    ADD CONSTRAINT "Label_pkey" PRIMARY KEY (id);


--
-- Name: Media Media_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Media"
    ADD CONSTRAINT "Media_pkey" PRIMARY KEY (id);


--
-- Name: MessageUpdate MessageUpdate_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."MessageUpdate"
    ADD CONSTRAINT "MessageUpdate_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: N8nSetting N8nSetting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."N8nSetting"
    ADD CONSTRAINT "N8nSetting_pkey" PRIMARY KEY (id);


--
-- Name: N8n N8n_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."N8n"
    ADD CONSTRAINT "N8n_pkey" PRIMARY KEY (id);


--
-- Name: Nats Nats_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Nats"
    ADD CONSTRAINT "Nats_pkey" PRIMARY KEY (id);


--
-- Name: OpenaiBot OpenaiBot_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiBot"
    ADD CONSTRAINT "OpenaiBot_pkey" PRIMARY KEY (id);


--
-- Name: OpenaiCreds OpenaiCreds_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiCreds"
    ADD CONSTRAINT "OpenaiCreds_pkey" PRIMARY KEY (id);


--
-- Name: OpenaiSetting OpenaiSetting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_pkey" PRIMARY KEY (id);


--
-- Name: Proxy Proxy_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Proxy"
    ADD CONSTRAINT "Proxy_pkey" PRIMARY KEY (id);


--
-- Name: Pusher Pusher_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Pusher"
    ADD CONSTRAINT "Pusher_pkey" PRIMARY KEY (id);


--
-- Name: Rabbitmq Rabbitmq_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Rabbitmq"
    ADD CONSTRAINT "Rabbitmq_pkey" PRIMARY KEY (id);


--
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (id);


--
-- Name: Setting Setting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Setting"
    ADD CONSTRAINT "Setting_pkey" PRIMARY KEY (id);


--
-- Name: Sqs Sqs_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Sqs"
    ADD CONSTRAINT "Sqs_pkey" PRIMARY KEY (id);


--
-- Name: Template Template_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Template"
    ADD CONSTRAINT "Template_pkey" PRIMARY KEY (id);


--
-- Name: TypebotSetting TypebotSetting_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."TypebotSetting"
    ADD CONSTRAINT "TypebotSetting_pkey" PRIMARY KEY (id);


--
-- Name: Typebot Typebot_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Typebot"
    ADD CONSTRAINT "Typebot_pkey" PRIMARY KEY (id);


--
-- Name: Webhook Webhook_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Webhook"
    ADD CONSTRAINT "Webhook_pkey" PRIMARY KEY (id);


--
-- Name: Websocket Websocket_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Websocket"
    ADD CONSTRAINT "Websocket_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Chat_instanceId_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "Chat_instanceId_idx" ON evolution_api."Chat" USING btree ("instanceId");


--
-- Name: Chat_instanceId_remoteJid_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Chat_instanceId_remoteJid_key" ON evolution_api."Chat" USING btree ("instanceId", "remoteJid");


--
-- Name: Chat_remoteJid_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "Chat_remoteJid_idx" ON evolution_api."Chat" USING btree ("remoteJid");


--
-- Name: Chatwoot_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Chatwoot_instanceId_key" ON evolution_api."Chatwoot" USING btree ("instanceId");


--
-- Name: Contact_instanceId_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "Contact_instanceId_idx" ON evolution_api."Contact" USING btree ("instanceId");


--
-- Name: Contact_remoteJid_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "Contact_remoteJid_idx" ON evolution_api."Contact" USING btree ("remoteJid");


--
-- Name: Contact_remoteJid_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Contact_remoteJid_instanceId_key" ON evolution_api."Contact" USING btree ("remoteJid", "instanceId");


--
-- Name: DifySetting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "DifySetting_instanceId_key" ON evolution_api."DifySetting" USING btree ("instanceId");


--
-- Name: EvoaiSetting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "EvoaiSetting_instanceId_key" ON evolution_api."EvoaiSetting" USING btree ("instanceId");


--
-- Name: EvolutionBotSetting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "EvolutionBotSetting_instanceId_key" ON evolution_api."EvolutionBotSetting" USING btree ("instanceId");


--
-- Name: FlowiseSetting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "FlowiseSetting_instanceId_key" ON evolution_api."FlowiseSetting" USING btree ("instanceId");


--
-- Name: Instance_name_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Instance_name_key" ON evolution_api."Instance" USING btree (name);


--
-- Name: IsOnWhatsapp_remoteJid_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "IsOnWhatsapp_remoteJid_key" ON evolution_api."IsOnWhatsapp" USING btree ("remoteJid");


--
-- Name: Kafka_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Kafka_instanceId_key" ON evolution_api."Kafka" USING btree ("instanceId");


--
-- Name: Label_labelId_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Label_labelId_instanceId_key" ON evolution_api."Label" USING btree ("labelId", "instanceId");


--
-- Name: Media_messageId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Media_messageId_key" ON evolution_api."Media" USING btree ("messageId");


--
-- Name: MessageUpdate_instanceId_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "MessageUpdate_instanceId_idx" ON evolution_api."MessageUpdate" USING btree ("instanceId");


--
-- Name: MessageUpdate_messageId_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "MessageUpdate_messageId_idx" ON evolution_api."MessageUpdate" USING btree ("messageId");


--
-- Name: Message_instanceId_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "Message_instanceId_idx" ON evolution_api."Message" USING btree ("instanceId");


--
-- Name: N8nSetting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "N8nSetting_instanceId_key" ON evolution_api."N8nSetting" USING btree ("instanceId");


--
-- Name: Nats_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Nats_instanceId_key" ON evolution_api."Nats" USING btree ("instanceId");


--
-- Name: OpenaiCreds_apiKey_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "OpenaiCreds_apiKey_key" ON evolution_api."OpenaiCreds" USING btree ("apiKey");


--
-- Name: OpenaiCreds_name_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "OpenaiCreds_name_key" ON evolution_api."OpenaiCreds" USING btree (name);


--
-- Name: OpenaiSetting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "OpenaiSetting_instanceId_key" ON evolution_api."OpenaiSetting" USING btree ("instanceId");


--
-- Name: OpenaiSetting_openaiCredsId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "OpenaiSetting_openaiCredsId_key" ON evolution_api."OpenaiSetting" USING btree ("openaiCredsId");


--
-- Name: Proxy_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Proxy_instanceId_key" ON evolution_api."Proxy" USING btree ("instanceId");


--
-- Name: Pusher_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Pusher_instanceId_key" ON evolution_api."Pusher" USING btree ("instanceId");


--
-- Name: Rabbitmq_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Rabbitmq_instanceId_key" ON evolution_api."Rabbitmq" USING btree ("instanceId");


--
-- Name: Session_sessionId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Session_sessionId_key" ON evolution_api."Session" USING btree ("sessionId");


--
-- Name: Setting_instanceId_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "Setting_instanceId_idx" ON evolution_api."Setting" USING btree ("instanceId");


--
-- Name: Setting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Setting_instanceId_key" ON evolution_api."Setting" USING btree ("instanceId");


--
-- Name: Sqs_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Sqs_instanceId_key" ON evolution_api."Sqs" USING btree ("instanceId");


--
-- Name: Template_name_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Template_name_key" ON evolution_api."Template" USING btree (name);


--
-- Name: Template_templateId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Template_templateId_key" ON evolution_api."Template" USING btree ("templateId");


--
-- Name: TypebotSetting_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "TypebotSetting_instanceId_key" ON evolution_api."TypebotSetting" USING btree ("instanceId");


--
-- Name: Webhook_instanceId_idx; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE INDEX "Webhook_instanceId_idx" ON evolution_api."Webhook" USING btree ("instanceId");


--
-- Name: Webhook_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Webhook_instanceId_key" ON evolution_api."Webhook" USING btree ("instanceId");


--
-- Name: Websocket_instanceId_key; Type: INDEX; Schema: evolution_api; Owner: evolution
--

CREATE UNIQUE INDEX "Websocket_instanceId_key" ON evolution_api."Websocket" USING btree ("instanceId");


--
-- Name: Chat Chat_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Chat"
    ADD CONSTRAINT "Chat_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Chatwoot Chatwoot_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Chatwoot"
    ADD CONSTRAINT "Chatwoot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Contact Contact_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Contact"
    ADD CONSTRAINT "Contact_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DifySetting DifySetting_difyIdFallback_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."DifySetting"
    ADD CONSTRAINT "DifySetting_difyIdFallback_fkey" FOREIGN KEY ("difyIdFallback") REFERENCES evolution_api."Dify"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DifySetting DifySetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."DifySetting"
    ADD CONSTRAINT "DifySetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Dify Dify_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Dify"
    ADD CONSTRAINT "Dify_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EvoaiSetting EvoaiSetting_evoaiIdFallback_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvoaiSetting"
    ADD CONSTRAINT "EvoaiSetting_evoaiIdFallback_fkey" FOREIGN KEY ("evoaiIdFallback") REFERENCES evolution_api."Evoai"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EvoaiSetting EvoaiSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvoaiSetting"
    ADD CONSTRAINT "EvoaiSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Evoai Evoai_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Evoai"
    ADD CONSTRAINT "Evoai_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EvolutionBotSetting EvolutionBotSetting_botIdFallback_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvolutionBotSetting"
    ADD CONSTRAINT "EvolutionBotSetting_botIdFallback_fkey" FOREIGN KEY ("botIdFallback") REFERENCES evolution_api."EvolutionBot"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EvolutionBotSetting EvolutionBotSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvolutionBotSetting"
    ADD CONSTRAINT "EvolutionBotSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EvolutionBot EvolutionBot_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."EvolutionBot"
    ADD CONSTRAINT "EvolutionBot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FlowiseSetting FlowiseSetting_flowiseIdFallback_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."FlowiseSetting"
    ADD CONSTRAINT "FlowiseSetting_flowiseIdFallback_fkey" FOREIGN KEY ("flowiseIdFallback") REFERENCES evolution_api."Flowise"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: FlowiseSetting FlowiseSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."FlowiseSetting"
    ADD CONSTRAINT "FlowiseSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Flowise Flowise_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Flowise"
    ADD CONSTRAINT "Flowise_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IntegrationSession IntegrationSession_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."IntegrationSession"
    ADD CONSTRAINT "IntegrationSession_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kafka Kafka_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Kafka"
    ADD CONSTRAINT "Kafka_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Label Label_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Label"
    ADD CONSTRAINT "Label_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Media Media_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Media"
    ADD CONSTRAINT "Media_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Media Media_messageId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Media"
    ADD CONSTRAINT "Media_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES evolution_api."Message"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MessageUpdate MessageUpdate_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."MessageUpdate"
    ADD CONSTRAINT "MessageUpdate_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MessageUpdate MessageUpdate_messageId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."MessageUpdate"
    ADD CONSTRAINT "MessageUpdate_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES evolution_api."Message"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Message"
    ADD CONSTRAINT "Message_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_sessionId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Message"
    ADD CONSTRAINT "Message_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES evolution_api."IntegrationSession"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: N8nSetting N8nSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."N8nSetting"
    ADD CONSTRAINT "N8nSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: N8nSetting N8nSetting_n8nIdFallback_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."N8nSetting"
    ADD CONSTRAINT "N8nSetting_n8nIdFallback_fkey" FOREIGN KEY ("n8nIdFallback") REFERENCES evolution_api."N8n"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: N8n N8n_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."N8n"
    ADD CONSTRAINT "N8n_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Nats Nats_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Nats"
    ADD CONSTRAINT "Nats_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiBot OpenaiBot_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiBot"
    ADD CONSTRAINT "OpenaiBot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiBot OpenaiBot_openaiCredsId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiBot"
    ADD CONSTRAINT "OpenaiBot_openaiCredsId_fkey" FOREIGN KEY ("openaiCredsId") REFERENCES evolution_api."OpenaiCreds"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiCreds OpenaiCreds_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiCreds"
    ADD CONSTRAINT "OpenaiCreds_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiSetting OpenaiSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OpenaiSetting OpenaiSetting_openaiCredsId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_openaiCredsId_fkey" FOREIGN KEY ("openaiCredsId") REFERENCES evolution_api."OpenaiCreds"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OpenaiSetting OpenaiSetting_openaiIdFallback_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."OpenaiSetting"
    ADD CONSTRAINT "OpenaiSetting_openaiIdFallback_fkey" FOREIGN KEY ("openaiIdFallback") REFERENCES evolution_api."OpenaiBot"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Proxy Proxy_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Proxy"
    ADD CONSTRAINT "Proxy_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Pusher Pusher_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Pusher"
    ADD CONSTRAINT "Pusher_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Rabbitmq Rabbitmq_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Rabbitmq"
    ADD CONSTRAINT "Rabbitmq_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Session Session_sessionId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Session"
    ADD CONSTRAINT "Session_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Setting Setting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Setting"
    ADD CONSTRAINT "Setting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Sqs Sqs_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Sqs"
    ADD CONSTRAINT "Sqs_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Template Template_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Template"
    ADD CONSTRAINT "Template_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TypebotSetting TypebotSetting_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."TypebotSetting"
    ADD CONSTRAINT "TypebotSetting_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TypebotSetting TypebotSetting_typebotIdFallback_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."TypebotSetting"
    ADD CONSTRAINT "TypebotSetting_typebotIdFallback_fkey" FOREIGN KEY ("typebotIdFallback") REFERENCES evolution_api."Typebot"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Typebot Typebot_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Typebot"
    ADD CONSTRAINT "Typebot_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Webhook Webhook_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Webhook"
    ADD CONSTRAINT "Webhook_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Websocket Websocket_instanceId_fkey; Type: FK CONSTRAINT; Schema: evolution_api; Owner: evolution
--

ALTER TABLE ONLY evolution_api."Websocket"
    ADD CONSTRAINT "Websocket_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES evolution_api."Instance"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict v52WNK4u2HORpbHp0jTzVRZO4fh9sSquO2GYWLAYEhasAOpGynK4HGboyXd2Egi

