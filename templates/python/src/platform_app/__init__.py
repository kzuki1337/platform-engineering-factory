"""Application package for the platform Python starter."""

from http.server import BaseHTTPRequestHandler


def create_handler() -> type[BaseHTTPRequestHandler]:
    class Handler(BaseHTTPRequestHandler):
        def do_GET(self) -> None:
            if self.path == "/healthz":
                body = b"ok\n"
                content_type = "text/plain"
            else:
                body = b'{"message":"Hello from the platform starter"}\n'
                content_type = "application/json"

            self.send_response(200)
            self.send_header("Content-Type", content_type)
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)

        def log_message(self, format: str, *args: object) -> None:
            return

    return Handler
