# typed: strict
# frozen_string_literal: true

# Homebrew cask for the Beebium macOS GUI app.
#
# This is the canonical copy, kept in the monorepo for development, review and
# CI (brew audit/style run against it). It is mirrored into the tap
# (rob-smallshire/homebrew-beebium, Casks/beebium-gui.rb) at release time by
# packaging/homebrew/sync-gui-cask.sh, which pins the two per-architecture DMG
# urls and their sha256s to a published release.
#
# The DMGs are Developer ID signed, notarized and stapled, so Gatekeeper accepts
# them on first launch. Unlike the beebium-server FORMULA (a source build of the
# headless servers), this CASK installs the prebuilt .app -- which embeds its own
# servers, ROMs, presets and extensions -- so the two do not overlap.
cask "beebium-gui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.12"
  # Placeholders (distinct per arch so `brew style` is satisfied); the real
  # per-architecture hashes are pinned by sync-gui-cask.sh at release time.
  sha256 arm:   "0c35d37683ab3decf4c5ef36c2fd20379c0bd2c04040bf0ac9c1e83490cf6cc2",
         intel: "313f5febc8efa661dfbfc3aa1deda67b95d2148ed5514101217064b10b704847"

  url "https://github.com/rob-smallshire/beebium/releases/download/v#{version}/Beebium-#{version}-macos-#{arch}.dmg",
      verified: "github.com/rob-smallshire/beebium/"
  name "Beebium"
  desc "BBC Micro emulator with a graphical interface"
  homepage "https://github.com/rob-smallshire/beebium"

  auto_updates false
  # The app's deployment target is macOS 13 (Ventura) on BOTH architectures --
  # higher than the beebium-server wheels' floors (Big Sur/Monterey), because the
  # SwiftUI/Metal front end needs it. The bare symbol means "Ventura or newer".
  depends_on macos: :ventura

  app "Beebium.app"

  # The app writes its user data under Application Support/Beebium (keyboard
  # mappings, user presets); the rest are the standard AppKit locations for the
  # com.beebium.Beebium bundle id.
  zap trash: [
    "~/Library/Application Support/Beebium",
    "~/Library/Caches/com.beebium.Beebium",
    "~/Library/HTTPStorages/com.beebium.Beebium",
    "~/Library/Preferences/com.beebium.Beebium.plist",
    "~/Library/Saved Application State/com.beebium.Beebium.savedState",
  ]
end
