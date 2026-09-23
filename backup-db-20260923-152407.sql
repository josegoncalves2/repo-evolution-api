--
-- PostgreSQL database dump
--

\restrict vZW4Fo99Cc4mnUZXet5RtcuxTbLjfOxHyIznFMoY5CSkfwm6FZ4TDddfKcsVFD1

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
1dc8ef13-cede-4210-809a-4c1816ee91d0	whatsapp	open	\N	\N	EVOLUTION	5517996058155	A496EAA4611E-4A2C-A5BE-FDB483E80D02	evolution_exchange	2026-09-23 15:50:43.561	2026-09-23 15:50:43.561	\N	\N	\N	\N	\N
63abda9a-ad32-431f-9bfa-7de88c3a7413	teste	open	\N	\N	EVOLUTION	5517996058155	A3CAA895B6DD-478A-B964-42AFED3F239B	evolution_exchange	2026-09-23 15:52:23.106	2026-09-23 15:52:23.106	\N	\N	\N	\N	\N
4f288d33-9257-4cf6-b2a8-5c3e8f545376	meu-celular	connecting	\N	\N	WHATSAPP-BAILEYS	\N	71F6D487-432A-4E22-9A9F-12565278DEEA	evolution_exchange	2026-09-23 15:59:08.992	2026-09-23 18:23:43.728	\N	\N	\N	\N	\N
c5f26a13-6df8-40c4-9fa8-20b5d1c3019a	qr-teste	connecting	\N	\N	WHATSAPP-BAILEYS	\N	074ED799-DB9C-40EF-B0C0-F15660F5C9E7	evolution_exchange	2026-09-23 18:14:52.331	2026-09-23 18:23:43.923	\N	\N	\N	\N	\N
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
cmueahihc000ftepln0lrgq51	{"id": "a7d4d444-aed7-43e3-add6-f8e6681dead9", "fromMe": true, "remoteJid": "5517996058155"}	\N	\N	conversation	{"conversation": "Olá! Esta é uma mensagem de teste enviada pela Evolution API. Se você recebeu esta mensagem, a stack Evolution está funcionando perfeitamente! 🚀"}	\N	unknown	1790179220	\N	\N	\N	\N	\N	1dc8ef13-cede-4210-809a-4c1816ee91d0	\N	\N	PENDING
cmueb9so4000hteplz4lwor4z	{"id": "11fd7d63-c822-4023-98d2-d465d1c15bf2", "fromMe": true, "remoteJid": "5517996058155"}	\N	\N	conversation	{"conversation": "Olá, teste de mensagem! Funcionando. ✅"}	\N	unknown	1790180537	\N	\N	\N	\N	\N	63abda9a-ad32-431f-9bfa-7de88c3a7413	\N	\N	PENDING
cmuebbn9x000jtepl25gg0prr	{"id": "4621b246-4dd0-4f9c-8ec0-f194ade66c71", "fromMe": true, "remoteJid": "5517996058155"}	\N	\N	conversation	{"conversation": "uma msg"}	\N	unknown	1790180626	\N	\N	\N	\N	\N	63abda9a-ad32-431f-9bfa-7de88c3a7413	\N	\N	PENDING
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
cmueafzzt000dteplyyff3sku	4f288d33-9257-4cf6-b2a8-5c3e8f545376	"{\\"noiseKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"OMv8xUDeS5kjeHJ9MDDLv/FKJb+0PPG/Ew/nlvd06EA=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"hTjJZWkA/kuSIFUEDvkDF+lHE6nvwxBKege2f1IuADI=\\"}},\\"pairingEphemeralKeyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"gKgDq6jIIWeqbWtxTwkPGiKQM2LswEjQgqzqwuOhSHY=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"Y7UjZXiInquBhnlWuf7ZXwDS0USctpoVLY2Edat+VHE=\\"}},\\"signedIdentityKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"MMEBYUrpbhJTpQxKgOIFK2hpe+owXN7XVNpYkDbEfnk=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"G0UnYa7o672lf1ltgqWBMZnVfHSz0DQJPoUkGURkF0E=\\"}},\\"signedPreKey\\":{\\"keyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"cHJ2IXlL3EGHIXR5eB+r8RXSzyeLLEFgfHXpADUhpEw=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"TeazV/dwZZnvlkbULy19XCh4uI6ZaIQq1rCWeMFvfSM=\\"}},\\"signature\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"avqzjzzxrBytxvXlnDYIgX36zbGnVePTvj9W2y6RuzY/6te+xFAMXTntpYkdc/cjRS7imN3e1YMxgnAtPUeGAw==\\"},\\"keyId\\":1},\\"registrationId\\":67,\\"advSecretKey\\":\\"e4eSkC+0jTh6/0ZshGvSepbwt5B7cf+r7Ce0NDnusgg=\\",\\"processedHistoryMessages\\":[],\\"nextPreKeyId\\":1,\\"firstUnuploadedPreKeyId\\":1,\\"accountSyncCounter\\":0,\\"accountSettings\\":{\\"unarchiveChats\\":false},\\"deviceId\\":\\"0I1Q_GD-SGSiHOTqaiXnNw\\",\\"phoneId\\":\\"708989f5-b2a8-40cd-9b36-1e3dc6996628\\",\\"identityId\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"XFgP4VNdiqcLlYxN5FUnnpmHylQ=\\"},\\"registered\\":false,\\"backupToken\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"uMLw1P+Hk4ei9gfp/NIAQw1b1Uw=\\"},\\"registration\\":{}}"	2026-09-23 15:59:09.305
cmuefajet0003og4sgqb5j15t	c5f26a13-6df8-40c4-9fa8-20b5d1c3019a	"{\\"noiseKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"iHSatDtXk3o236L1Aiun/JKGxrSTKH36YRGgSb4cMno=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"6iThncvYq2iZmzRGdV3F4sCx+ZtcTtTjNPdhNLOE2Tw=\\"}},\\"pairingEphemeralKeyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"4Mivr6LkHaLbbnvDNdfRz0Xtr8FZqmMQm6M/2pYP7X4=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"m+aZvq4coK5Q7HhaDw7y0MDszgQcExdOyGlL4EjCFyM=\\"}},\\"signedIdentityKey\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"yKqJJ8kBgTUqzkBVB7o2ZmFV5m93fTsSX9q3VRTX6V0=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"4S+UmSEAdK65/F7bgCPLXq9pCiZ0r75xE2P75lQDWik=\\"}},\\"signedPreKey\\":{\\"keyPair\\":{\\"private\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"YHs+tlXE4d+2g52DjzrVfs1ho4M4zZyr87SLb8J8GEs=\\"},\\"public\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"QMyrSyHUSMLHdTt3Do6JEattp0Q/f6+RL0Enc8RreRI=\\"}},\\"signature\\":{\\"type\\":\\"Buffer\\",\\"data\\":\\"UN9KWvKNn0MRHYkgacxdLFzAROJMx7kumG/FLlo6LoZDf7J4JgjTcEkVOdhR00YJYg+TpiKiN8aKR285o2NHAA==\\"},\\"keyId\\":1},\\"registrationId\\":69,\\"advSecretKey\\":\\"TH1VQmyJu6AwZdUmQkzErYNZazomdhgY87eudAeY7OE=\\",\\"processedHistoryMessages\\":[],\\"nextPreKeyId\\":1,\\"firstUnuploadedPreKeyId\\":1,\\"accountSyncCounter\\":0,\\"accountSettings\\":{\\"unarchiveChats\\":false},\\"registered\\":false}"	2026-09-23 18:14:52.613
\.


