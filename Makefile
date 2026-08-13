install:
	bundle install

start:
	bundle exec ruby app.rb

# Проверка запуском: `ruby -c` ловит только синтаксис, а подъём версий sinatra и
# rack ломается не в синтаксисе, а на старте приложения.
check:
	@bundle exec ruby app.rb & \
	server=$$!; \
	trap "kill $$server 2>/dev/null" EXIT; \
	for i in $$(seq 1 30); do \
	  curl -sf http://localhost:4567/ >/dev/null && break; \
	  sleep 1; \
	done; \
	curl -sf http://localhost:4567/hello/hexlet | grep -qx 'Hello, hexlet!'

.PHONY: install start check
