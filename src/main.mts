import { HOME_AUTOMATION } from "./app.module.mts";

void HOME_AUTOMATION.bootstrap({
  // set to true if you want to run commands at boot without using lifecycle events
  // will defer loading your code until dependencies are fully initialized
  bootLibrariesFirst: false, // default value

  // Hard code overrides to library default configurations
  // These can also be set via .env with this pattern: {library}_{var} ex: SYNAPSE_SQLITE_DB
  configuration: {
    boilerplate: {
      /**
       * ## Available options in decreasing verbosity -
       * trace  = verbose chatter about work being performed (BIG NOISY)
       * debug  = extra details about work being performed (good default level)
       * info   = general messages
       * warn   = correctable workflow errors
       * error  = major issue in workflow
       * silent = can't get less verbose than this
       */
      LOG_LEVEL: "info",
    },
    /**
     * ℹ️ Options you might want if running more than 1 app or on multiple machines
     */
    synapse: {
      /**
       * Default value considers machine host name & app name. If value changes, synapse will require re-integration.
       * Set to stable value if you want dev/prod setup while preserving common entities.
       *
       * ⚠️ entity states are associated with db
       * this may trigger automation logic if the internal state database is not kept in sync between machines
       */
      // METADATA_UNIQUE_ID: "my_synapse_app",
      /**
       * This file contains internal runtime state, used to preserve entity state between boots
       * Default values used if file not found / deleted
       */
      // SQLITE_DB: "/path/to/alternate/sqlite.db",
    },
  },
});
