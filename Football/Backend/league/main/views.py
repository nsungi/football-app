
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
from rest_framework.parsers import MultiPartParser, FormParser
#from django.contrib.auth import authenticate
from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from .forms import VideoForm, ImageForm
from .models import User, Video, Image
from .serializers import UserRegistrationSerializer, UserLoginSerializer, ImageSerializer, VideoSerializer
from django.contrib.auth import get_user_model
import re
from django.db.models import Q



class UserRegisterView(generics.CreateAPIView):
    permission_classes = (AllowAny,)
    serializer_class = UserRegistrationSerializer  # Use UserRegistrationSerializer here

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Check if the phone number is valid
        phone_number = serializer.validated_data.get('phone_number')
        if not phone_number or not self.is_valid_phone_number(phone_number):
            return Response({'error': 'Invalid phone number format'}, status=status.HTTP_400_BAD_REQUEST)

        # Check if a user with the provided phone number already exists
        if User.objects.filter(phone_number=phone_number).exists():
            return Response({'error': 'Phone number is already registered'}, status=status.HTTP_400_BAD_REQUEST)

        # Check if the password and confirm password match
        password = serializer.validated_data.get('password')
        confirm_password = serializer.validated_data.get('confirm_password')
        if password != confirm_password:
            return Response({'error': 'Passwords do not match'}, status=status.HTTP_400_BAD_REQUEST)

        # Save the user with a hashed password
        user = serializer.save(password=make_password(password))
        return Response({'message': 'User registered successfully'}, status=status.HTTP_201_CREATED)

    def is_valid_phone_number(self, phone_number):
    # Regular expression for a valid phone number format (e.g., 0765442767)
        phone_number_pattern = r'^\d{10}$'
        return re.match(phone_number_pattern, phone_number) is not None


class UserLoginView(generics.GenericAPIView):
    permission_classes = (AllowAny,)
    serializer_class = UserLoginSerializer  # Use UserLoginSerializer here

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']

        return Response({'message': 'Login successful'}, status=status.HTTP_200_OK)



class VideoUploadView(APIView):
    parser_classes = [MultiPartParser, FormParser]

    def post(self, request, *args, **kwargs):
        video_form = VideoForm(request.data)
        if video_form.is_valid():
            video_instance = video_form.save(uploaded_by=request.user)
            video_serializer = VideoSerializer(video_instance)
            return Response(video_serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(video_form.errors, status=status.HTTP_400_BAD_REQUEST)

class ImageUploadView(APIView):
    parser_classes = [MultiPartParser, FormParser]

    def post(self, request, *args, **kwargs):
        image_form = ImageForm(request.data)
        if image_form.is_valid():
            image_instances = []
            for file in request.FILES.getlist('files'):
                image_instance = Image(
                    file=file,
                    title=image_form.cleaned_data['title'],
                    description=image_form.cleaned_data.get('description', ''),
                    uploaded_by=request.user
                )
                image_instance.save()
                image_instances.append(image_instance)
            image_serializer = ImageSerializer(image_instances, many=True)
            return Response(image_serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(image_form.errors, status=status.HTTP_400_BAD_REQUEST)