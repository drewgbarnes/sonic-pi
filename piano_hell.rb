

use_bpm 120
drum_tempo = 0.5
##| loop_drone_g_97
##| guit_harmonics
##| vinyl_hiss
switch = true
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
  sleep 0.9
end

live_loop :kick, sync: :met do
  with_fx(:distortion, distort: 0.25) do
    drums "l---", :bd_808, amp: 6 # bd_zum # bd_pure
  end
end

live_loop :hat, sync: :met do
  drums "-l", :drum_cymbal_pedal, attack: 0.05, amp: 0.9
  ##| sleep 1
end


live_loop :snare, sync: :met do
  drums "--a-", :elec_hi_snare, attack: 0.01, sustain: 0.025, decay: 0.1
end

live_loop :snap, sync: :met do
  ##| drums "1", :perc_snap, amp: 0.2
  sleep 1
end

##| === === === === === === === === === === === === === === === === === === === === === === === === ===


relax = true
live_loop :piano, sync: :met do
  
  use_synth :piano
  stop
  with_fx :echo, mix: 0.2 do
    with_fx :gverb, mix: 0.2 do
      if relax
        3.times do
          play chord(:A3, :minor7), release: 0.2
          sleep 0.5
          play chord(:G4, :minor7)
          sleep 1
        end
        play chord(:A3, :minor7), release: 0.2
        sleep 0.5
        play chord(:A3, :minor7), release: 0.2
        sleep 0.5
        play chord(:G4, :minor7)
        sleep 1
      else
        3.times do
          play chord(:C, :m11), release: 0.2
          sleep 0.5
          play chord(:D, :m11)
          sleep 1
          play chord(:C, :m11), release: 0.2
          sleep 0.5
          play chord(:E, :m11)
          sleep 1
        end
        play chord(:C, :m11), release: 0.2
        sleep 0.5
        play chord(:C, :m11), release: 0.2
        sleep 0.5
        play chord(:D, :m11)
        sleep 1
        play chord(:E, :m11)
        sleep 1
      end
    end
  end
end

live_loop :piano_m, sync: :met do
  
  use_synth :piano
  use_synth_defaults amp: 0.1
  with_fx :gverb, mix: 0.9 do
    if relax
      play choose(chord(:A5, :min))
    else
      play choose(scale(:A5, :minor_pentatonic, num_octaves: 1)), cutoff: 60
    end
    sleep 0.5
  end
end

live_loop :bass, sync: :met do
  use_sample_defaults amp: 0.5
  ##| sample :bass_thick_c
  sleep 4
end

live_loop :bass2, sync: :met do
  use_sample_defaults sustain: 0.5
  if relax
    ##| G
    sample :bass_trance_c, rpitch: -7, amp: 1.0
  else
    ##| E
    sample :bass_trance_c, rpitch: -4, amp: 0.8
  end
  sleep 0.25
end

live_loop :bass3, sync: :met do
  use_sample_defaults amp: 4
  ##| sample :bd_pure, pitch: :D4
  sleep 1.0
end


