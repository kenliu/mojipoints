class SelfRecognitionCheck
  def self.self_recognition?(voterid, subject)
    match_data = /^<@(U\w+)>$/.match(subject)
    if match_data
      subject_userid = match_data[1]
      voterid == subject_userid
    else
      false
    end
  end
end