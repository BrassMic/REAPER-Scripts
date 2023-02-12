--Activate random FX by BrassMic
--V 1.0

-- Get number of selected paths
local num_selected_tracks = reaper.CountSelectedTracks(0)

-- Check if any tracks are marked
if num_selected_tracks == 0 then
  reaper.ShowMessageBox("No track selected!", 0)
  reaper.defer(function() end)
  return
end

-- Iterate through all selected paths
for i = 0, num_selected_tracks - 1 do
  local track = reaper.GetSelectedTrack(0, i)

  -- Fetch the number of FX per track
  local num_fx = reaper.TrackFX_GetCount(track)

  -- Check if there are any plugins in the track
  if num_fx == 0 then
    reaper.ShowMessageBox("There are no FX in the track.", 0)
    reaper.defer(function() end)
    return
  end

  -- Deactivate all plugins
  for i = 0, num_fx - 1 do
    reaper.TrackFX_SetEnabled(track, i, false)
  end

  -- Random plugin number
  local fx_idx = math.random(num_fx) - 1

  -- Activate the selected effect plugin
  reaper.TrackFX_SetEnabled(track, fx_idx, true)
end

-- All done!
reaper.defer(function() end)
