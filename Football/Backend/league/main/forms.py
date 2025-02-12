from django import forms
from .models import User, Video, Image
from django.forms import ClearableFileInput


from .widgets import CustomFileInput

class UserRegistrationForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    confirm_password = forms.CharField(widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ['username', 'phone_number', 'password', 'confirm_password']

    def clean_confirm_password(self):
        password = self.cleaned_data.get('password')
        confirm_password = self.cleaned_data.get('confirm_password')

        if password and confirm_password and password != confirm_password:
            raise forms.ValidationError("Password and confirm password do not match.")

        return confirm_password

    def clean_phone_number(self):
        phone_number = self.cleaned_data.get('phone_number')
        # Perform any phone number validation here if needed

        return phone_number

    def clean_username(self):
        username = self.cleaned_data.get('username')
        # Perform any username validation here if needed

        return username
    
"""

class CustomFileInput(forms.FileInput):
    def render(self, name, value, attrs=None, renderer=None):
        final_attrs = self.build_attrs(attrs, type=self.input_type, name=name)
        return super().render(name, value, final_attrs, renderer)

class VideoForm(forms.ModelForm):
    class Meta:
        model = Video
        fields = ['file', 'title', 'description']
        widgets = {
            'file': CustomFileInput(),
        }

class ImageForm(forms.ModelForm):
    class Meta:
        model = Image
        fields = ['files', 'title', 'description']
        widgets = {
            'files': CustomFileInput(),
        }
        
        

"""    





class VideoForm(forms.ModelForm):
    class Meta:
        model = Video
        fields = ['file', 'title', 'description']
        widgets = {
            'file': CustomFileInput(),
        }

class ImageForm(forms.ModelForm):
    class Meta:
        model = Image
        fields = ['files', 'title', 'description']
        widgets = {
            'files': CustomFileInput(),
        }