# chatgpt api keys:
  https://platform.openai.com/api-keys

# videos:
  - [vid 1 - https://www.youtube.com/watch?v=c77so_bKXhQ](https://www.youtube.com/watch?v=c77so_bKXhQ)
  - [vid 2 - https://www.youtube.com/watch?v=hNE2WPtn54A](https://www.youtube.com/watch?v=hNE2WPtn54A)
  - 

# facebook:
  - [https://developers.facebook.com/](https://developers.facebook.com/)
  - https://business.facebook.com/
```commandline
curl -i -X POST https://graph.facebook.com/v20.0/4076378991030422/messages \
-H 'Authorization: Bearer EAAFZCoM5eKPwBO67DpxPSe1ZA4t6cujaepCWSAJOWq3ApYRLp5YXjGI8LiMtuJ0ZCGdT1QfC4QoehRQqRRVRZA1fSegXcQLAhZCCYxRKD25IRJ6ZAoZCqLI0J18g3TFvGZCgZBiE0Iyuw2o05bRrVi6FLOzRqdTvBuIb0E8lS22IiqvV1WAxZCyQpbIwEEFkUDtWgb7ZBbwJsaAYXC8NjC810GeZBcgONxNapk6yOQgZD2' \
-H 'Content-Type: application/json' \
-d '{
  "messaging_product": "whatsapp",
  "to": "PHONE_NUMBER",
  "type": "template",
  "template": {
    "name": "hello_world",
    "language": {
      "code": "en_US"
    }
  }
}'
```