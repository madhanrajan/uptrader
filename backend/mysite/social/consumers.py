# chat/consumers.py
import json
from channels.generic.websocket import AsyncWebsocketConsumer
from .serializers import PostSerializer
from rest_framework import serializers


class PostConsumer(AsyncWebsocketConsumer):

    async def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = 'chat_%s' % self.room_name

        # Token value

        # Join room group
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    # Receive message from WebSocket
    async def receive(self, text_data):

        text_data_json = json.loads(text_data)

        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'chat_message',
                'data': text_data_json
            }
        )

    # Receive message from room group
    async def chat_message(self, event):
        message = event['data']

        # Send message to WebSocket
        await self.send(text_data=json.dumps(message))
