class AudioPost < Post

  # Rendered for Audio posts.
  block 'Audio' do
    true
  end

  # Rendered if there is a caption for this post.
  block 'Caption'

  # The caption for this post.
  tag 'Caption'

  # Default audio player.
  tag 'AudioPlayer'

  # White audio player.
  tag 'WhiteAudioPlayer'

  # Grey audio player.
  tag 'GreyAudioPlayer'

  # Black audio player.
  tag 'BlackAudioPlayer'

  # URL for this post's audio file. iPhone Themes only.
  tag 'RawAudioURL'

  # The number of times this post has been played.
  tag 'PlayCount'

  # The number of times this post has been played, formatted with commas.
  # Returns '12,309' for example.
  tag 'FormattedPlayCount'

  # The number of times this post has been played, formatted with commas
  # and pluralized label. Returns "12,309 plays" for example.
  tag 'PlayCountWithLabel'

  # Rendered if this post uses an externally hosted MP3. (Useful for
  # adding a "Download" link)
  block 'ExternalAudio'

  # The external MP3 URL, if this post uses an externally hosted MP3.
  tag 'ExternalAudioURL'

  # Rendered if this audio file's ID3 info contains album art.
  block 'AlbumArt'

  # The album art URL, if this audio file's ID3 info contains album art.
  tag 'AlbumArtURL'

  # Rendered if this audio file's ID3 info contains the artist name.
  block 'Artist'

  # The track's artist's name e
  # xtracted from the file's ID3 info.
  tag 'Artist'

  # Rendered if this audio file's ID3 info contains the album title.
  block 'Album'

  # The name of the track's album extracted from the file's ID3 info.
  tag 'Album'

  # Rendered if this audio file's ID3 info contains the track name.
  block 'TrackName'

  # The track's name extracted from the file's ID3 info.
  tag 'TrackName'

end
