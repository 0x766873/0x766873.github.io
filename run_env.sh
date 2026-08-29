docker run --rm -it \
  -p 8080:8080 \
  -v "$PWD:/quartz" \
  -v "$HOME/Data/Blog:$HOME/Data/Blog" \
  -w /quartz \
  node:22-slim bash
