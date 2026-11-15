cask "sillog" do
  version "0.1.0,70"
  sha256 "b8c1a1e978844807222d6d9bd25b5a0f2f9340f41e800c3b37cb1318b59728a1"

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
