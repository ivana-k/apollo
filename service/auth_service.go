package service

import (
	"apollo/client"
	"apollo/model"
	"apollo/repository"
	"apollo/vault"
	"context"
	"log"

	oort "github.com/c12s/oort/pkg/api"
)

type AuthService struct {
	repo repository.IUserRepo
	v    *vault.VaultClientService
}

// init
func NewAuthService(repo repository.IUserRepo, v *vault.VaultClientService) (*AuthService, error) {
	return &AuthService{
		repo: repo,
		v:    v,
	}, nil
}

func (h AuthService) RegisterUser(ctx context.Context, req model.UserDTO) model.RegisterResp {
	refClient := *h.v
	registerResp := h.repo.CreateUser(ctx, req)

	if registerResp.Error != nil {
		return registerResp
	}

	err := client.CreateOrgUserRelationship(registerResp.User.Org, registerResp.User.Username)
	if err != nil {
		log.Printf("Error while creating inheritance rel: %v", err)
		return model.RegisterResp{User: model.UserDTO{}, Error: err}
	}

	client.CreatePolicyAsync(registerResp.User.Org,
		registerResp.User.Username,
		registerResp.User.Permissions)

	refClient.RegisterUser(req.Username, req.Password, []string{"org.add"})

	return registerResp
}

func (h AuthService) LoginUser(req model.LoginReq) model.LoginResp {
	refClient := *h.v
	loginResp := refClient.LoginUser(req)
	if loginResp.Error != nil {
		return loginResp
	}
	return model.LoginResp{Token: loginResp.Token, Error: nil}
}

func (h AuthService) Autorize(req model.AuthorizationReq) model.AuthorizationResp {
	return model.AuthorizationResp{Authorized: true}
}

func (h AuthService) VerifyToken(req model.Token) (model.InternalToken, string) {
	refClient := *h.v
	response := refClient.VerifyToken(req.Token)

	if !response.Verified {
		return model.InternalToken{Verified: response.Verified, Jwt: ""}, ""
	}

	// proveriti da li ima nekih promena na oort-u
	permissions := client.GetGrantedPermissions(response.Username)

	// create jwt with permissions inside
	token, err := CreateToken(response.Username, transformPermissions(response.Username, permissions))
	if err != nil {
		return model.InternalToken{Verified: response.Verified, Jwt: ""}, ""
	}

	return model.InternalToken{Verified: response.Verified, Jwt: token}, response.Username
}

func (h AuthService) DecodeJwt(req model.Token) []string {
	return GetClaimsFromJwt(req)
}

func transformPermissions(username string, permissions []*oort.GrantedPermission) string {
	// format: perm|kind|org, perm2|kind|org, ...
	var transformed string

	if len(permissions) > 0 {
		for _, perm := range permissions {
			if perm.Object.Kind != "user" && perm.Object.Id != username {
				transformed = transformed + perm.Name + "|" + perm.Object.Kind + "|" + perm.Object.Id + ","
			}
		}
		return transformed[:len(transformed)-1]
	}

	return transformed
}
