local popup_img_scrpit = [[
<script type="text/javascript">
var links = document.querySelectorAll('a')
var popup = document.querySelector('.popup-img')
for (var index = 0; index < links.length; index++) {
    var element = links[index];

    element.onmouseover = (function(){
     return function(event) {
        var target = event.target
        var appName = target.getAttribute('href')
        if (appName !== '../') {
            var picPath = '//' + location.host + '/qrcode?app=' + location.href  + appName
            popup.setAttribute('src', picPath)
            popup.style.display = 'block'
            popup.style.position = 'fixed'
            popup.style.left = event.clientX + 10 + 'px'
            popup.style.top = event.clientY + 20 + 'px'
        }
     }
    })()
    element.onmouseout = (function(){
        return function(event) {
            var target = event.target
            popup.style.display = 'none'
        }
    })()
}
</script>
]]

function autoindex_filter() 
	local html = ngx.arg[1]
	html = ngx.re.gsub(html, "(<head>)", "$0 <link type=\"text/css\" rel='stylesheet' href='/static/css/bootstrap.min.css'/>") 
	html = ngx.re.gsub(html,"<title>(.+)</title>", "<title>Zdnst App Download</title>")
	html = ngx.re.gsub(html,"<h1>(.+)</h1>", "<h1>Zdnst App Download</h1>")


	if(ngx.var.uri == '/') then
		--hide root dir
		html = ngx.re.gsub(html,"<a href=\"../\">../</a>", "")
	else
		-- dd qrcode support
		html = html .. popup_img_scrpit
		html = ngx.re.gsub(html,"<hr>(.*)</body>","<hr><img class=\"popup-img\" style=\"display: none;\"/></body>")
	end

	--hide static dir
	html = ngx.re.gsub(html,"<a href=\"static(.*)", "")
	ngx.arg[1] = html
end

if(ngx.re.match(ngx.header["Content-Type"],"text/html.+")) then
	autoindex_filter()
end
