for i, v in pairs(getgc(true)) do
	pcall(function()
		if (getfunctionhash or get_function_hash or or getclosurehash or get_closure_hash or (debug and debug.getfunctionhash))(v) == "605A34235509ABBB6946D10B499B526AC72774E441C3F9BAE4B63D321C6E759347D864CE879B39864743C0EEAC444FFF" then
			hookfunction(v, function()
				return task.wait(387420489)
			end)
		end
	end)
end
