from rest_framework import mixins, viewsets
from custom_user.permissions import IsFirebaseAuthenticated
from .models import Group
from .serializers import *
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.pagination import PageNumberPagination
# Create your views here.


class GroupViewSet(viewsets.ModelViewSet):
    queryset = Group.objects.all()
    serializer_class = GroupSerializer
    permission_classes = [IsFirebaseAuthenticated]

    @action(detail=True, methods=["get"])
    def list_posts(self, request, pk=None):
        group = Group.objects.get(id=pk)
        post_queryset = Post.objects.filter(group=group)
        post_serializer = PostSerializer(post_queryset, many=True)

        return Response(post_serializer.data)

    @action(detail=False, methods=["get"])
    def list_user_groups(self, request):
        user = request.user
        queryset = Group.objects.filter(creator=user)
        group_serializer = GroupSerializer(queryset, many=True)

        return Response(group_serializer.data)

    def perform_create(self, serializer):
        serializer.save(creator=self.request.user)


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    permission_classes = [IsFirebaseAuthenticated]

    def perform_create(self, serializer):
        serializer.save(creator=self.request.user)

    @action(detail=False, methods=["get"])
    def list_user_posts(self, request):
        user = request.user
        queryset = Post.objects.filter(creator=user)
        post_serializer = PostSerializer(queryset, many=True)

        return Response(post_serializer.data)

    @action(detail=True, methods=["get"])
    def add_remove_like(self, request, pk=None):
        user = request.user
        post = self.get_object()

        if(post.likes.filter(id=user.id)):
            post.likes.remove(user)
        else:
            post.likes.add(user)

        serializer = PostSerializer(post)
        return Response(serializer.data)


class PaginationMeta(PageNumberPagination):
    page_size = 50
    page_size_query_param = 'page_size'
    max_page_size = 10000


class PaginatedPostViewSet(viewsets.GenericViewSet, mixins.ListModelMixin):
    permission_classes = [IsFirebaseAuthenticated]
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    pagination_class = PaginationMeta


class UserPaginatedPostViewSet(viewsets.GenericViewSet, mixins.ListModelMixin):
    permission_classes = [IsFirebaseAuthenticated]
    serializer_class = PostSerializer
    pagination_class = PaginationMeta

    def get_queryset(self):
        user = self.request.user
        print(type(Post.objects.filter(creator=user)))
        return Post.objects.filter(creator=user)


class PersonalisedPostViewSet(viewsets.GenericViewSet, mixins.ListModelMixin):
    permission_classes = [IsFirebaseAuthenticated]
    serializer_class = PostSerializer
    pagination_class = PaginationMeta

    def get_queryset(self):
        user = self.request.user

        groups = user.group_followers.all()
        posts = Post.objects.filter(group__in=groups)
        return posts
