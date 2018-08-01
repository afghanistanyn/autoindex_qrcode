
local qr = require("qrencode")
local args = ngx.req.get_uri_args()
local app = args.app

if app == nil or app == "" then
	ngx.say('need a app param')
	ngx.exit(404)
end

ngx.say(qr {
                    text=app,
                    level="L",
                    kanji=false,
                    ansi=false,
                    size=4,
                    margin=2,
                    symversion=0,
                    dpi=78,
                    casesensitive=true,
                    foreground="000000",
                    background="FFFFFF"
            })