--
-- Data for Name: Setting; Type: TABLE DATA; Schema: evolution_api; Owner: evolution
--

COPY evolution_api."Setting" (id, "rejectCall", "msgCall", "groupsIgnore", "alwaysOnline", "readMessages", "readStatus", "syncFullHistory", "createdAt", "updatedAt", "instanceId", "wavoipToken") FROM stdin;
cmuea55sd0007tepljq4fx99e	f		f	f	f	f	f	2026-09-23 15:50:43.595	2026-09-23 15:50:43.595	1dc8ef13-cede-4210-809a-4c1816ee91d0	\N
cmuea7akx0009teplyqh23cuu	f		f	f	f	f	f	2026-09-23 15:52:23.121	2026-09-23 15:52:23.121	63abda9a-ad32-431f-9bfa-7de88c3a7413	\N
cmueafzw3000bteplbx29e090	f		f	f	f	f	f	2026-09-23 15:59:09.171	2026-09-23 15:59:09.171	4f288d33-9257-4cf6-b2a8-5c3e8f545376	\N
cmuefaj9l0001og4s6zmozob6	f		f	f	f	f	f	2026-09-23 18:14:52.426	2026-09-23 18:14:52.426	c5f26a13-6df8-40c4-9fa8-20b5d1c3019a	
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
0604ed84-a1b2-425e-beb8-d0083ee6db19	1af30cbbccd90152fbb1b99a458978e42428a792b822b4b5f9c9c7fffbf7264f	2026-09-23 14:56:06.965659+00	20240819154941_add_context_to_integration_session	\N	\N	2026-09-23 14:56:06.931962+00	1
cb0fd7d5-dfe8-4610-b361-9de4579ea5f5	7507eff6b49fad53cdd0b3ace500f529597dfa1a8987afbb9807968a8ee8ef49	2026-09-23 14:55:55.911281+00	20240609181238_init	\N	\N	2026-09-23 14:55:48.071064+00	1
fc61c01a-31a6-40e1-94cd-2e6987ac359c	8c2a595975dc2f6dee831983304996e25c37014c48291576e7c8044078bfde32	2026-09-23 14:56:01.421556+00	20240722173259_add_name_column_to_openai_creds	\N	\N	2026-09-23 14:56:01.345739+00	1
069cdaf8-3498-4c62-aa1b-9849119e20d8	914eeefb9eba0dacdbcb7cdbe47567abd957543d6f27c39db4eec6a40c864008	2026-09-23 14:55:56.269538+00	20240610144159_create_column_profile_name_instance	\N	\N	2026-09-23 14:55:56.027138+00	1
e6ae393b-01de-4263-937b-83f972fb1f21	50d6920345af06dbd5086959784b7e2b4d163a5b555ff1029e5f81678a454444	2026-09-23 14:55:56.900183+00	20240611125754_create_columns_whitelabel_chatwoot	\N	\N	2026-09-23 14:55:56.355096+00	1
52403203-0d97-492c-b69d-cefc187829ac	c29ccc88930138c50091712466f3f97bff48f6a0f486dcec5b19dc08c3612973	2026-09-23 14:56:03.999706+00	20240729180347_modify_typebot_session_status_openai_typebot_table	\N	\N	2026-09-23 14:56:03.338147+00	1
ec307f13-5e1e-407e-8eda-ca7150c50401	b90c49299ed812fb46b71a4f0b9f818b7fc7109c52b1aff227a107236839d93c	2026-09-23 14:55:57.382539+00	20240611202817_create_columns_debounce_time_typebot	\N	\N	2026-09-23 14:55:56.970291+00	1
2e658864-e3ce-488b-97cc-98f30f9240d0	20b3c04d93799c25fa8b2d0a85d10f9280e915a5d7519542492ed85ff082a3c0	2026-09-23 14:56:01.455039+00	20240722173518_add_name_column_to_openai_creds	\N	\N	2026-09-23 14:56:01.430148+00	1
f6196ebd-5487-46ee-85c4-c43a176fe93c	01303057a037f5dc28272ac513b60d5a75be71d1bf727e671ca538db3268fa2e	2026-09-23 14:55:57.624767+00	20240712144948_add_business_id_column_to_instances	\N	\N	2026-09-23 14:55:57.422865+00	1
f4047ba2-6bbe-4d6b-9f42-8b0e79b91fbe	34235c250eb1f088c285489ad690b4c045680f1638076436cdc66de0ea382cc2	2026-09-23 14:55:58.634931+00	20240712150256_create_templates_table	\N	\N	2026-09-23 14:55:57.650089+00	1
5f88868f-e17c-419e-a203-d84fc95764e1	0ba192ba428c9ab5a9b31d1f7d73603ee47b6192e2f8c590f6d93ade0dbdbccf	2026-09-23 14:55:58.903118+00	20240712155950_adjusts_in_templates_table	\N	\N	2026-09-23 14:55:58.718712+00	1
899216c0-4866-4deb-a971-d051a56c119d	7ffb91b84cb7aa17b1f488d580626144cd557ccdfaec6654515545401d1938af	2026-09-23 14:56:01.729632+00	20240723152648_adjusts_in_column_openai_creds	\N	\N	2026-09-23 14:56:01.463806+00	1
bb39ccd3-08b4-4a5e-845c-eb0b9af0fa81	426256b73f7ea52538dc91a890179c841325a9c387cf02885b81971d582af830	2026-09-23 14:55:58.996939+00	20240712162206_remove_templates_table	\N	\N	2026-09-23 14:55:58.945414+00	1
c5b3d25e-6540-4de9-a2bd-fc0c99591251	3496739609829e80daf733baecd3d3e4e279bf318a99adc1ca3aa1c76f893b2f	2026-09-23 14:55:59.080797+00	20240712223655_column_fallback_typebot	\N	\N	2026-09-23 14:55:59.030695+00	1
66d41763-bd23-42ff-8329-ad4febe56c60	c8627bad5d72ee4ef774ed32c95a2524517b0c60c49fa67cd4ba9dff7cbdde3b	2026-09-23 14:56:06.09285+00	20240811021156_add_chat_name_column	\N	\N	2026-09-23 14:56:05.956498+00	1
0e028001-1e31-47c4-af9c-a00ea485cee8	bea48f697c0c5db52ade4a3f26c1321e3f5611c80ea50384baa54e58c6b3a79e	2026-09-23 14:55:59.123205+00	20240712230631_column_ignore_jids_typebot	\N	\N	2026-09-23 14:55:59.099474+00	1
00b446b1-172b-43b5-b6b4-80266a92cb65	3056f8f1335e8933e4098f005e33cd4821190be2eb76520c0d01e2e13cf6e073	2026-09-23 14:56:01.902019+00	20240723200254_add_webhookurl_on_message	\N	\N	2026-09-23 14:56:01.827374+00	1
7bd6abb1-4c92-429f-a107-9cb1afc5f3b6	1bac56740af5d2d6512b29e7a6e0721d69b2a290400f6660b92b6f2d8b30cd6e	2026-09-23 14:55:59.534512+00	20240713184337_add_media_table	\N	\N	2026-09-23 14:55:59.140056+00	1
c5a6184c-0736-490b-86f2-d7658ad54f88	bdd992b253321ca9a9556e30fea5e7760556cb8e80140aec34066301b55dc675	2026-09-23 14:56:01.296604+00	20240718121437_add_openai_tables	\N	\N	2026-09-23 14:55:59.669072+00	1
5a47ec63-cd8b-467c-a514-b220a65d92f1	961a8627684fe1e4c7123565db3d16db30768df41881342032f9a2df16145eaf	2026-09-23 14:56:05.138545+00	20240730152156_create_dify_tables	\N	\N	2026-09-23 14:56:04.017411+00	1
412f8db4-667f-41a5-bb4e-3999c8052cf8	8147ec0cc86ac30ea1be05d461559ba5064273a3fcb3227af71ddcd895f5aebe	2026-09-23 14:56:01.337464+00	20240718123923_adjusts_openai_tables	\N	\N	2026-09-23 14:56:01.305128+00	1
4c8a7260-d952-4601-954e-f80e21890643	9d6c9b4ffe51483a851f6507f7aefd2fb34f54a7c28961856e3230fda4f87022	2026-09-23 14:56:02.876695+00	20240725184147_create_template_table	\N	\N	2026-09-23 14:56:01.935737+00	1
6fddc1c8-401f-45c9-b13b-26008d9d247f	94e2edb21107895c77b24402f41cd020c7f74dbb39b9a95664a45e62e2582be9	2026-09-23 14:56:02.953017+00	20240725202651_add_webhook_url_template_table	\N	\N	2026-09-23 14:56:02.902609+00	1
2189c8f0-16cd-4a65-965e-eaffe7c54549	d0da588e4204c50bde2e41a615b9301afca072991033545b6f4e3e34e088db87	2026-09-23 14:56:03.056364+00	20240725221646_modify_token_instance_table	\N	\N	2026-09-23 14:56:02.979498+00	1
9a8d2fe9-8694-4a5f-aa02-21327c447749	b56b053451d564ff6282078fad4fc7bff4aa71e3b0b8d00bf219da4ed1bc4c86	2026-09-23 14:56:05.205683+00	20240801193907_add_column_speech_to_text_openai_setting_table	\N	\N	2026-09-23 14:56:05.169959+00	1
7e500bc6-02ab-4f13-9559-7c9b04f16994	a80f5c27cd80d088ea69153f8d6f4879406770ffa5a7fd50b28da82bd020322e	2026-09-23 14:56:03.321199+00	20240729115127_modify_trigger_type_openai_typebot_table	\N	\N	2026-09-23 14:56:03.09554+00	1
3d63d066-9ebc-490a-a942-40c8c9ac3fbf	428a9148f2a29f773e0c9813149e6d07bf51765e018652aeac0be2141a722b67	2026-09-23 14:56:06.504209+00	20240814173033_add_ignore_jids_chatwoot	\N	\N	2026-09-23 14:56:06.404035+00	1
3dcb9d0f-3832-4200-9b58-44c0330a765e	2b963cbc826ea024f9a643af2d5d9fcea06717c90ec9bacb255d3836efa06aea	2026-09-23 14:56:05.334434+00	20240803163908_add_column_description_on_integrations_table	\N	\N	2026-09-23 14:56:05.222817+00	1
e931eff5-12c8-4cc2-83aa-7efe02c85170	ee44f0420384d55de6d252fffb8f2cfa88479e5811e14cfe975d8edfcc6957e0	2026-09-23 14:56:06.239212+00	20240811183328_add_unique_index_for_remoted_jid_and_instance_in_contacts	\N	\N	2026-09-23 14:56:06.147274+00	1
02eb8510-8e5e-4408-8053-e9cf9331f180	4d2dd947ebb7515c7c278472a10ebab6d5f41a5ef60e15df717a05d457d5d2aa	2026-09-23 14:56:05.901376+00	20240808210239_add_column_function_url_openaibot_table	\N	\N	2026-09-23 14:56:05.52629+00	1
cc22fc8b-590f-4436-9978-81dc77f30a1e	29c330029a48aaee63567e63c4f4e57b7c1f5344162b11fbf61a4dc194547861	2026-09-23 14:56:06.360554+00	20240813003116_make_label_unique_for_instance	\N	\N	2026-09-23 14:56:06.247788+00	1
1aeb7606-2e65-4a15-a49f-1872ab030347	bc5cd1c7fb4df72e88cb4856c9c49ea340284c9d8f389fe558008a921494ed82	2026-09-23 14:56:06.923665+00	20240817110155_add_trigger_type_advanced	\N	\N	2026-09-23 14:56:06.898617+00	1
7ae8a76f-93d0-4299-bc5e-bafa423a9b8f	e1eb8997ac99fd555b8a9241c817b97fa5614124922b4e6b3cb1751e9e2199c7	2026-09-23 14:56:06.889848+00	20240814202359_integrations_unification	\N	\N	2026-09-23 14:56:06.588286+00	1
f92bed20-ae27-48da-9b8a-320edb5f1016	a363a9ebc5bb526e504c4e6f71ed7702a5b6d317db6a9981f36c4560f9147fba	2026-09-23 14:56:07.040966+00	20240821120816_bot_id_integration_session	\N	\N	2026-09-23 14:56:06.974111+00	1
a5950e8d-1c28-4384-9eab-7545dd01d161	e31947e6c709ee3a62504980ae9ab1ffbfd9faf0cf9ac389cfd6435734c49902	2026-09-23 14:56:08.169686+00	20240821171327_add_generic_bot_table	\N	\N	2026-09-23 14:56:07.04949+00	1
839a1147-6117-406a-9728-4fba1751b210	18dde8e48c49a97f33f5b789ccd919326253c26d43af72c77f6b13d4285ffba8	2026-09-23 14:56:08.824413+00	20240821194524_add_flowise_table	\N	\N	2026-09-23 14:56:08.187044+00	1
9c4d4127-24f7-46ae-a17e-907e1e5b2dc8	0148a09e0e5eedafe5c5169c6351201a5c70ebaa853456693d75a7b82a851dbe	2026-09-23 14:56:08.857088+00	20240824161333_add_type_on_integration_sessions	\N	\N	2026-09-23 14:56:08.83299+00	1
cbf2604f-8bbb-416c-89b9-480d41186d3d	710e7ee3aabf07aa6ee9bf2865c09f75d461efa5724dd83f5a6f324ea1e5e47c	2026-09-23 14:56:09.208625+00	20240825130616_change_to_evolution_bot	\N	\N	2026-09-23 14:56:08.865665+00	1
2c0996d6-f862-458d-ad5f-ee316c66c0cd	0a6034359b1cf68820e829d31402032eed0f77586fb1ee590a98f5a6c3e15847	2026-09-23 17:59:23.562364+00	20250514232744_add_n8n_table	\N	\N	2026-09-23 17:59:22.319491+00	1
ecc89603-d99f-4928-a9dd-f5b9bcb0136b	d03a8a31df36eb0a07e80cd2a149b6d826e69bb2cb21fbe69943ae5ffba672ad	2026-09-23 14:56:09.51048+00	20240828140837_add_is_on_whatsapp_table	\N	\N	2026-09-23 14:56:09.217412+00	1
daa835d7-fe20-4e52-89fd-cf9889873045	e927e00343b622bee7dab1b9b5c9fdd95007bfaf9d705ec52db9ecb05fb3d078	2026-09-23 14:56:09.653008+00	20240828141556_remove_name_column_from_on_whatsapp_table	\N	\N	2026-09-23 14:56:09.527343+00	1
e7632214-ab89-4c97-8ad3-72779a228bf7	cf00d8ef2c28cf94aea51e7e2a80ddd65474a4f6c1113abc65dea6cc194c1a57	2026-09-23 14:56:10.038724+00	20240830193533_changed_table_case	\N	\N	2026-09-23 14:56:09.721522+00	1
1042fb24-1d04-46b6-bca9-809d75003d2b	f9ddf352b22e52a1f466d40df95da7bd6f4bf51310c07911d9c990f720e1fe81	2026-09-23 17:59:24.9056+00	20250515211815_add_evoai_table	\N	\N	2026-09-23 17:59:23.600857+00	1
adb28b53-869c-4ef3-9aeb-0dae8a6e8dc2	1cc60b9c38db62b694f753e2ee4c155e95c66815b5800f6ddb6f7cddec23b1ad	2026-09-23 14:56:10.106514+00	20240906202019_add_headers_on_webhook_config	\N	\N	2026-09-23 14:56:10.064197+00	1
230aa222-6254-44c4-88a3-2b480ca18fee	7dff7227c1e013127210ab4f77b91dc24eae14bcd07f21fb27aaa2fa82b23865	2026-09-23 17:59:16.394642+00	20241001180457_add_message_status	\N	\N	2026-09-23 17:59:15.901584+00	1
ae123aaa-be6b-48c9-b6a0-771c4cd3b6e8	07449acbac59175f82670f34664c1dcea4d34f9a1710f19bd3396e26868db09e	2026-09-23 17:59:17.307687+00	20241006130306_alter_status_on_message_table	\N	\N	2026-09-23 17:59:16.428454+00	1
3c4055d5-4af2-4575-a3c6-fd4840d7cb04	7a03627d41844a016b28b4194e36eea0e52cd24be0061535fecba4ccbd0e72f4	2026-09-23 17:59:24.947588+00	20250516012152_remove_unique_atribute_for_file_name_in_media	\N	\N	2026-09-23 17:59:24.913777+00	1
47d90437-79b2-46c6-98ef-fa0abcbf2d12	7e9a7c45f05285e9fea38ccfa4266790a099107605299d81c309e689c06494ef	2026-09-23 17:59:17.358239+00	20241007164026_add_unread_messages_on_chat_table	\N	\N	2026-09-23 17:59:17.316285+00	1
c4a37ad3-88f4-4bef-bd2e-082e3da5717d	7e3e4686eb8009cbf0f71e8606a442b1c2862673dbc654b3f36f39a36efcb586	2026-09-23 17:59:18.037475+00	20241011085129_create_pusher_table	\N	\N	2026-09-23 17:59:17.366689+00	1
3389f932-d338-4d50-9f16-069b068f845e	270e1e51c7b9d24c0e68708ad167cb5748d591fd194ad422486574a0e83c0b79	2026-09-23 17:59:18.170587+00	20241011100803_split_messages_and_time_per_char_integrations	\N	\N	2026-09-23 17:59:18.045296+00	1
50e7a751-b9be-45e4-92f2-80cf98987cc5	3fca4961d4e7fa8e1a99e3ec6b072d235bec706b7463ab699887be1084e3b656	2026-09-23 17:59:25.056378+00	20250612155048_add_coluns_trypebot_tables	\N	\N	2026-09-23 17:59:24.989221+00	1
55e78f4c-b7fc-4320-829b-ce6759239622	e82282df963a32556a9c8cd5fd908dd5810d4c35f0d7765ab9e844ebad1106a2	2026-09-23 17:59:20.291403+00	20241017144950_create_index	\N	\N	2026-09-23 17:59:18.178858+00	1
0570a82e-44ed-436c-8900-dbd6c4b35260	668e44d3cd8caafa8f60f89805e9f80587c1c69b4d52a21dfc79f4b615125b1c	2026-09-23 17:59:20.682879+00	20250116001415_add_wavoip_token_to_settings_table	\N	\N	2026-09-23 17:59:20.426279+00	1
fb6ca0a2-814e-4678-a82d-9cc5e09f8174	17983175f27c61a0ee6aaa42c94d665cabb7e904ee91c33f867c657512210e1a	2026-09-23 17:59:22.310186+00	20250225180031_add_nats_integration	\N	\N	2026-09-23 17:59:20.835461+00	1
0e9b63a0-b70f-4d8e-b0a6-18a348ad97ea	36a19fe7711b98d02b450aedb2de8802b5e2e635a1e530cbc42f1d184e89bec3	2026-09-23 17:59:25.09027+00	20250613143000_add_lid_column_to_is_onwhatsapp	\N	\N	2026-09-23 17:59:25.064829+00	1
f5addf8c-30a2-420b-a372-362d9dfdfced	2b9d50b837a154ee3a74284c130b21fbe10ecddc1159cb29dac74c4ba4cb6a5f	2026-09-23 17:59:26.175523+00	20250918182355_add_kafka_integration	\N	\N	2026-09-23 17:59:25.098855+00	1
65e8bb26-e947-482c-a2cd-cbb0eda30517	84053d218d69e85953f7533bbfced9171e762c02c88ab944aaaa75b17f18e161	2026-09-23 17:59:27.339197+00	20251122003044_add_chat_instance_remotejid_unique	\N	\N	2026-09-23 17:59:26.309618+00	1
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

\unrestrict vZW4Fo99Cc4mnUZXet5RtcuxTbLjfOxHyIznFMoY5CSkfwm6FZ4TDddfKcsVFD1

