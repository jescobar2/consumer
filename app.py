from flask import Flask
import os
import pika

app = Flask(__name__)

@app.route('/')
def hello():
    host = os.uname()[1]

    received_messages = []
    # Configuración de conexión a RabbitMQ
    connection = pika.BlockingConnection(pika.ConnectionParameters('rabbitmq-service'))
    channel = connection.channel()
    channel.queue_declare(queue='my_cola')

    def callback(ch, method, properties, body):
        print(f"Mensaje recibido: {body}")
        received_messages.append(body)

    channel.basic_consume(queue='my_queue', on_message_callback=callback, auto_ack=True)

    print('Consumer 1 esperando mensajes. Para salir, presiona CTRL+C')
    channel.start_consuming()

    return f"Hello, fucking world!\nVersion: 1.0.0\nHostname: {host} and {os.environ['RABBITMQ_HOST']}and {received_messages} \n"

if __name__ == '__main__':
    port = os.environ.get('PORT', '8081')
    app.run(host='0.0.0.0', port=int(port))

