local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local text = require(script.Parent.Parent.components.text)

return function(target)

	return vide.mount(function()
		return text {
			Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis placerat enim vel egestas blandit. Nunc condimentum nulla vitae tortor tristique pretium. Nulla vel tristique justo. Morbi imperdiet faucibus dignissim. In ultricies hendrerit sapien, eget elementum turpis maximus ac. Mauris id leo condimentum, consectetur tortor at, sollicitudin tortor. Donec a ipsum aliquet odio iaculis efficitur eu a nibh. Nam scelerisque tincidunt lobortis. Vivamus tincidunt elementum convallis. Fusce hendrerit ullamcorper erat, non semper nisi iaculis eu. Pellentesque sodales lacus nulla, sit amet faucibus nunc iaculis feugiat. Mauris tempus tortor quis sem dignissim tristique. Curabitur vehicula sagittis ante, tristique hendrerit eros. "
		}
	end, target)

end