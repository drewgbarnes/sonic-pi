# TODO: make this sound like that bonobo song
use_bpm 60

live_loop :metronome do
  sleep 1
end
# ====================================================================================================================================================================================================================================================================
define :drums do |pattern, samp, drum_tempo, *args|
  if pattern.ring.tick != "-" then
    sample samp, *args
  end
  sleep drum_tempo
end

# live_loop :bass_drum, sync: :metronome do
#   drums 'b-b-', :drum_bass_hard, 0.25
# end

live_loop :kick, sync: :metronome do
  with_fx(:distortion, distort: 0.5) do
    drums "l---l---l--l-ll-", :bd_ada, 0.25, amp: 1 # bd_zum # bd_pure
  end
end


live_loop :high_hat, sync: :metronome do
  drums '-h-hh-h-', :drum_cymbal_closed, 0.25
end

live_loop :piano_chord, sync: :metronome do
  with_fx :flanger, mix: 1.0 do
    play chord(:A4, :major)
  end
  sleep 1
end

# ==================================================================================================================================

bass1 = [:Gs, :As, :B, '-', :B, :B, :As, :Gs, ]
bass2 = [:Gs, :As, :B, :B, :Cs, :As, :Gs, ]
bass3 = [:Gs, :As, :B, :B, :Cs, :Fs, :Gs, ]
