

use_bpm 60
drum_tempo = 0.125
##| loop_drone_g_97
##| guit_harmonics
##| vinyl_hiss
switch = false
##| live_loop :bass, sync: :met, delay: 64 do
##|   switch = false
##| end

##| drum_notes = 0.125
define :drums do |pattern, samp, *args|
  if pattern.ring.tick != "-" then
    sample samp, *args
  end
  sleep drum_tempo
end

live_loop :met do
  sleep 1
end

live_loop :vin do
  sample :vinyl_hiss, amp: 0.15
  sleep 0.125
end

live_loop :kick, sync: :met do
  with_fx(:distortion, distort: 0.5) do
    drums "l---l---l--l-ll-", :bd_ada , amp: 1 # bd_zum # bd_pure
  end
end

live_loop :hat, sync: :met do
  drums "-l--l---l--l--l-", :drum_cymbal_closed, attack: 0.05, amp: 0.9
  ##| sleep 1
end

live_loop :hat2, sync: :met do
  drums "l", :drum_cymbal_open, attack: 0.001, amp: 0.5, rate: 1.5, sustain: 0.001
  ##| sleep 1
end

live_loop :snare, sync: :met do
  with_fx(:ping_pong, phase: 0.075) do
    drums "--a-", :elec_tick, attack: 0.0075
  end
end
##| === === === === === === === === === === === === === === === === === === === === === === === === ===

define :mel do |mel_tempo, pattern, *args|
  t = pattern.ring.tick
  if t != "-" then
    play t, *args
  end
  sleep mel_tempo
end

live_loop :bass, sync: :met, delay: 8 do
  use_synth :fm
  use_synth_defaults attack: 0.01, release: 0.55
  
  with_fx(:panslicer, mix: 0.4) do
    if switch
      mel 0.125, [
        :Fs3, '-', :Fs3, '-', :Fs3, '-', :Fs3, '-', :Fs3, '-', :Fs3, '-', :Fs3, '-', :B3, :Cs4,
      ]
    else
      mel 0.125, [
        :Bb3, '-', :Bb3, '-', :Bb3, '-', :B3, :Cs3, :Bb3, '-', :Bb3, '-', :Bb3, '-', :B3, :Cs3,
        :Cs3, '-', :Cs3, '-', :Cs3, '-', :Eb3, :Fs3, :Cs3, '-', :Cs3, '-', :Cs3, '-', :Eb3, :Fs3,
      ]
    end
  end
end

live_loop :ambient, sync: :met, delay: 16 do
  use_synth :fm
  use_synth_defaults amp: 0.8
  with_fx(:reverb, mix: 0.5) do
    if switch
      mel 2, [:Fs2,:B2,:Cs3,:Cs3,], attack: 0.125, decay: 0.625, sustain: 0.5, release: 0.75
    else
      mel 2, [:Fs2,:B2,:Cs3,:Cs3,], attack: 0.125, decay: 0.625, sustain: 0.5, release: 0.75
    end
  end
end


define :organ do |chords|
  use_synth :organ_tonewheel
  use_synth_defaults amp: 1.0
  with_fx(:panslicer, mix: 0.5) do
    8.times do
      play chords[0], sustain: 0.05
      sleep 0.25
    end
    play chords[1],  attack: 0.25, sustain: 1.75
    sleep 2
    8.times do
      play chords[2],  sustain: 0.05
      sleep 0.25
    end
    play chords[3], attack: 0.25, sustain: 1.75
    sleep 2
  end
end


live_loop :chord, sync: :met do
  if switch
    organ [chord(:Fs4, :major7),chord(:B4, :major7),chord(:B4, :major), chord(:Cs5, :major)]
  else
    organ [chord(:Bb4, :minor),chord(:B, :major),chord(:Bb4, :minor), chord(:Cs5, :major)]
  end
end


