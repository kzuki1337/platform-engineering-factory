from http.server import ThreadingHTTPServer
import os

from platform_app import create_handler


def main() -> None:
    port = int(os.environ.get("PORT", "8080"))
    server = ThreadingHTTPServer(("0.0.0.0", port), create_handler())
    server.serve_forever()


if __name__ == "__main__":
    main()
