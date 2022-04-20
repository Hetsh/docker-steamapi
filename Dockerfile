FROM hetsh/steamcmd:20220418-1

# App user
ARG APP_USER="steam"
ARG APP_UID=1379
RUN useradd --uid "$APP_UID" --user-group --create-home --shell /sbin/nologin "$APP_USER"

# Steam Client
RUN steamcmd.sh +quit && \
    chown -R "$APP_USER":"$APP_USER" "$STEAM_DIR"

USER "$APP_USER"
