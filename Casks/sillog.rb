cask "sillog" do
  version "0.1.135,135"
  sha256 "935e60fc60bfa74c4899053a901d03c02b37133e92e89d641fc5794ca648ace6"

  url "https://github.com/sillog-admin/SILLOG/releases/download/v#{version.csv.first}-build.#{version.csv.second}/SILLOG.dmg"
  name "SILLOG"
  desc "Activity recorder that turns your day into a work graph"
  homepage "https://sillog.app/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)-build\.(\d+)$/i)
    strategy :git do |tags, regex|
      tags.map do |tag|
        match = tag.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on macos: :sonoma

  app "SILLOG.app"

  uninstall quit: "com.sillog.app"

  zap trash: [
    "~/Library/Application Support/Sillog",
    "~/Library/Caches/com.sillog.app",
    "~/Library/HTTPStorages/com.sillog.app",
    "~/Library/HTTPStorages/com.sillog.app.binarycookies",
    "~/Library/Preferences/com.sillog.app.plist",
    "~/Library/WebKit/com.sillog.app",
  ]
end
