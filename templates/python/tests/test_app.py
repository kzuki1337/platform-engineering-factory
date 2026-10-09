from http.server import ThreadingHTTPServer
from threading import Thread
from urllib.request import urlopen

from platform_app import create_handler


def test_health_endpoint() -> None:
    server = ThreadingHTTPServer(("127.0.0.1", 0), create_handler())
    thread = Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        with urlopen(f"http://127.0.0.1:{server.server_port}/healthz") as response:
            assert response.status == 200
            assert response.headers["Content-Type"] == "text/plain"
            assert response.read() == b"ok\n"
    finally:
        server.shutdown()
        thread.join()
        server.server_close()


def test_application_endpoint() -> None:
    server = ThreadingHTTPServer(("127.0.0.1", 0), create_handler())
    thread = Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        with urlopen(f"http://127.0.0.1:{server.server_port}/") as response:
            assert response.status == 200
            assert response.headers["Content-Type"] == "application/json"
            assert response.read() == b'{"message":"Hello from the platform starter"}\n'
    finally:
        server.shutdown()
        thread.join()
        server.server_close()
