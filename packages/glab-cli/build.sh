TERMUX_PKG_HOMEPAGE=https://gitlab.com/gitlab-org/cli
TERMUX_PKG_DESCRIPTION="A GitLab CLI tool bringing GitLab to your command line"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.61.0"
TERMUX_PKG_SRCURL=https://gitlab.com/gitlab-org/cli/-/archive/v${TERMUX_PKG_VERSION}/cli-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=4d88343fe8d5c7feb3f21c361c2affd6690e31cc615a71d20f94eba727abd8bb
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_EXTRA_MAKE_ARGS="GLAB_VERSION=${TERMUX_PKG_VERSION}"

termux_step_pre_configure() {
	termux_setup_golang
}

termux_step_make_install() {
	install -Dm700 -t "${TERMUX_PREFIX}"/bin bin/glab

	install -Dm644 /dev/null "$TERMUX_PREFIX"/share/bash-completion/completions/glab.bash
	install -Dm644 /dev/null "$TERMUX_PREFIX"/share/zsh/site-functions/_glab
	install -Dm644 /dev/null "$TERMUX_PREFIX"/share/fish/vendor_completions.d/glab.fish
}

termux_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${TERMUX_PREFIX}/bin/sh
		glab completion -s bash > ${TERMUX_PREFIX}/share/bash-completion/completions/glab.bash
		glab completion -s zsh > ${TERMUX_PREFIX}/share/zsh/site-functions/_glab
		glab completion -s fish > ${TERMUX_PREFIX}/share/fish/vendor_completions.d/glab.fish
	EOF
}
