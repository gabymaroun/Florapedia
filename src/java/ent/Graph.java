/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ent;

import java.util.ArrayList;

/**
 *
 * @author Violet
 */
public class Graph {

    private int ID;
    private ArrayList<Key> lsk;
    private ArrayList<Relation> lsr;
    private Key root;

    public Graph(Key root) {
        lsk = new ArrayList<>();
        lsk.add(root);
        lsr = new ArrayList<>();
        this.root = root;
    }

    public Graph() {
        lsk = new ArrayList<>();
        lsr = new ArrayList<>();
    }

    public ArrayList<Key> getLsk() {
        return lsk;
    }

    public void setLsk(ArrayList<Key> lsk) {
        this.lsk = lsk;
    }

    public ArrayList<Relation> getLsr() {
        return lsr;
    }

    public void setLsr(ArrayList<Relation> lsr) {
        this.lsr = lsr;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public int getID() {
        return ID;
    }

    public void addKey(Key k) {
        lsk.add(k);
    }

    public void removeKey(Key k) {
        if (lsk.contains(k)) {
            lsk.remove(k);
        }
    }

   /* public void addRelation(int idfrom, int idto) {
        Key from = getKeyInLSK(idfrom);
        Key to = getKeyInLSK(idto);
        if (from != null && to != null) {
            addRelation(new Relation(from, to));
        }

    }*/

    public void addRelation(Relation r) {

        if (!lsr.contains(r)) {
            lsr.add(r);
        }
    }

    /*   public void addRelation(Key from, Key to) {
        Relation r = new Relation(from, to);
        if (!lsr.contains(r)) {
            lsr.add(r);
        }
    }*/

 /*public void removeRelation(Key from, Key to) {
        Relation r = new Relation(from, to);
        if (lsr.contains(r)) {
            lsr.remove(r);
        }
    }*/
    public void removeRelation(Relation r) {

        if (lsr.contains(r)) {
            lsr.remove(r);
        }
    }

    public Relation getRelationOfTo(Key c) {
        for (Relation r : lsr) {
            if (r.getTo().equals(c)) {
                return r;
            }
        }
        return null;
    }

    public String findPath(Key c) {
        Key tmp = c;
        ArrayList<Key> ls = new ArrayList<>();

        while (getRelationOfTo(tmp) != null) {
            ls.add(0, tmp);
            tmp = getRelationOfTo(tmp).getFrom();

        }

        String i = "";
        for (Key Key : ls) {
            i += Key.getDescription() + "/";
        }

        return i;
    }

    public Key getKeyInLSK(int id) {

        for (Key c : lsk) {
            if (c.getId() == id) {
                return c;
            }
        }
        return null;
    }

    public ArrayList<Key> findOptions(Key k) {

        ArrayList<Key> ls = new ArrayList<>();

        for (Relation r : lsr) {
            if (r.getFrom().equals(k)) {
                ls.add(r.getTo());

            }
        }

        return ls;
    }

    public Key getRoot() {
        return root;
    }

    public void setRoot(Key root) {
        
        this.root = root;
        lsk.add(root);
    }

    public boolean contains(int id) {
        for (Key k : lsk) {
            if (k.getId() == id) {
                return true;
            }
        }
        return false;
    }
    public ArrayList<Key> getTaxon(){
        ArrayList<Key> ls=new ArrayList<>();
        for(Key k:lsk){
            if(!k.getType().equals(TypesNames.ROOT)&&!k.getType().equals(TypesNames.ESPECE)&&!k.getType().equals(TypesNames.TRANSITION)){
                ls.add(k);
            }
        }
              ls.remove(root);
        return ls;
    }
    @Override
    public String toString() {
        return "Graph{" + "ID=" + ID + ", lsk=" + lsk + ", lsr=" + lsr + ", root=" + root + '}';
    }

}
