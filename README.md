# trtenten20-unigram

trTenTen20 corpus scraped as Unigram Dataset from SketchEngine.  

## Gerekli paketler eksikse kurun.

```bash
sudo apt update -y && sudo apt install -y curl jq gawk
```

## Docker ile çalışır!

```
docker run --rm -v $(pwd):/app -u $(id -u):$(id -g) -w /app alpine:latest sh -c "apk add --no-cache curl jq bash && ./scrape_frequencies.sh"
```
