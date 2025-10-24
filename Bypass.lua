pcall(function()
	game:GetService("ScriptContext"):SetTimeout(1)
end)
for i, v in pairs(getgc(true)) do
	pcall(function()
		if rawget(v, "Detected") then
			hookfunction(rawget(v, "Detected"), function()
				return task.wait(387420489)
			end)
		end
	end)
end
