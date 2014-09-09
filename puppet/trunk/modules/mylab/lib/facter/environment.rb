# Add puppet facter environment

Facter.add("environment") do
	setcode do
		result = case Facter.hostname
		when /^dev/: "development"
		else         "production"
		end
		result
	end
end
