function GM:ResourceAddDir(dir)
	local list = file.Find("*","../"..dir.."/*")
	for _,fdir in pairs(list) do
		if fdir != ".svn" then
			self:ResourceAddDir(dir.."/"..fdir)
		end
	end
	
	for k,v in pairs(file.Find("*", dir)) do
		resource.AddFile(dir.."/"..v)
	end
end

function GM:ResourceAddFiles()
	local directories = {
		"sound/jailrp/footsteps"
	}
	
	for _,v in pairs(directories) do
		self:ResourceAddDir(v)
	end
end