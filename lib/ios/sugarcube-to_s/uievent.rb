class UIEvent

  def to_s
    type = case self.type
            when UIEventTypeTouches
              'touch'
            when UIEventTypeMotion
              if self.subtype == UIEventSubtypeMotionShake
                'shake'
              else
                'motion'
              end
            when UIEventTypeRemoteControl
              case self.subtype
              when UIEventSubtypeRemoteControlPlay
                'remote-control, Play'
              when UIEventSubtypeRemoteControlPause
                'remote-control, Pause'
              when UIEventSubtypeRemoteControlStop
                'remote-control, Stop'
              when UIEventSubtypeRemoteControlTogglePlayPause
                'remote-control, TogglePlayPause'
              when UIEventSubtypeRemoteControlNextTrack
                'remote-control, NextTrack'
              when UIEventSubtypeRemoteControlPreviousTrack
                'remote-control, PreviousTrack'
              when UIEventSubtypeRemoteControlBeginSeekingBackward
                'remote-control, BeginSeekingBackward'
              when UIEventSubtypeRemoteControlEndSeekingBackward
                'remote-control, EndSeekingBackward'
              when UIEventSubtypeRemoteControlBeginSeekingForward
                'remote-control, BeginSeekingForward'
              when UIEventSubtypeRemoteControlEndSeekingForward
                'remote-control, EndSeekingForward'
              end
            end
    "#{self.class.to_s}(#{type}, touches: #{allTouches.inspect})"
  end

end