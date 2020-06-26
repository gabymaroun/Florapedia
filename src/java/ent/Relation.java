/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ent;

/**
 *
 * @author Violet
 */
public class Relation {

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
    public int ID;
    Key from,to;

    public Relation(int id,Key from, Key to) {
        this.ID=id;
        this.from = from;
        this.to = to;
    }

    public Relation(Key from, Key to) {
        this.from = from;
        this.to = to;
    }

    public Key getFrom() {
        return from;
    }

    public void setFrom(Key from) {
        this.from = from;
    }

    public Key getTo() {
        return to;
    }

    public void setTo(Key to) {
        this.to = to;
    }

    @Override
    public boolean equals(Object obj) {
        return ((Relation)obj).getTo().equals(this.getTo())&&((Relation)obj).getFrom().equals(this.getFrom()); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String toString() {
        return "Relation{" + "ID=" + ID + ", from=" + from + ", to=" + to + '}';
    }

    
    
    
    
    
}
