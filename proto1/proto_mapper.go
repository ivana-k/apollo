package proto1

import (
	"apollo/model"
	"errors"
)

func UserToModel(req *User) (*model.User, error) {
	if req.Email == "" || req.Username == "" || req.Password == "" {
		return &model.User{}, errors.New("required fields are missing")
	}

	if req.Org == req.Username {
		return &model.User{}, errors.New("username and organization name must be different")
	}

	org := req.Org
	if org == "" {
		org = req.Username + "_default"
	}

	return &model.User{
		Name:     req.Name,
		Surname:  req.Surname,
		Email:    req.Email,
		Password: req.Password,
		Org:      org,
		Username: req.Username,
	}, nil
}

func LoginToModel(req *LoginReq) (*model.LoginReq, error) {
	return &model.LoginReq{
		Username: req.Username,
		Password: req.Password,
	}, nil
}

func TokenToModel(req *Token) (*model.Token, error) {
	return &model.Token{
		Token: req.Token,
	}, nil
}

func JwtToModel(req *InternalToken) (*model.Token, error) {
	return &model.Token{
		Token: req.Jwt,
	}, nil
}
