/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ent;

import java.sql.Blob;

/**
 *
 * @author Violet
 */
public class Key {

    private int id;
    private String name;
    private Blob image;
    private String type;
    private String description;

    public Key(String name, Blob image, String type, String description) {
        this.name = name;
        this.image = image;
        this.type = type;
        this.description = description;
    }

    public Key(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public Key(int id, String name, String type) {
        this.id = id;
        this.name = name;
        this.type = type;
    }

    public Key() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Blob getImage() {
        return image;
    }

    public void setImage(Blob image) {
        this.image = image;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public boolean equals(Object obj) {
        return ((Key) obj).getId() == this.getId() && ((Key) obj).getName().equals(this.getName());
    }

    @Override
    public String toString() {
        return "Key{" + "id=" + id + ", name=" + name + ", image=" + image + ", type=" + type + ", description=" + description + '}';
    }

    public boolean isTaxon() {
        return this.getType().equals(TypesNames.FAMILY) || this.getType().equals(TypesNames.GENRE) || this.getType().equals(TypesNames.GROUP);
    }

    public boolean isEscpece() {
        return getType().equals(TypesNames.ESPECE);
    }

    public boolean isTransition() {
        return getType().equals(TypesNames.TRANSITION);
    }
}
