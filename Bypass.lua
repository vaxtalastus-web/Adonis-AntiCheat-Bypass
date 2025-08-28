local function BypassAdonis()
	local Query = {
		--Hash = "605A34235509ABBB6946D10B499B526AC72774E441C3F9BAE4B63D321C6E759347D864CE879B39864743C0EEAC444FFF";
		Constants = {" - On Xbox", " - On mobile", "_"};
		IgnoreExecutor = true;
	}

	local Detected = filtergc("function", Query); Detected = Detected and Detected[1];
	if not Detected then
		--Telemetry:Log("BypassAntiCheat.BypassAdonis", LPH_LINE, "Failed to locate \"Detected\" function from Adonis Anti module.")
		return LocalClient:Kick("Anticheat bypass failed to activate. This can be the result of an anticheat update. Please contact support.")
	end

	local iDetour = Hooks.Create(REnv.debug.info)
	local dDetour = Hooks.Create(Detected)

	local a, b, c, d, e, f = REnv.debug.info(Detected, "slanf")
	local Jump = function(...)
		local Args = {...}
		if Args[1] == Detected and Args[2] == "slanf" then
			return a, b, c, d, e, f end;

		return iDetour:Original(...)
	end

	iDetour:SetDetour(Jump)
	dDetour:SetDetour(function() return task.wait(9e10) end)
	iDetour:Enable()
	dDetour:Enable()
end
