from rest_framework import serializers
from django.contrib.auth import authenticate
from .models import User, Video, Image


class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    confirm_password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'phone_number', 'password', 'confirm_password']
        extra_kwargs = {'password': {'write_only': True}}

    def validate(self, attrs):
        if attrs['password'] != attrs['confirm_password']:
            raise serializers.ValidationError("Password and confirm password do not match.")
        return attrs

    def create(self, validated_data):
        validated_data.pop('confirm_password')
        user = User.objects.create_user(**validated_data)
        return user

class UserLoginSerializer(serializers.Serializer):
    phone_number = serializers.CharField()
    password = serializers.CharField()

    def validate(self, attrs):
        phone_number = attrs.get('phone_number')
        password = attrs.get('password')

        if phone_number and password:
            user = authenticate(request=self.context.get('request'),
                                username=phone_number,
                                password=password)
            if not user:
                raise serializers.ValidationError("Invalid phone number or password.")
        else:
            raise serializers.ValidationError("Phone number and password are required.")

        attrs['user'] = user
        return attrs


class VideoSerializer(serializers.ModelSerializer):
    file = serializers.FileField(required=True)

    class Meta:
        model = Video
        fields = ['id', 'file', 'title', 'description', 'uploaded_by', 'date_uploaded']

class ImageSerializer(serializers.ModelSerializer):
    files = serializers.FileField(required=True)

    class Meta:
        model = Image
        fields = ['id', 'files', 'title', 'description', 'uploaded_by', 'date_uploaded']