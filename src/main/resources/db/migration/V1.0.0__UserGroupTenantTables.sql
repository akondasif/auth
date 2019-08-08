create table roles (
    id varchar(255) not null,
    name varchar(200),
    primary key (id)
);


create table tenants (
    id varchar(255) not null,
    name varchar(200),
    primary key (id)
);


create table user_x_role (
    user_id bigint not null,
    role_id varchar(255) not null
);


create table user_x_tenant (
    user_id bigint not null,
    tenant_id varchar(255) not null
);


create table users (
   id bigint AUTO_INCREMENT,
   enc_key varchar(1000),
   salt varchar(1000),
   username varchar(200),
   primary key (id)
);


alter table user_x_role
       add constraint unq_user_role unique (user_id, role_id);


alter table user_x_tenant
   add constraint unq_user_tenant unique (user_id, tenant_id);


alter table users
   add constraint unq_user_username unique (username);


alter table user_x_role
   add foreign key fk_user_role_role(role_id)
   references roles(id);


alter table user_x_role
   add constraint fk_user_role_user
   foreign key (user_id)
   references users(id);


alter table user_x_tenant
   add constraint fk_user_tenant_tenant
   foreign key (tenant_id)
   references tenants(id);


alter table user_x_tenant
   add constraint fk_user_tenant_user
   foreign key (user_id)
   references users(id);

--INSERT INTO tenants(`id`, `name`) VALUES ('avalane', 'Avalane Inc.');
--INSERT INTO users(`id`, `username`, `enc_key`, `salt`) VALUES(1, 'username', 'N8X5u89plsOJzo/QC2FXjZyAOa+CZF9krIHXz5iERBil8F6zpZyxgpCi902u9IcQdVDEvDvStPlEHZaq1h245w==', 'tnxRkjrgJ2MVNZQNuuTr5CqFTHoo+0SE80vp6+k+EcYndQLTHvJxGe79InN1fJ06PC9yGHpmJ8SQRql9IHhvzGSIBvEpt4xDrnkCu7VVpqpzpxLYYRc1Fz/SkzoIZtTtrjfSvhxQKW8/sHI+49asL3uPq/wz4oKfxeXjnU/K2sGCLu/yuFT3NcMEeWSgDc8iWoYtOATSyGnrEIaOdYAf6aVQ+YjLkWCQrQNoTIo7XF234LtJBxXJiNer16NM/AUzubLK2UpiB7/qfSI0gsfAkNdclfolFBeTS2I3Ryb8YJQbSFftgvhPaCVljCCjolXUm8nNe3OEtFDAUFdMFTctfeuliVgAAC8PDWQPFFWUbE6qBvC7uHA+agHyGV/4j4TfpzZipFVKZWuevs+/0NAjNzoOZext10q1QM4QAi8LhCS2Y7T4w1AS6h5h+gq6JjMDeS5AY+mglOmhjErcMiWLSXv115ubI8QtTekIMwgU+6f/e3XDlwi/HVQACZKbaxHuiIQSdWo/tgIAVSSNUFSDdo9WA3bGYF2ivFDteWXwsBMJmgpf2whgTUra/aPjqJDkuSz7JgRnuFLUvZA2ifvLQ6f5EyfH9kBKdQgeFFCOeoMhEfiDc5d/eabY/HafkAt59nV6SmYBzyOWdiFd/S2JezQpCLaa8SyMznImSwBDbhg=');
--INSERT INTO users(`id`, `username`, `enc_key`, `salt`) VALUES(2, 'user', 'N8X5u89plsOJzo/QC2FXjZyAOa+CZF9krIHXz5iERBil8F6zpZyxgpCi902u9IcQdVDEvDvStPlEHZaq1h245w==', 'tnxRkjrgJ2MVNZQNuuTr5CqFTHoo+0SE80vp6+k+EcYndQLTHvJxGe79InN1fJ06PC9yGHpmJ8SQRql9IHhvzGSIBvEpt4xDrnkCu7VVpqpzpxLYYRc1Fz/SkzoIZtTtrjfSvhxQKW8/sHI+49asL3uPq/wz4oKfxeXjnU/K2sGCLu/yuFT3NcMEeWSgDc8iWoYtOATSyGnrEIaOdYAf6aVQ+YjLkWCQrQNoTIo7XF234LtJBxXJiNer16NM/AUzubLK2UpiB7/qfSI0gsfAkNdclfolFBeTS2I3Ryb8YJQbSFftgvhPaCVljCCjolXUm8nNe3OEtFDAUFdMFTctfeuliVgAAC8PDWQPFFWUbE6qBvC7uHA+agHyGV/4j4TfpzZipFVKZWuevs+/0NAjNzoOZext10q1QM4QAi8LhCS2Y7T4w1AS6h5h+gq6JjMDeS5AY+mglOmhjErcMiWLSXv115ubI8QtTekIMwgU+6f/e3XDlwi/HVQACZKbaxHuiIQSdWo/tgIAVSSNUFSDdo9WA3bGYF2ivFDteWXwsBMJmgpf2whgTUra/aPjqJDkuSz7JgRnuFLUvZA2ifvLQ6f5EyfH9kBKdQgeFFCOeoMhEfiDc5d/eabY/HafkAt59nV6SmYBzyOWdiFd/S2JezQpCLaa8SyMznImSwBDbhg=');
--INSERT INTO user_x_tenant(`user_id`, `tenant_id`) VALUES (1, 'avalane');
--INSERT INTO user_x_tenant(`user_id`, `tenant_id`) VALUES (2, 'avalane');
--INSERT INTO roles(`id`, `name`) VALUES('ADMIN', 'administrator');
--INSERT INTO user_x_role(`user_id`, `role_id`) VALUES (1, 'ADMIN');