local log = require("structlog")

-- https://github.com/Tastyep/structlog.nvim

log.configure({
    dgronskiy_nvim = {
        pipelines = {
            {
                level = log.level.WARN,
                processors = {},
                formatter = log.formatters.Format( --
                    "%s",
                    { "msg" },
                    { blacklist = { "level", "logger_name" } }
                ),
                sink = log.sinks.NvimNotify(),
            },
            {
                level = log.level.INFO,
                processors = {
                    log.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 1 }),
                    log.processors.Timestamper("%H:%M:%S"),
                },
                formatter = log.formatters.FormatColorizer( --
                    "%s [%s] %s: %-30s",
                    { "timestamp", "level", "logger_name", "msg" },
                    { level = log.formatters.FormatColorizer.color_level() }
                ),
                sink = log.sinks.Console(),
            },
            {
                level = log.level.TRACE,
                processors = {
                    log.processors.StackWriter({ "line", "file" }, { max_parents = 3, stack_level = 1 }),
                    log.processors.Timestamper("%H:%M:%S"),
                },
                formatter = log.formatters.Format( --
                    "%s [%s] %s: %-30s",
                    { "timestamp", "level", "logger_name", "msg" }
                ),
                sink = log.sinks.File(vim.fn.stdpath("log") .. "/dgronskiy_nvim.log"),
            },
        },
    },
})

local logger = log.get_logger("dgronskiy_nvim")
return logger
