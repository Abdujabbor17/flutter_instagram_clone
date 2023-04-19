

abstract class ProfileState{}

class ProfileInit extends ProfileState{}

class ProfileLoad extends ProfileState{}

class ProfileError extends ProfileState{
  String msg;
  ProfileError(this.msg);
}

class ProfileSuccess extends ProfileState{

}