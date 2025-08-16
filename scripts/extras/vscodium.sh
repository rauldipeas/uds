#!/bin/bash
set -e
curl -sL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/vscodium-archive-keyring.gpg
printf 'deb [arch=amd64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list >/dev/null
sudo apt update
sudo apt install -y --reinstall codium npm ruby-dev ruby-rubygems shfmt
npm config set prefix "$HOME"/.npm-global
npm install -g pnpm
gem install --user-install bundler jekyll
mkdir -p "$HOME"/.config/VSCodium/User
if [ "$USER" == rauldipeas ]; then
	if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
		cd /tmp
		rm -fr /tmp/yaru-vscode
		git clone -q https://github.com/AdsonCicilioti/yaru-vscode
		cd yaru-vscode
		npm install
		npx vsce package
		codium --install-extension yaru-vscode-*.vsix --force
	elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
		codium --install-extension piousdeer.adwaita-theme --force
	fi
	codium --install-extension EditorConfig.EditorConfig --force
	codium --install-extension formulahendry.code-runner --force
	codium --install-extension mkhl.shfmt --force
	codium --install-extension mkhl.shfmt --force
	codium --install-extension ms-ceintl.vscode-language-pack-pt-br --force
	codium --install-extension ms-vscode.live-server --force
	codium --install-extension pkief.material-icon-theme --force
	codium --install-extension redhat.vscode-yaml --force
	codium --install-extension sissel.shopify-liquid --force
	codium --install-extension timonwong.shellcheck --force
	codium --install-extension yzhang.markdown-all-in-one --force
	codium --install-extension zardoy.npm-rapid-ready --force
	if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
		tee "$HOME"/.config/VSCodium/User/settings.json >/dev/null <<EOF
{
	"editor.fontFamily": "'Ubuntu Mono', 'monospace', monospace",
	"editor.occurrencesHighlight": "off",
	"editor.renderLineHighlight": "none",
	"git.confirmSync": false,
	"git.enableSmartCommit": true,
    "glassit.alpha": 220,
  	"telemetry.enableTelemetry": false,
  	"telemetry.enableCrashReporter": false,
  	"telemetry.feedback.enabled": false,
	"terminal.integrated.fontFamily": "Ubuntu Mono, Ubuntu Nerd Font",
  	"update.enableWindowsBackgroundUpdates": false,
  	"update.mode": "manual",
	"window.menuBarVisibility": "toggle",
	"window.titleBarStyle": "native",
	"workbench.colorTheme": "Yaru Dark",
  	"workbench.enableExperiments": false,
    "workbench.iconTheme": "material-icon-theme",
	"workbench.settings.enableNaturalLanguageSearch": false,
}
EOF
	elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
		tee "$HOME"/.config/VSCodium/User/settings.json >/dev/null <<EOF
{
	"editor.occurrencesHighlight": "off",
	"editor.renderLineHighlight": "none",
	"git.confirmSync": false,
	"git.enableSmartCommit": true,
    "glassit.alpha": 220,
  	"telemetry.enableTelemetry": false,
  	"telemetry.enableCrashReporter": false,
  	"telemetry.feedback.enabled": false,
  	"update.enableWindowsBackgroundUpdates": false,
  	"update.mode": "manual",
	"window.menuBarVisibility": "toggle",
	"window.titleBarStyle": "native",
	"workbench.colorTheme": "Adwaita Dark",
  	"workbench.enableExperiments": false,
    "workbench.iconTheme": "material-icon-theme",
	"workbench.settings.enableNaturalLanguageSearch": false,
}
EOF
	fi
else
	if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
		tee "$HOME"/.config/VSCodium/User/settings.json >/dev/null <<EOF
{
	"editor.fontFamily": "'Ubuntu Mono', 'monospace', monospace",
  	"telemetry.enableTelemetry": false,
  	"telemetry.enableCrashReporter": false,
  	"telemetry.feedback.enabled": false,
	"terminal.integrated.fontFamily": "Ubuntu Mono, Ubuntu Nerd Font",
  	"update.enableWindowsBackgroundUpdates": false,
  	"update.mode": "manual",
	"window.menuBarVisibility": "toggle",
	"window.titleBarStyle": "native",
  	"workbench.enableExperiments": false,
	"workbench.settings.enableNaturalLanguageSearch": false,
}
EOF
	elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
		tee "$HOME"/.config/VSCodium/User/settings.json >/dev/null <<EOF
{
  	"telemetry.enableTelemetry": false,
  	"telemetry.enableCrashReporter": false,
  	"telemetry.feedback.enabled": false,
  	"update.enableWindowsBackgroundUpdates": false,
  	"update.mode": "manual",
	"window.menuBarVisibility": "toggle",
	"window.titleBarStyle": "native",
  	"workbench.enableExperiments": false,
	"workbench.settings.enableNaturalLanguageSearch": false,
}
EOF
	fi
fi