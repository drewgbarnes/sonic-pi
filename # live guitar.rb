# live guitar

##| :ixi_techno
##| :krush
##| :octaver, super_amp:0
##| :panslicer
##| :ping_pong
##| :ring_mod, freq:100
##| :slicer, wave: 3

##| :tanh
##| :tremolo
##| :vowel
##| :whammy,transpose:12
##| :wobble,phase: 0.5,wave: 2,
##| :wobble,phase: 0.5,wave: 3,
##| :wobble,phase: 0.5,wave: 0,
with_fx :distortion, mix: 1 do
  with_fx :wobble, phase: 0.5, wave: 2, invert_wave:0, mix: 0 do
    with_fx :reverb, mix: 1 do
      live_audio :foo, input:1
    end
  end
end
