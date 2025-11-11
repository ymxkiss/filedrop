# filedrop

Available at: https://drop.lol/

Easy end-to-end encrypted, peer-to-peer file transfer.

```
docker run -d --restart=always --name=filedrop -p 18880:5000 ghcr.io/ymxkiss/filedrop:latest
```
**Features:**

- Fully end-to-end encrypted, including metadata and chat.
- Peer-to-peer wherever possible (using WebRTC).
- Simple chat function with copy and paste.
- Minimalist user interface.
- Available as a Progressive Web Application.

<p align="center">
    <a href="https://drop.lol/">
        <img src="https://raw.githubusercontent.com/mat-sz/filedrop/master/docs/filedrop.gif" alt="Screenshot">
    </a>
</p>

## Docs

- [Usage/self-hosting](./docs/usage.md)
- [FAQ](./docs/faq.md)
- [HTTPS setup](./docs/https/index.md)
