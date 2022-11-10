
drum_tempo = 0.25
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

live_loop :kick, sync: :met do
  with_fx(:distortion, distort: 0.5) do
    drums "l---", :drum_heavy_kick
  end
end

live_loop :hat, sync: :met do
  drums "-k", :drum_cymbal_closed, attack: 0.02, amp: 0.9
end

live_loop :snare, sync: :met do
  with_fx(:ping_pong, phase: 0.075) do
    drums "--l-", :elec_tick
  end
end

##| sample :elec_tick

use_random_seed 20
song_key = 0
a = choose(scale(:B1 + song_key, :major_pentatonic, num_octaves: 1))
b = choose(scale(:B1 + song_key, :major_pentatonic, num_octaves: 1))
c = choose(scale(:B1 + song_key, :major_pentatonic, num_octaves: 1))

mel_pitch_changes = [0, 2, -2, 2]
mel_loops = 8
##| mel_tempo = 0.125
mel_tempo = 0.5
bass_pitch_changes = [0, 5, 7, 17]
bass_loops = mel_loops / 4
##| bass_tempo = 0.25
bass_tempo = 0.125

live_loop :bass, sync: :met do
  
  pitch_change = bass_pitch_changes.ring.tick
  bass_loops.times do
    use_synth :bass_foundation
    use_synth_defaults cutoff: 75
    2.times do
      play b + pitch_change + song_key
      sleep bass_tempo
    end
    play c + pitch_change + song_key
    sleep bass_tempo
    play a + pitch_change + song_key
    sleep bass_tempo
  end
end


live_loop :mel, sync: :met do
  pitch_change = mel_pitch_changes.ring.tick
  mel_loops.times do
    use_synth :zawa
    use_synth_defaults cutoff: 66, amp: 0.9, sustain: 0.9, decay: 0.5
    
    s = play :Gs5 + pitch_change + song_key
    sleep mel_tempo
    
    play :Cs5 + pitch_change + song_key
    sleep mel_tempo
  end
end


live_loop :mel2, sync: :met do
  with_fx(:echo, phase: 0.75, decay: 0.2) do
    use_synth :blade
    use_synth_defaults cutoff: 77, amp: 0.7
    play choose(chord(:B3, :maj, num_octaves: 2)) + song_key, release: 0.3, sustain: 0.5
    sleep 0.5
  end
end

